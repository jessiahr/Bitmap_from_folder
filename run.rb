

require 'rubygems'
require 'rmagick'
require 'paleta'



# will store a list of rgb values as arrays inside this array
rawData = [] 
# use the same color for filetypes as we find them
fileStyles = {}
# files that look boring...
ignoredFiles = ['.cache', '']
# the image is a square so this = hight = width 
imageSize = 0
#jumples the rawData but it just looks like static 
shouldShuffle = false

debugOutput = false



Dir['./folder_to_process/**/*'].select{|f| File.file?(f) && ! ignoredFiles.include?(File.extname(f)) }.each do |filePath|
	puts filePath
  File.open(filePath, "r") do |fileHandle|
    fileType = File.extname(fileHandle)
    # if the filetype doesnt have a color yet create one
    if fileStyles[fileType].nil?
      fileStyles[fileType] = [rand(255), rand(255), rand(255)]
    end



    Math.sqrt((File.size(fileHandle) / 1024)).floor.times  do
      c = Paleta::Color.new(fileStyles[fileType][0], fileStyles[fileType][1], fileStyles[fileType][2])

      # tweak here if you want to change the color lightness / darness etc based on file stats
      # rawData.push(c.lighten!(rand(30)).to_array(:rgb) )
      rawData.push(c.to_array(:rgb) )
    end
  end
end

# shuffle the data
if shouldShuffle
  rawData = rawData.shuffle
end

imageSize = Math.sqrt(rawData.length)
data = Array.new(imageSize) do |rowNumber| #row
  Array.new(imageSize) do |colNumber| # col

	rowOffset = rowNumber * imageSize.floor
	position = colNumber + rowOffset

	puts "row:#{rowNumber}}\tcol:#{colNumber}\ttotal:#{rawData.length}" unless debugOutput
	puts "getting:#{position}\trowOffset:#{rowOffset}\n\n" unless debugOutput

 

    rawData[position]
  end
end



img = Magick::Image.new(imageSize, imageSize)

data.each_with_index do |row, row_index|
  row.each_with_index do |item, column_index|
    puts "setting #{row_index}/#{column_index} to #{item}" unless debugOutput
    img.pixel_color(row_index, column_index, "rgb(#{item.join(', ')})")
  end
end
puts fileStyles
img.write("./imgen_output/output.bmp")

