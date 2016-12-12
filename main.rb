require './dependencies'

# Require Configuration File
CONFIG = YAML.load_file('./config/api_configurations.yml')

# Require Application Libraries (MVC Loader)
APPLICATION_LIB_DIR = Dir['./app/helpers/*.rb'].sort + Dir['./app/models/**/*.rb'].sort + Dir['./app/controllers/**/*.rb']
APPLICATION_LIB_DIR.each { |file| require file }

@songbird_locations = SpotService.new(spot_feed_id: CONFIG[:spot_feed_id])

def testing_import
  messages = @songbird_locations.messages
  smp = SpotMessageProcessor.new
  smp.import_spot_messages(messages)
end
