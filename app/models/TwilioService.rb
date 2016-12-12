class TwilioService
  def initialize(params = {})
    @account_sid = params.fetch(:account_sid)
    @auth_token = params.fetch(:auth_token)
    @outgoing_number = params.fetch(:outgoing_number)

    @twilio_client = Twilio::REST::Client.new @account_sid, @auth_token
  end

  def send_message(sms_message_body, sms_destination_number)
    @twilio_client.messages.create(
      from: @outgoing_number,
      to: sms_destination_number,
      body: sms_message_body
    )
  end
end

