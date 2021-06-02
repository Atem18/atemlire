---
title: Python
permalink: "/wiki/python/"

---
## Dedicated subjects

* [Django](/wiki/python/django/)

## Flake8 config file for Black

```ini
[flake8]
max-line-length = 88
select = C,E,F,W,B,B9
ignore = E203, E501, W503
exclude = __init__.py
```

## Generate dynamic dict based on function parameter

```python
async def get_ohlc_data(self, pair: str, interval: int, since=None):
    data = {
        arg: value
        for arg, value in locals().items()
        if arg != "self" and value is not None
    }
    return await self.public_request(endpoint="OHLC", data=data)
```