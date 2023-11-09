---
title: Git
permalink: "/wiki/git/"

---

## Reset git branch into a clean state

```bash
git fetch origin master
git reset --hard FETCH_HEAD
git clean -f -d
```