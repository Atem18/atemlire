---
title: Blog
layout: page
permalink: /blog/
---

Small articles about anything

<ul>
  {% for post in site.posts %}
    <li>
      <a href="{{ post.url }}">{{ post.title }}</a>
    </li>
  {% endfor %}
</ul>