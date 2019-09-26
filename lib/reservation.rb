require_relative "room"
require_relative "date_range"

# Create reservation class
module Hotel
  class Reservation
    
    attr_reader :date_range, :room_number, :cost_per_night, :reservation_number, :block_id, :total_cost
    
    def initialize(date_range:, room_number:, reservation_number: , cost_per_night: 200, block_id: 0)
      @date_range = date_range
      @block_id = block_id
      @room_number = room_number
      @reservation_number = reservation_number
      @cost_per_night = cost_per_night
      @total_cost = @cost_per_night * @date_range.number_of_nights
    end
    
    def includes_date?(date: )
      @date_range.date_range_includes?(date: date)
    end
    
  end
end
