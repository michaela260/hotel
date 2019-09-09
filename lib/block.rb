require_relative 'room'
require_relative 'date_range'
require_relative 'reservation'

module Hotel
  class Block
    
    attr_reader :block_date_range, :collection_of_room_numbers, :discounted_rate, :block_id
    
    def initialize(block_date_range: , collection_of_room_numbers: , discounted_rate: , block_id: )
      @block_date_range = block_date_range
      
      if collection_of_room_numbers.class != Array || collection_of_room_numbers.empty?
        raise ArgumentError.new "Error! You did not provide a valid collection of rooms."
      end
      
      if collection_of_room_numbers.length > 5
        raise ArgumentError.new "Error! A block can only contain up to 5 rooms."
      end
      
      collection_of_room_numbers.each do |number|
        if number.class != Float && number.class != Integer
          raise ArgumentError.new "Error! You did not provide valid room numbers."
        end
      end
      
      @collection_of_room_numbers = collection_of_room_numbers
      
      if discounted_rate.class != Float && discounted_rate.class != Integer || discounted_rate <= 0
        raise ArgumentError.new "Error! You must enter the discounted rate as a positive number."
      end
      @discounted_rate = discounted_rate
      
      @block_id = block_id
    end
    
  end
end