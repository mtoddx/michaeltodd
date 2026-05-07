---
layout: default
title: Home
---

<section aria-labelledby="latest-posts-heading">
  <h2 id="latest-posts-heading">Latest Posts</h2>

  <ul class="post-list">
    {% for post in site.posts %}
      <li itemscope itemtype="https://schema.org/BlogPosting">
        <h3>
          <a class="post-link" href="{{ post.url | relative_url }}" itemprop="url">
            <span itemprop="headline">{{ post.title | escape }}</span>
          </a>
        </h3>
        <span class="post-meta">
          <time datetime="{{ post.date | date_to_xmlschema }}" itemprop="datePublished">
            {{ post.date | date: "%B %-d, %Y" }}
          </time>
        </span>
        <div class="post-excerpt" itemprop="description">
          {{ post.excerpt }}
        </div>
      </li>
    {% endfor %}
  </ul>
</section>
