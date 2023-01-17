#!/usr/bin/env ruby

require 'json'
require 'byebug'

indexes = "789".split("")
spacer = "  "

indexes.each do |index|
	data = JSON.parse(File.read("index-#{index}.json"))
	data.sort! { |a,b| a['sort_parts'] <=> b['sort_parts'] }
	previous_citation = ["", "", ""]
	references = []
	File.open("list#{index}.md", "w+", lf_newline: true) do |f|
  		data.each do |entry|
			# if same as previous citation, just add reference to references
  			unless entry['citation'] == previous_citation
  				# new citation, so output references and close line
  				f.write(': ' + references.join(', ') + "\n") unless references == []
  				references = []
				# discover first different element in citation array
				indent = ""
				i = 0
				while entry['citation'][i] == previous_citation[i] do 
					indent += spacer
					i += 1
					break if i == 4
				end
				outputs = []
				while i <= 3 do
					# for each remaining part, print line with appropriate initial indent
					# and a dash
					break unless entry['citation'][i] # no part - original had less than 4 parts
					if entry['citation'][i] != ""
						outputs << indent + " - " + entry['citation'][i]
						indent += spacer
					end
					i += 1
				end
				outputs.each_with_index do |output, index|
					f.write(output.gsub('*', '\*')) # escape *, for markdown context
					f.write("\n") unless index == outputs.size - 1
				end
			end
			references << "[#{entry['ref']}#{entry['asterisk'] == '*' ? '\*' : ''}](../mirador.html?c=#{entry['unit']}&p=#{entry['para']})"
  			previous_citation = entry['citation']
  		end
	end


end
