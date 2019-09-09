require_relative 'room'
require_relative 'date_range'
require_relative 'reservation'

# method reserve_block (creates instance of block)

module Hotel
  class Manager
    attr_reader :list_of_all_rooms, :list_of_all_reservations, :list_of_all_blocks
    
    def initialize
      list_of_all_rooms = []
      
      20.times do |i|
        new_room = Hotel::Room.new(room_number: i + 1)
        list_of_all_rooms << new_room
      end
      
      @list_of_all_rooms = list_of_all_rooms
      @list_of_all_reservations = []
      @list_of_all_blocks = []
    end
    
    def make_reservation(start_date: , end_date: )
      
      new_date_range = Hotel::DateRange.new(start_date: start_date, end_date: end_date)
      possible_room_numbers = (1..20).to_a
      @list_of_all_reservations.each do |reservation|
        if reservation.date_range.overlap?(new_date_range)
          possible_room_numbers.delete(reservation.room_number)
        end
      end
      @list_of_all_blocks.each do |block|
        if block.block_date_range.overlap?(new_date_range)
          block.collection_of_room_numbers.each do |room_number|
            possible_room_numbers.delete(room_number)
          end
        end
      end
      if possible_room_numbers.empty?
        raise ArgumentError.new "Error! All rooms are reserved during the date range you requested. Sorry :("
      end
      new_room_number = possible_room_numbers.first
      new_reservation_number = @list_of_all_reservations.length + 100
      
      new_reservation = Hotel::Reservation.new(date_range: new_date_range, room_number: new_room_number, reservation_number: new_reservation_number)
      @list_of_all_reservations << new_reservation
      
      return new_reservation
    end
    
    def list_of_reservations_by_date(date_to_search: )
      list_of_reservations_by_date = []
      @list_of_all_reservations.each do |reservation|
        if reservation.date_range.date_range_includes?(date: date_to_search)
          list_of_reservations_by_date << reservation
        end
      end
      
      return list_of_reservations_by_date
    end
    
    def find_room(room_number_to_search)
      if room_number_to_search < 1 || room_number_to_search > 20 || room_number_to_search.class != Integer
        raise ArgumentError.new "Error! You entered an invalid room number: #{room_number_to_search}"
      end
      
      return @list_of_all_rooms.find { |room| room.room_number == room_number_to_search }
    end
    
    def find_reservation(reservation_number_to_search)
      indicator = 0
      @list_of_all_reservations.each do |reservation|
        if reservation.reservation_number != reservation_number_to_search
          indicator += 1
        end
      end
      
      if indicator == @list_of_all_reservations.length
        raise ArgumentError.new "Error! You entered an invalid reservation number: #{reservation_number_to_search}"
      end
      
      return @list_of_all_reservations.find { |reservation| reservation.reservation_number == reservation_number_to_search}
      
    end
    
    def list_of_available_rooms_by_date(date_to_check: )
      unavailable_room_numbers = list_of_reservations_by_date(date_to_search: date_to_check).map do |reservation|
        reservation.room_number
      end
      
      available_room_numbers = @list_of_all_rooms.map do |room|
        room.room_number
      end
      
      unavailable_room_numbers.each do |room_number|
        available_room_numbers.delete(room_number)
      end
      
      available_rooms = available_room_numbers.map do |room_number|
        find_room(room_number)
      end
      
      return available_rooms
    end
    
    def make_block(start_date: , end_date: , collection_of_room_numbers: , discounted_rate: )
      new_date_range = Hotel::DateRange.new(start_date: start_date, end_date: end_date)
      @list_of_all_reservations.each do |reservation|
        if reservation.date_range.overlap?(new_date_range) && collection_of_room_numbers.include?(reservation.room_number)
          raise ArgumentError.new "Error! One of the rooms you requested is unavailable during your selected dates."
        end
      end
      @list_of_all_blocks.each do |block|
        if block.block_date_range.overlap?(new_date_range) && ((block.collection_of_room_numbers & collection_of_room_numbers).length > 0)
          raise ArgumentError.new "Error! One of the rooms you requested is already in a block during your selected dates."
        end
      end
      block_id = @list_of_all_blocks.length + 1
      new_block = Hotel::Block.new(block_date_range: new_date_range, collection_of_room_numbers: collection_of_room_numbers, discounted_rate: discounted_rate, block_id: block_id)
      
      @list_of_all_blocks << new_block
      return new_block
    end
    
    def find_block(block_id: )
      @list_of_all_blocks.each do |block|
        if block.block_id == block_id
          return block
        end
      end
      raise ArgumentError.new ("Error! You entered a block id that doesn't match any existing blocks.")
    end
    
    def block_has_rooms_available?(block_id: )
      given_block = find_block(block_id: block_id)
      new_date_range = given_block.block_date_range
      possible_room_numbers = given_block.collection_of_room_numbers
      @list_of_all_reservations.each do |reservation|
        if reservation.date_range.overlap?(new_date_range)
          possible_room_numbers.delete(reservation.room_number)
        end
      end
      
      if possible_room_numbers.empty?
        return false
      else
        return true
      end
    end
    
    def make_reservation_in_block(block_id: )
      given_block = find_block(block_id: block_id)
      new_date_range = given_block.block_date_range
      possible_room_numbers = given_block.collection_of_room_numbers
      @list_of_all_reservations.each do |reservation|
        if reservation.date_range.overlap?(new_date_range)
          possible_room_numbers.delete(reservation.room_number)
        end
      end
      
      if possible_room_numbers.empty?
        raise ArgumentError.new "Error! All rooms in this block are booked. Sorry :("
      end
      
      new_room = possible_room_numbers.first
      new_cost = given_block.discounted_rate
      new_reservation_number = @list_of_all_reservations.length + 100
      
      new_reservation = Hotel::Reservation.new(date_range: new_date_range, room_number: new_room, reservation_number: new_reservation_number, cost_per_night: new_cost, block_id: block_id)
      
      @list_of_all_reservations << new_reservation
      return new_reservation
    end
  end
end