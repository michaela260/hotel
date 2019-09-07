# Create room class

module Hotel
  class Room
    
    attr_reader :room_number
    
    def initialize(room_number: )
      
      if room_number <= 0 || room_number.class != Integer
        raise ArgumentError.new "Error! You entered an invalid room"
      end
      
      @room_number = room_number
      
    end
    
    
  end
end

# Add an attr_reader for each attribute

# Define initialize method, including the attributes cost and room number

