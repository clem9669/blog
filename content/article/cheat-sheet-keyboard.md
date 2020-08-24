---
title: "Cheat Sheet Keyboard"
date: 2020-08-24T11:50:11+02:00

categories: ["cheatsheet"]
tags: ["keyboard","cheatsheet","setxkbmap"]
author: "Clem"
---

Exploring basic keyboard configuration with Xorg

<!--more-->

The Xorg server uses the X keyboard extension (XKB) to define keyboard layouts.

You can use the following command to see the actual XKB settings: 

### Keyboard Info

```sh
$ setxkbmap -print -verbose 10      
Setting verbose level to 10
locale is C
Trying to load rules file ./rules/evdev...
Trying to load rules file /usr/share/X11/xkb/rules/evdev...
Success.
Applied rules from evdev:
rules:      evdev
model:      pc105
layout:     fr
Trying to build keymap using the following components:
keycodes:   evdev+aliases(azerty)
types:      complete
compat:     complete
symbols:    pc+fr+inet(evdev)
geometry:   pc(pc105)
xkb_keymap {
	xkb_keycodes  { include "evdev+aliases(azerty)"	};
	xkb_types     { include "complete"	};
	xkb_compat    { include "complete"	};
	xkb_symbols   { include "pc+fr+inet(evdev)"	};
	xkb_geometry  { include "pc(pc105)"	};
};
```

Keyboard layout in Xorg can be set in multiple ways. Here is an explanation of used options:

- ***XkbModel*** selects the keyboard model. This has an influence only for some extra keys your keyboard might have. But for instance laptops usually have some extra keys, and sometimes you can make them work by simply setting a proper model.
- ***XkbLayout*** selects the keyboard layout. Multiple layouts may be specified in a comma-separated list, e.g. if you want to quickly switch between layouts.
- ***XkbVariant*** selects a specific layout variant. For instance, the default sk variant is qwertz, but you can manually specify qwerty, etc. It is possible to switch to mac keyboard.
- ***XkbOptions*** contains some extra options (comma-separated). Used for specifying layout switching, notification LED, compose mode etc.

The *layout* name is usually a 2-letter country code following the [*ISO 3166* (wiki)](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2#Officially_assigned_code_elements). To see a full list of keyboard models, layouts, variants and options, along with a short description, open `/usr/share/X11/xkb/rules/base.lst`. Alternatively, you may use one of the following commands to see a list without a description:

```c++
localectl list-x11-keymap-models
localectl list-x11-keymap-layouts
localectl list-x11-keymap-variants [layout]
localectl list-x11-keymap-options
```

## Using setxkbmap

setxkbmap sets the keyboard layout for the current X session only, but can be made persistent in xinitrc or xprofile. This overrides system-wide configuration specified following 

The usage is as follows (see setxkbmap(1)):
```sh
$ setxkbmap [-model xkb_model] [-layout xkb_layout] [-variant xkb_variant] [-option xkb_options]
```
To change just the layout (-layout is the default flag):
```sh
$ setxkbmap xkb_layout
```
For multiple customizations:
```sh
$ setxkbmap -model pc104 -layout cz,us -variant ,dvorak -option grp:alt_shift_toggle
# set pc104 model, cz as primary layout, us as secondary layout, dvorak variant for us layout and the Alt+Shift combination for switching between layouts.
```
Or:
```sh
$ setxkbmap -layout fr -variant mac
```

As said in the previous section, you can find all the model, layout, variant in `/usr/share/X11/xkb/rules/base.lst`.

## Using X configuration files

Note: xorg.conf is parsed by the X server at start-up. To apply changes, restart X.

This method creates system-wide configuration which is persistent across reboots.

Here is an example of `/etc/X11/xorg.conf.d/00-keyboard.conf`

```sh
Section "InputClass"
        Identifier "system-keyboard"
        MatchIsKeyboard "on"
        Option "XkbLayout" "cz,us"
        Option "XkbModel" "pc104"
        Option "XkbVariant" ",dvorak"
        Option "XkbOptions" "grp:alt_shift_toggle"
EndSection
```

## Using localectl

For convenience, the tool **localectl** may be used instead of manually editing X configuration files. It will save the configuration in /etc/X11/xorg.conf.d/00-keyboard.conf.

Note: this file should not be manually edited, because localectl will overwrite the changes on next start.

The usage is as follows:

```sh
$ localectl [--no-convert] set-x11-keymap layout [model [variant [options]]]
```
To set a model, variant or options, all preceding fields need to be specified, but the preceding fields can be skipped by passing an empty string with "". Unless the --no-convert option is passed, the specified keymap is also converted to the closest matching console keymap and applied to the console configuration in vconsole.conf. See localectl(1) for more information.

To create a `/etc/X11/xorg.conf.d/00-keyboard.conf` like the above:

```sh
$ localectl --no-convert set-x11-keymap cz,us pc104 ,dvorak grp:alt_shift_toggle
```

See more at [https://wiki.archlinux.org/index.php/Xorg/Keyboard_configuration](https://wiki.archlinux.org/index.php/Xorg/Keyboard_configuration)