require_relative 'room'
require_relative 'date_range'
require_relative 'reservation'

# create Hotel module
#create Manager class

# Initialize Manager with list_of_all_rooms

# method make_reservation (creates instance of reservation)
# make sure that it produces a room number and reservation number that are not repeats

# method list_of_reservations_by_date

# method list_of_available_rooms_by_date

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
      new_room_number = @list_of_all_rooms.sample.room_number
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
    
  end
end