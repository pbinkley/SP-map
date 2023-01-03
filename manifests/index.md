---
title: IIIF Manifests
layout: page
---

{% capture root %}{{ site.url | append: site.baseurl | append: "/manifests/"}}{% endcapture %}
<table>
{% for row in site.data.chapters %}
	<tr>
		<td><a href="{{ row.Chapter }}.json">{{ row.Chapter }}</a></td>
		<td><strong>{{ row.Title }}</strong></td>
		<td>({{ row.End | minus: row.Start | plus: 1 }} pages)</td>
		<td><a href="{{ site.baseurl }}/mirador.html?c={{ row.Chapter | uri_escape }}">Mirador</a></td>
	</tr>
{% endfor %}
</table>
