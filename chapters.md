---
title: Chapters
layout: page
---

<table>
{% for row in site.data.chapters %}
	{% if row['Title'] %}
	<tr>
		<td>{{ row["Chapter"] }}</td>
		<td><strong>{{ row["Title"] }}</strong></td>
		<td>({{ row["End"] | minus: row["Start"] | plus: 1 }} pages)</td>
		<td><a href="{{ site.baseurl }}/mirador.html?c={{ row["Chapter"] | uri_escape }}">Mirador</a></td>
	</tr>
	{% endif %}
	{% for subrow in row["Chapters"] %}
	<!-- subrow -->
		<tr>
			<td>{{ subrow["Chapter"] }}</td>
			<td><strong>{{ subrow["Title"] }}</strong></td>
			<td>({{ subrow["End"] | minus: subrow["Start"] | plus: 1 }} pages)</td>
			<td><a href="{{ site.baseurl }}/mirador.html?c={{ subrow["Chapter"] | uri_escape }}">Mirador</a></td>
		</tr>
	{% endfor %}
{% endfor %}
</table>
