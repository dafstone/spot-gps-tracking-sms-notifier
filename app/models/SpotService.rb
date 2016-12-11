class SpotService
  require 'net/http'
  require 'json'

  attr_reader :spot_raw_response, :messages, :current_time

  def initialize(params = {})
    spot_feed_id = params.fetch(:spot_feed_id)
    spot_uri = URI("https://api.findmespot.com/spot-main-web/consumer/rest-api/2.0/public/feed/#{spot_feed_id}/message.json")

    @spot_raw_response = JSON.parse(Net::HTTP.get(spot_uri))["response"]
    @messages = @spot_raw_response["feedMessageResponse"]["messages"]["message"]
    @fetched_time = Time.now
  end

  def feed_info
    feed_message_response = @spot_raw_response["feedMessageResponse"]
    feed_info = Hash.new

    %w( count id name status daysRange ).each do |item|
      feed_info[item.to_sym] = feed_message_response[item]
      if feed_info[item.to_sym] == nil
        feed_info[item.to_sym] = feed_message_response["feed"][item]
      end
    end

    feed_info[:fetched_time] = @fetched_time

    return feed_info
  end

end
