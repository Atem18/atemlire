---
title: Django
permalink: django

---
## Set Django IntegerField by choices=… name
```python
class ThingPriority(models.IntegerChoices):
    LOW = 0, 'Low'
    NORMAL = 1, 'Normal'
    HIGH = 2, 'High'


class Thing(models.Model):
     priority = models.IntegerField(default=ThingPriority.LOW, choices=ThingPriority.choices)


# then in your code
    thing = get_my_thing()
    thing.priority = ThingPriority.HIGH
```