---
title: "Cheat Sheet Date"
date: 2020-07-31T20:13:14+02:00

categories: ["cheatsheet"]
tags: ["date","cheatsheet","man"]
author: "Clem"

---

Review different command to display date and time with a bit of history about epoch time.

<!--more-->

Sometimes printing the date can be a pain due to format, timezone, region.

Two clocks are present on systems: a hardware clock and a **system clock** which is detailed in this article. 

This blog post will review the different way to print a system date on a linux system.

1. Epoch time
2. man date 
3. man timdatectl

---

# Epoch time

#### What is the unix time stamp?

The unix time stamp is a way to track time as a running total of seconds. This count starts at the Unix Epoch on January 1st, 1970 at UTC. Therefore, the unix time stamp is merely the number of seconds between a particular date and the Unix Epoch.

It should also be pointed out that this point in time technically does not change no matter where you are located on the globe. This is very useful to computer systems for tracking and sorting dated information in dynamic and distributed applications both online and client side.

#### What happens on January 19, 2038?

On this date the Unix Time Stamp will cease to work due to a 32-bit overflow. Before this moment millions of applications will need to either adopt a new convention for time stamps or be migrated to 64-bit systems which will buy the time stamp a "bit" 😂 more time.

At 03:33:20 UTC on Wednesday, 18 May 2033, the Unix time value will equal 2000000000 seconds.

#### Hardware clock

The hardware clock (a.k.a. the Real Time Clock (RTC) or CMOS clock) stores the values of: Year, Month, Day, Hour, Minute, and Seconds. Only 2016, or later, UEFI firmware has the ability to store the timezone, and whether DST is used. 

#### System clock

The system clock (a.k.a. the software clock) keeps track of: time, time zone, and DST if applicable. It is calculated by the Linux kernel as the number of seconds since midnight January 1st 1970, UTC. The initial value of the system clock is calculated from the hardware clock, dependent on the contents of /etc/adjtime. After boot-up has completed, the system clock runs independently of the hardware clock. The Linux kernel keeps track of the system clock by counting timer interrupts. 

---

# man date

> The **date** is a command for printing or setting the system date and time.

#### Key command:

- Print date for UTC
```
$date -u 
Fri 31 Jul 18:27:51 UTC 2020
```
- Print date in a format that you like
```
$date +%d-%m-%Y/%H:%M:%S
31-07-2020/20:28:31

$date +'%H:%M:%S %d-%m-%Y'
20:44:15 31-07-2020
```
- Print date as in email (RFC 3339)
```
$date -R
Fri, 31 Jul 2020 20:40:08 +0200
```
- Convert seconds since the epoch (1970-01-01 UTC) to a date
```
$ date --date='@2147483647'
Tue 19 Jan 04:14:07 CET 2038

$date +%s
1596221384
```
- Show the local time for 9AM next Friday on the west coast of the US
```
$ date --date='TZ="America/Los_Angeles" 09:00 next Fri'
Fri  7 Aug 18:00:00 CEST 2020
```
---

# man timedatectl

> The **timedatectl** is a command for controlling the system time and date.

- Read clock
```
$ timedatectl
               Local time: Sat 2020-08-22 17:06:26 CEST
           Universal time: Sat 2020-08-22 15:06:26 UTC 
                 RTC time: Wed 2020-07-08 22:20:55     
                Time zone: Europe/Berlin (CEST, +0200) 
System clock synchronized: no                          
              NTP service: n/a                         
          RTC in local TZ: no 
```

- Set system clock directly:
```
# timedatectl set-time "yyyy-MM-dd hh:mm:ss"

# timedatectl set-time "2014-05-26 11:13:54"
```

#### Time zone

- To check the current zone defined for the system:
```
$ timedatectl status
               Local time: Sat 2020-08-22 17:06:26 CEST
           Universal time: Sat 2020-08-22 15:06:26 UTC 
                 RTC time: Wed 2020-07-08 22:20:55     
                Time zone: Europe/Berlin (CEST, +0200) 
System clock synchronized: no                          
              NTP service: n/a                         
          RTC in local TZ: no 
```
- To list available zones:
```
$ timedatectl list-timezones
```
- To set your time zone:
```
# timedatectl set-timezone Canada/Eastern
```
This will create an /etc/localtime symlink that points to a zoneinfo file under /usr/share/zoneinfo/. In case you choose to create the link manually (for example during chroot where timedatectl will not work), keep in mind that it must be a symbolic link, as specified in archlinux(7):

```
# ln -sf /usr/share/zoneinfo/Zone/SubZone /etc/localtime
```

Tip: The time zone can also be selected interactively with **tzselect**.

