---
title: Chapter Manifests
layout: page
---

{% capture root %}{{ site.url | append: site.baseurl | append: "/chapter-manifests/"}}{% endcapture %}
<ul>
{% for row in site.data.chapters %}
	<li><a href="{{ row.Chapter }}.json">{{ row.Chapter }}</a> ({{ row.End | minus: row.Start | plus: 1 }} pages)
		<a href="{{ site.baseurl }}/mirador.html?manifest={{ root | append: row.Chapter | append: '.json' | uri_escape }}">Mirador</a></li>
{% endfor %}
</ul>