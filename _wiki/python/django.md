---
title: Django
permalink: "/wiki/python/django/"

---

## Order of model inner classes and standard methods

The order of model inner classes and standard methods should be as follows (noting that these are not all required):

- All database fields
- Custom manager attributes
- class Meta
- def __str__()
- def save()
- def get_absolute_url()
- Any custom methods

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
