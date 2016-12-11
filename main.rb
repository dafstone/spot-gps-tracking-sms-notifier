require './dependencies'

application_lib_dir = Dir['./app/helpers/*.rb'].sort + Dir['./app/models/**/*.rb'].sort + Dir['./app/controllers/**/*.rb']

application_lib_dir.each { |file| require file }
