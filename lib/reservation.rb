require_relative "room"
require_relative "date_range"

# Create reservation class
module Hotel
  class Reservation
    
    attr_reader :date_range, :room_number, :cost_per_night, :reservation_number, :total_cost, :block_id
    
    def initialize(date_range:, room_number:, reservation_number: , block_id: 0)
      @date_range = date_range
      @block_id = block_id
      @room_number = room_number
      @reservation_number = reservation_number
      if @block_id == 0
        @cost_per_night = 200
      else
        @cost_per_night = 150
      end
      @total_cost = @cost_per_night * @date_range.number_of_nights
    end
  end
end
# add an attr_reader for each element: date_range, room number, cost per night, booking number, block_id, total cost

# define initialize method with parameters start/end date, room number, cost per night (optional)
