---
title: Chapter Manifests
layout: page
---

<ul>
{% for row in site.data.chapters %}
	<li><a href="{{ row.Chapter}}.json">{{ row.Chapter}}</a> ({{ row.End | minus: row.Start | plus: 1 }} pages)</li>
{% endfor %}
</ul>