class SpotService
  require 'net/http'
  require 'json'

  attr_reader :spot_response

  def initialize(params = {})
    spot_feed_id = params.fetch(:spot_feed_id)
    spot_uri = URI("https://api.findmespot.com/spot-main-web/consumer/rest-api/2.0/public/feed/#{spot_feed_id}/message.json")

    @spot_response = JSON.parse(Net::HTTP.get(spot_uri))
  end

  def current_status
    @spot_response
  end

end
