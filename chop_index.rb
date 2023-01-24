#!/usr/bin/env ruby

require 'byebug'

old_initial = ""
initial = ""
output = {}

File.foreach('list7.md', lf_newline: true) do |line|
	if line[0..1] == '  '
		output[initial] << line
	else 
		initial = line[3].upcase
		if initial != old_initial
			puts initial
			output[initial] = []
			old_initial = initial
		end
		output[initial] << line
	end
end

output.keys.each do |initial|
	puts initial
	File.open("../SP-map_pages/sections/#{initial}.md", "w", lf_newline: true) do |f|
		f.puts "---\nlayout: page\ntitle: \"Index: #{initial}\"\n---\n\n"
		f.puts ""
		output[initial].each { |line| f.write(line) }
	end
end

puts 'done'