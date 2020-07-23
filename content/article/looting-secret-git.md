---
title: "Looting Secret in GIT"
date: 2020-07-23T14:23:05+02:00

categories: ["OSINT"]
tags: ["osint","shhgit","github","leak","gitleak","tools","trufflehog"]
author: "clem"

---

There are tools which work remotely and locally for finding potentially sensitive files pushed to public repos.

<!--more-->

I will compare the best of 3 tools (*imo*) for secret findings, usefull in OSINT context :
- [SHHGIT](https://clem9669.github.io/blog/article/looting-secret-git/#SHHGIT)
- [GitLeaks](https://clem9669.github.io/blog/article/looting-secret-git/#GitLeaks)
- [truffleHog](https://clem9669.github.io/blog/article/looting-secret-git/#truffleHog)

---


# 1. [SHHGIT](#SHHGIT)

> Identify secret tokens within committed code in real-time:
> https://shhgit.darkport.co.uk/

[![SHHGIT](https://raw.githubusercontent.com/eth0izzle/shhgit/master/images/shhgit.png)](https://github.com/eth0izzle/shhgit)

shhgit can work in two ways: through the GitHub, GitLab and BitBucket public repoistorties or by processing files in a local directory.
This is really nice for realtime analysis and demo because it is a live scan.
It also finds secrets across ***GitHub (including Gists), GitLab and BitBucket***.

You can find the live scanning at [https://shhgit.darkport.co.uk/](https://shhgit.darkport.co.uk/)

However, if you focus on a repo or user, you won't be able to do much. This is where the two others become handy.

**Installation:** 
- Docker
- GO

**Screenshots**

![](https://raw.githubusercontent.com/eth0izzle/shhgit/master/images/shhgit-live-example.png)


# 2. [GitLeaks](#GitLeaks)

> Gitleaks aims to be the easy-to-use, all-in-one solution for finding secrets, past or present, in your code:
> https://github.com/zricethezav/gitleaks

[![GitLeaks](https://raw.githubusercontent.com/zricethezav/gifs/master/gitleakslogo.png)](https://github.com/zricethezav/gitleaks)

Gitlab and Github API support which allows scans of whole organizations, users, and pull/merge requests


**Installation:**
- Brew
- Docker
- GO

**Screenshot:** 
```sh
~  gitleaks --repo=gitleaks --repo=https://github.com/gitleakstest/gronit.git --verbose --pretty
INFO[2020-04-28T13:00:34-04:00] cloning... https://github.com/gitleakstest/gronit.git
Enumerating objects: 135, done.
Total 135 (delta 0), reused 0 (delta 0), pack-reused 135
{
        "line": "const AWS_KEY = \"AKIALALEMEL33243OLIAE\"",
        "offender": "AKIALALEMEL33243OLIA",
        "commit": "eaeffdc65b4c73ccb67e75d96bd8743be2c85973",
        "repo": "gronit.git",
        "rule": "AWS Manager ID",
        "commitMessage": "remove fake key",
        "author": "Zachary Rice",
        "email": "zricethezav@users.noreply.github.com",
        "file": "main.go",
        "date": "2018-02-04T19:43:28-06:00",
        "tags": "key, AWS"
}
...
...
WARN[2020-04-28T13:00:35-04:00] 6 leaks detected. 33 commits audited in 77 milliseconds 738 microseconds
```


# 3. [truffleHog](#truffleHog)

> GSearches through git repositories for secrets, digging deep into commit history and branches:
> https://github.com/dxa4481/truffleHog

[![truffleHog](https://avatars2.githubusercontent.com/u/15876092?s=200&v=4)](https://github.com/dxa4481/truffleHog)

Gitlab and Github API support which allows scans of whole organizations, users, and pull/merge requests


**Installation:**
- Pip
- Docker

**Screenshot:** 

![](https://camo.githubusercontent.com/3972f94b479bb40fb690e2cadcd3dd14ab3c3073/68747470733a2f2f692e696d6775722e636f6d2f5941586e644c442e706e67)

---

## Conclusion:

**Gitleaks** has the biggest amount of stars between the projects for looting juicy stuff around Github.

It justifies well because it has key abilities for professionals as *scanning users or organisations*. It is all-in-one with a great modulable configuration (as truffleHog).

The cons might be the fact that is built in GO and the neglect of all the secret present in Gitlab, which *Shhgit* didn't forget.