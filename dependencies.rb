ENV['RACK_ENV'] ||= 'development'

require 'rubygems'
require 'bundler'

gems = %w(
  ap
  active_record
  active_support
  pg
  yaml
  sqlite3
  twilio-ruby
)

gems.each { |gem| require gem }

$env = ENV['RACK_ENV']

DB_CONFIG = YAML.load(File.open("config/database.yml"))
ActiveRecord::Base.establish_connection DB_CONFIG[$env]
