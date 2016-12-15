class SpotMessage < ActiveRecord::Base
  def geoloc
    Geokit::GeoLoc.new(lat: self[:latitude], lng: self[:longitude])
  end

  def self.order_by_date_sent
    all.sort_by(&:message_time)
  end

  def find_previous_message
    messages = SpotMessage.order_by_date_sent
    my_message_id = self[:message_id]
    previous_index = 0
    
    messages.each_with_index do |message, index|
      if my_message_id == message[:message_id]
        previous_index = index - 1
      end
    end
    return messages[previous_index]
  end

  def check_in_stats
    stats = Hash.new

    current_location = self.geoloc
    previous_location = self.find_previous_message.geoloc

    stats[:distance_travelled] = current_location.distance_to(previous_location).round(2)
    stats[:time_travelled] = ((self[:message_time] - self.find_previous_message[:message_time]) / 1.hour).round(2)
    stats[:nms_per_hour] = (stats[:distance_travelled] / stats[:time_travelled]).round(2)
    
    return stats
  end

  def self.trip_stats
    trip_current = order_by_date_sent
    time_format = "%a, %b %e at %I:%M%P"

    trip_current.each do |check_in|
      puts %Q{Time: #{check_in[:message_time].getlocal.strftime(time_format)}, 
      Location: #{check_in.geoloc.ll}
      Distance Travelled: #{check_in.check_in_stats[:distance_travelled]}#{Geokit::default_units.to_s}
      Time Travelled: #{check_in.check_in_stats[:time_travelled]}hrs
      Avg speed: #{check_in.check_in_stats[:nms_per_hour]}nms/hour
      }
    end
  end


end
