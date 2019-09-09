require_relative 'room'
require_relative 'date_range'
require_relative 'reservation'

# method reserve_block (creates instance of block)

module Hotel
  class Manager
    attr_reader :list_of_all_rooms, :list_of_all_reservations
    
    def initialize
      list_of_all_rooms = []
      
      20.times do |i|
        new_room = Hotel::Room.new(room_number: i + 1)
        list_of_all_rooms << new_room
      end
      
      @list_of_all_rooms = list_of_all_rooms
      @list_of_all_reservations = []
    end
    
    def make_reservation(start_date: , end_date: )
      
      new_date_range = Hotel::DateRange.new(start_date: start_date, end_date: end_date)
      possible_room_numbers = (1..20).to_a
      @list_of_all_reservations.each do |reservation|
        if reservation.date_range.overlap?(new_date_range)
          possible_room_numbers.delete(reservation.room_number)
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
    
  end
end