---
title: Index
permalink: "/wiki/python/"

---
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