require 'optparse'
require './lib/nasa'

options = {}

OptionParser.new do |opts|
  opts.banner = 'Usage: app.rb --file=file_path'

  opts.on('-fPath', '--file=Path', 'File path') do |v|
    options[:file] = v
  end
end.parse!

result = Nasa.new(options[:file]).rovers

result.each do |rover|
  puts rover.execute
end