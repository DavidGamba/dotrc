#!/usr/bin/env ruby
# add current dir to the path
$LOAD_PATH << File.join(File.dirname(__FILE__))

require 'fileutils'
require 'ruby-getoptions'

# Only run the following code when this file is the main file being run
# instead of having been required or loaded by another file
if __FILE__ == $PROGRAM_NAME
  options, remaining = GetOptions.parse(ARGV,
    'test=s' => :test
  )
end
