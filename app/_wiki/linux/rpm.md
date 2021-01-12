---
title: RPM
permalink: /wiki/linux/rpm/
---
## Packaging

### Download sources of SPEC file

```bash
spectool -g -R my-package.spec
```

### Install dependencies of SPEC file

Ensure dnf-plugins-core is installed

```bash
dnf builddep my-package.spec
```

### Build package of SPEC file

```bash
rpmbuild -ba my-package.spec
```