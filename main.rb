require './dependencies'

# Require Configuration File
CONFIG = YAML.load_file('./config/api_configurations.yml')
SHIP_NAME = CONFIG[:ship_name]

# Require Application Libraries (MVC Loader)
APPLICATION_LIB_DIR = Dir['./app/helpers/*.rb'].sort + Dir['./app/models/**/*.rb'].sort + Dir['./app/controllers/**/*.rb']
APPLICATION_LIB_DIR.each { |file| require file }

@twilio_service = TwilioService.new(CONFIG[:twilio])
@songbird_locations = SpotService.new(spot_feed_id: CONFIG[:spot_feed_id])
@smp = SpotMessageProcessor.new

def testing_import
  @smp.import_spot_messages(@songbird_locations.messages)
  @smp.format_new_messages_to_sms
end

def test_send_messages
  @smp.send_all_pending_to_destination(number, @twilio_service)

  numbers = CONFIG[:notification_numbers]
  numbers.each do |number|
    @smp.send_all_pending_to_destination(number, @twilio_service)
  end
end
