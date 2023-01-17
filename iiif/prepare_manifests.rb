#!/usr/bin/env ruby 

require 'json'
require 'csv'

require 'byebug'

collection = {
	"@context": "http://iiif.io/api/presentation/2/context.json",
	"@id": "{{ site.url }}{{ site.baseurl }}/manifests/collection.json",
	"@type": "sc:Collection",
	"label": "Summa Praedicantium chapters (Amerbach edition)",
	"manifests":[]
}

manifest = JSON.parse(File.read('manifest.json'))
canvases = manifest['sequences'].first.delete('canvases')

chapters =  CSV.parse(File.read("../../SP-map/_data/chapters.csv"), headers: true)
chapters.each do |chapter|
	sequence = canvases[(chapter['Start'].to_i-1..chapter['End'].to_i-1)]
	puts "#{chapter['Chapter']}: #{sequence.count}"

# Add annotation links:
=begin
	"otherContent":
	[
	    {
	        "@id": "{{ site.url }}{{ site.baseurl }}/annotations/A.2/82.json",
	        "@type": "sc:AnnotationList",
	        "label": "Articles and Paragraphs"
	    }
	]
=end

	if chapter['Annotated'] == 'true'
		sequence.each do |canvas|
			canvas["otherContent"] =
			[
			    {
			        "@id": "{{ site.url }}{{ site.baseurl }}/annotations/#{chapter['Chapter']}/#{canvas['label']}.json",
			        "@type": "sc:AnnotationList",
			        "label": "Articles and Paragraphs"
			    }
			]
		end
	end

	chapter_manifest = manifest.dup
	chapter_manifest['@id'] = "{{ site.url }}{{ site.baseurl }}/manifests/#{chapter['Chapter']}.json"
	chapter_manifest['label'] = "Summa Praedicantium: #{(chapter['Chapter'] + " ") unless chapter['Chapter'] == 'Prol'}" + "#{chapter['Title']}"
	chapter_manifest['sequences'] = [{
		"@type": "sc:Sequence",
		"canvases": sequence
	}]

	File.open("../../SP-map/manifests/#{chapter['Chapter']}.json","w") do |f|
	  f.write("---\n---\n\n")
	  f.write(chapter_manifest.to_json)
	end
	collection[:manifests] << {
        "@type": "sc:Manifest",
        "@id": "{{ site.url }}{{ site.baseurl }}/manifests/#{chapter['Chapter']}.json",
        "label": "Summa Praedicantium, #{chapter['Chapter']}: #{chapter['Title']}"
    }

end

File.open("../../SP-map/collection.json","w") do |f|
	f.write("---\n---\n\n")
	f.write(collection.to_json)
end

puts 'done'
