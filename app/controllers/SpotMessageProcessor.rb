class SpotMessageProcessor

  attr_reader :new_messages, :sms_payload

  def initialize
    @new_messages = Array.new
    @sms_payload = Array.new
  end

  def import_spot_messages(messages)
    messages.each do |m|
      if SpotMessage.where(message_id: m[:id]).exists? != true
        SpotMessage.create(
          message_type: m[:messageType],
          latitude: m[:latitude],
          longitude: m[:longitude],
          message_time: m[:dateTime],
          message_id: m[:id],
          message_content: m[:messageContent]
        )
        @new_messages.push m[:id]
      end
    end
  end

  def format_new_messages_to_sms
    sms_to_send = Array.new
    @new_messages.each do |message_id|
      current_message = SpotMessage.find_by_message_id(message_id)
      time_format = "%a, %b %e at %I:%M%P"

      sms_to_send.push(<<~SMSTEXT)
      -- #{SHIP_NAME} Check In --
      Date :#{current_message[:message_time].getlocal.strftime(time_format)}
      Type: #{current_message[:message_type]} 
      Lat/Long: #{current_message[:latitude].to_s} #{current_message[:longitude].to_s} 

      #{current_message.check_in_stats_str}
      SMSTEXT

    end
   @sms_payload = sms_to_send 
  end

  def send_all_pending_to_destination(dest_number, twilio_service)
    @sms_payload.each do |sms|
      twilio_service.send_message(sms,dest_number)
    end
  end
end
