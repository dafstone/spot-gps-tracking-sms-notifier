require 'rubygems'
require 'bundler'

gems = %w(
  ap
  active_record
  active_support
  pg
  yaml
)

gems.each { |gem| require gem }
