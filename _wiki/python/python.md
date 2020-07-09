---
title: Index

---
## How to solve PyLint “Unable to import” error

Create a file called ~/.pylintrc and put the following content

```ini
[MASTER\]
init-hook="from pylint.config import find_pylintrc; import os, sys; sys.path.append(os.path.dirname(find_pylintrc()))"
```