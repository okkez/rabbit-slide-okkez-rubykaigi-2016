require "optparse"
require "cairo"
require "gdk_pixbuf2"

output = nil
size = nil
x_offset = nil
y_offset = nil
per = nil

parser = OptionParser.new
parser.on("-o", "--output=FILE", "Output filename") do |f|
  output = f
end
parser.on("--size=SIZE", "Image size", Float) do |s|
  size = s
end
parser.on("--x-offset=OFFSET", "X offset", Integer) do |v|
  x_offset = v
end
parser.on("--y-offset=OFFSET", "Y offset", Integer) do |v|
  y_offset = v
end
parser.on("--per=NUM", "Number of images per a row", Integer) do |v|
  per = v
end

begin
  parser.parse!(ARGV)
rescue OptionParser::ParseError => ex
  $stderr.puts ex.message
  exit(false)
end

Cairo::ImageSurface.new(960, 540) do |surface|
  avatars = ARGV.map do |input|
    Cairo::ImageSurface.from_png(input)
  end

  context = Cairo::Context.new(surface)

  context.set_source_color("#ffffff")
  context.paint

  avatars.each_slice(per).with_index do |row, y|
    row.each_with_index do |avatar, x|
      context.save do
        context.translate(size * x + x_offset, size * y + y_offset)
        context.set_source(avatar)
        context.move_to(size * x + x_offset, size * y + y_offset)
        context.paint
      end
    end
  end

  surface.write_to_png(output)
end


