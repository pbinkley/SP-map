---
title: Index Sections
layout: page
---

<ul>
{% for row in site.data.sections %}
	<li><a href="{{ row.Initial}}.html">{{ row.Initial}}</a></li>
{% endfor %}
</ul>