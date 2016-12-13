require './main'

twilio_service = TwilioService.new(CONFIG[:twilio])
songbird_locations = SpotService.new(spot_feed_id: CONFIG[:spot_feed_id])
smp = SpotMessageProcessor.new
numbers = CONFIG[:notification_numbers]

smp.import_spot_messages(songbird_locations.messages)
smp.format_new_messages_to_sms

numbers.each do |dest_number|
  smp.send_all_pending_to_destination(dest_number, twilio_service)
end
