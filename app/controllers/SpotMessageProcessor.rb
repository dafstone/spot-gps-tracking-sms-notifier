class SpotMessageProcessor
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
      end
    end
  end
end
