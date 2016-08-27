require "optparse"
require "gdk_pixbuf2"

output = nil
width = nil
height = nil

parser = OptionParser.new
parser.on("-o", "--output=FILE", "Output filename") do |f|
  output = f
end
parser.on("-w", "--width=WIDTH", "Image width", Float) do |w|
  width = w
end
parser.on("-h", "--height=HEIGHT", "Image height", Float) do |h|
  height = h
end

begin
  parser.parse!(ARGV)
rescue OptionParser::ParseError => ex
  $stderr.puts ex.message
  exit(false)
end

ARGV.each do |input|
  output = input.sub(/\.[^.]+$/i, ".png")
  pixbuf = GdkPixbuf::Pixbuf.new(file: input)
  new_pixbuf = pixbuf.scale_simple(width, height, :bilinear)
  new_pixbuf.save(output, "png")
end
