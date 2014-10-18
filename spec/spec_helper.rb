require 'typekit_cli'
load 'bin/typekit'

#require all shared specs in the shared directory
Dir[File.join(File.dirname(__FILE__), 'shared/**/shared_*.rb')].each { |f| require File.expand_path(f) }