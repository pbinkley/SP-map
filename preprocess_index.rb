#!/usr/bin/env ruby

require 'json'
require 'byebug'

indexes = "789".split("")

indexes.each do |index|
	records = []
	files = []
	max = 0
	Dir.glob("Index/*.x#{index}f") do |file|
		files << file
	end
	files.sort.each do |file|
		article = file.match(/Index\/(.+)\.x[789]f/)[1].split('-').last.upcase
		label = article.sub(/^(.)0?(\d+)/, '\1.\2').sub('0PROL', 'Prol')
		# puts "Opening #{article}"
		File.open(file, :encoding => 'Windows-1252').readlines.each do |line|
			line.strip!
			line.gsub!('\®MDIT\¯(.+?)\®MDNM\¯'.encode(Encoding::Windows_1252), "_\1_")
			line.gsub!("\u0015", "§")
			alpha = line.split("\u001F")
			beta = alpha.first.split("\a")
			gamma = beta.first.split("\t")
			gamma.delete("") # remove empty elements
			delta = gamma.first.match(/^(\*?)(.*)/)
			para = alpha.last
			record = {
				unit: label,
				ref: "#{label}.#{para}".sub('0PROL', 'Prol'),
				ref_sort: "#{article}#{para.rjust(3, "0")}",
				asterisk: delta[1],
				citation: [delta[2]] + gamma.drop(1),
				num: beta.last.to_i,
				para: para.to_i
			}
			record[:citation].each do |part|
				max = part.length if part.length > max
			end
			# we use % as separator so that it will sort before everything, so 1% comes before 1.2%
			parts = record[:citation]
				.map {|x| x.gsub(/[[:punct:]]/, ' ')}
				.map {|x| x.gsub(/\ +/, ' ')}
				.map {|x| x.strip.upcase }
				.map do |x|
					y = x.split(/(\d+)/)
					i = 0
					while i < y.count do 
						if y[i].match(/\d+/)
							y[i] = y[i].rjust(10,'0')
						end
						i += 1
					end
					y
				end
				.map {|x| x.join }
			while parts.length < 3 do parts += [''] end
			record[:sort_parts] = parts
			record[:sort_str] = parts.join(" ")
			records << record
		end
	end

	File.write("./index-#{index}.json", JSON.pretty_generate(records).encode('utf-8'))
	puts "#{index}: #{records.count}"
	puts "max: #{max}"
end