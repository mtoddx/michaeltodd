---
layout: default
title: Home
---

## Latest Research & Posts

<ul class="post-list">
  {% for post in site.posts %}
    <li>
      <h3>
        <a class="post-link" href="{{ post.url | relative_url }}">{{ post.title | escape }}</a>
      </h3>
      <span class="post-meta">{{ post.date | date: "%B %-d, %Y" }}</span>
      <div class="post-excerpt">
        {{ post.excerpt }}
      </div>
    </li>
  {% endfor %}
</ul>
