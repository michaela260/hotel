# Create room class

module Hotel
  class Room
    
    attr_reader :room_cost, :room_number
    
    def initialize(room_cost: 200, room_number: )
      
      if room_cost <= 0 || room_cost.class != Float && room_cost.class != Integer
        raise ArgumentError.new "Error! You entered an invalid room cost. Please enter a positive number: "
      elsif room_number <= 0 || room_number.class != Integer
        raise ArgumentError.new "Error! You entered an invalid room"
      end
      
      @room_cost = room_cost
      @room_number = room_number
      
    end
    
    
  end
end

# Add an attr_reader for each attribute

# Define initialize method, including the attributes cost and room number

