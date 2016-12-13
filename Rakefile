require 'rake'
require './main'

namespace :db do
  desc "Run migrations"
  task :migrate do
    ActiveRecord::Migrator.migrate('db/migrate')
  end
end

namespace :nofifier do
  desc "Create and send new notifications"
  task :create_and_send do

    @smp.import_spot_messages(@songbird_locations.messages)
    @smp.format_new_messages_to_sms

    numbers = CONFIG[:notification_numbers]
    if @smp.new_messages.any? == true
      numbers.each do |dest_number|
        @smp.send_all_pending_to_destination(dest_number, @twilio_service)
        puts "Sent message to #{dest_number}"
      end
    else
      puts "No new messages to send"
    end
  end
end
