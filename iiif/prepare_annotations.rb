#!/usr/bin/env ruby

require 'json'
require 'fileutils'
require 'byebug'

# Iterate through files in annotations/<chapter code>

# Get page number from 
#   "full": "https://permalinkbnd.bnportugal.gov.pt/iiif/69702/canvas/83"

# Change annotation @id field from "http://localhost:8888/annotation/1672376028704"
# to "{{ site.url }}{{ site.baseurl }}/annotations/<chapter code>/<page number>.json"

# Remove annotations that don't belong to this chapter

# Write to SP-map/annotations/<chapter code>/<page number>.json

chapter_code = ARGV[0]
puts chapter_code
Dir.glob("annotations/#{chapter_code}/*.json") do |annolist|
	data = JSON.parse(File.read(annolist))
	page_number = data['resources'].first['on'].first['full'].split('/').last
	new_resources = []
	unique_annos = {} # used to dedupe, since I can't get sas to delete
	data['resources'].each do |anno|
		#byebug
		puts anno['resource'].first["http://dev.llgc.org.uk/sas/full_text"]
		ref = anno['resource'].first["http://dev.llgc.org.uk/sas/full_text"]
		next unless ref.start_with?(chapter_code + '.') | ref.start_with?(chapter_code + ' Art.')

		puts 'processing'
		anno_key = ref.gsub(' ', '.')
		puts "anno_key: #{anno_key}"
		anno['@id'] = "{{ site.url }}{{ site.baseurl }}/annotations/#{chapter_code}/#{page_number}/#{anno_key}"
		anno['on'].first['selector']['item']['value'].gsub!('stroke-width="1"','stroke-width="3"')
		unique_annos[anno_key] = anno
	end

	unique_annos.keys.sort.each do |anno_key|
		new_resources << unique_annos[anno_key]
	end

	data['resources'] = new_resources
	output = data.to_json
	outputdir = "../../SP-map/annotations/#{chapter_code}"
	FileUtils.mkdir_p(outputdir)
	File.open("#{outputdir}/#{page_number}.json", 'w') { |file| file.write("---\n---\n#{output}") }
end