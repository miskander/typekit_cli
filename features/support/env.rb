$:.push File.dirname(__FILE__)

require 'cucumber'
require 'aruba/cucumber'
require 'fileutils'

Before do
  #Set the aruba directories
  @dirs = [File.expand_path(File.join(File.dirname(__FILE__), '../..'))]

  #Create a fake home directory for the test suit.
  set_env 'HOME', File.expand_path(File.join(current_dir, 'home'))
  FileUtils.mkdir_p ENV['HOME']
end

After do
  #Clean up the fake home directory after the tests are done.
  FileUtils.rm_f ENV['HOME']
end