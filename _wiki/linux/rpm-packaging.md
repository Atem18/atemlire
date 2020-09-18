---
title: RPM packaging

---
## Download sources of SPEC file
```bash
spectool -g -R
```

## Install dependencies of SPEC file

Ensure dnf-plugins-core is installed

```bash
dnf builddep my-package.spec
```