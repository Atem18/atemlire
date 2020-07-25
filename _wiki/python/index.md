---
title: Index

---
## How to solve PyLint “Unable to import” error

Create a file called .env at the top most of your project and put the following content

```ini
PYTHONPATH=./project:${PYTHONPATH}
```

Replace project by your name where your python code is and you're done !