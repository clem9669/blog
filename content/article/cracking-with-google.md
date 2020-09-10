---
title: "Cracking With Google servers"
date: 2020-09-10T11:28:57+02:00

categories: ["cracking"]
tags: ["cracking","google","penglab","ipynb","hashcat","john"]
author: "Clem"

---

From this github https://github.com/mxrch/penglab, it learnt that it is possible to crack password on Google infrastructure.

	x100 faster than in VM

<!--more-->

The github https://github.com/mxrch/penglab explain how to abuse of Google Colab for fun and profit.

---

## Cheat-sheet command

GOTO: https://colab.research.google.com/github/mxrch/penglab/blob/master/penglab.ipynb

- Set *hashcat* to TRUE
- Set *rockyou* to TRUE
- Lookup for module in [hashcat exemple](https://hashcat.net/wiki/doku.php?id=example_hashes)

```sh
!wget https://raw.githubusercontent.com/hashcat/hashcat/master/rules/InsidePro-PasswordsPro.rule
!ls -la
!echo 'HASH_here' >> hash
!hashcat -m MODULE hash wordlists/rockyou.txt -r InsidePro-PasswordsPro.rule -O
```

---

# What is it ?

Penglab is a ready-to-install setup on Google Colab for cracking hashes with an incredible power, really useful for CTFs. (See benchmarks below.)


It installs by default :

- Hashcat
- John
- Hydra
- SSH (with ngrok)

And now, it can also :

- Launch an integrated shell
- Download the wordlists Rockyou and HashesOrg2019 quickly !

You only need a Google Account to use Google Colab, and to use ngrok for SSH (optional).

## How to use it ?

1. Go on : https://colab.research.google.com/github/mxrch/penglab/blob/master/penglab.ipynb
1. Select "Runtime", "Change runtime type", and set "Hardware accelerator" to GPU.
1. Change the config by setting "True" at tools you want to install.
1. Select "Runtime" and **"Run all"** !


![](https://cloud.screenpresso.com/aZURb/2020-09-10_11h26_39.png)

![](https://cloud.screenpresso.com/JF0uc/2020-09-10_11h41_56.png)

## Benchmark

From what i have tested it is 100 times faster than in my VM.

### Hashcat Benchmark :


	====================
	* Device #1: Tesla P100-PCIE-16GB, 16017/16280 MB, 56MCU

	OpenCL API (OpenCL 1.2 CUDA 10.1.152) - Platform #1 [NVIDIA Corporation]
	========================================================================
	* Device #2: Tesla P100-PCIE-16GB, skipped

	Benchmark relevant options:
	===========================
	* --optimized-kernel-enable

	Minimum password length supported by kernel: 0
	Maximum password length supported by kernel: 55

	Hashmode: 0 - MD5

	Speed.#1.........: 27008.0 MH/s (69.17ms) @ Accel:64 Loops:512 Thr:1024 Vec:8

	Minimum password length supported by kernel: 0
	Maximum password length supported by kernel: 55

	Hashmode: 100 - SHA1

	Speed.#1.........:  9590.3 MH/s (48.61ms) @ Accel:8 Loops:1024 Thr:1024 Vec:1

	Minimum password length supported by kernel: 0
	Maximum password length supported by kernel: 55


### Speedtest :

	Testing from Google Cloud (35.203.136.151)...
	Retrieving speedtest.net server list...
	Selecting best server based on ping...
	Hosted by KamaTera INC (Santa Clara, CA) [11.95 km]: 28.346 ms
	Testing download speed................................................................................
	Download: 2196.68 Mbit/s
	Testing upload speed......................................................................................................
	Upload: 3.87 Mbit/s
