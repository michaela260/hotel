require "./test/test_helper"

describe "Manager class" do
  
  before do
    @test_hotel = Hotel::Manager.new
    @test_hotel_2 = Hotel::Manager.new
    @test_hotel_3 = Hotel::Manager.new
    @test_hotel_4 = Hotel::Manager.new
    @test_hotel_5 = Hotel::Manager.new
    @test_hotel_6 = Hotel::Manager.new
    
    @test_date_1 = Date.today
    @test_date_2 = Date.today.prev_day
    @test_date_3 = Date.today.prev_day.prev_day
    @test_date_4 = Date.today.prev_day.prev_day.prev_day
    @test_date_5 = Date.today.next_day
    @test_date_6 = Date.today.next_day.next_day
    @test_date_7 = Date.today.next_day.next_day.next_day
    
    @test_reservation_1 = @test_hotel.make_reservation(start_date: @test_date_3, end_date: @test_date_1)
    @test_reservation_2 = @test_hotel.make_reservation(start_date: @test_date_4, end_date: @test_date_2)
    @test_reservation_3 = @test_hotel.make_reservation(start_date: @test_date_4, end_date: @test_date_7)
    @test_reservation_4 = @test_hotel.make_reservation(start_date: @test_date_1, end_date: @test_date_6)
    @test_reservation_5 = @test_hotel.make_reservation(start_date: @test_date_5, end_date: @test_date_7)
    
    @new_block = @test_hotel_5.make_block(start_date: @test_date_2, end_date: @test_date_1, collection_of_room_numbers: [1,2,3], discounted_rate: 175)
    @new_block_2 = @test_hotel_5.make_block(start_date: @test_date_5, end_date: @test_date_7, collection_of_room_numbers: [1,2,3], discounted_rate: 175)
    
    @block_reservation_1 = @test_hotel_5.make_reservation_in_block(block_id: @new_block.block_id)
    @block_reservation_2 = @test_hotel_5.make_reservation_in_block(block_id: @new_block.block_id)
    @block_reservation_3 = @test_hotel_5.make_reservation_in_block(block_id: @new_block.block_id)
  end
  
  describe "initialize method" do
    
    it "has an attribute list_of_all_rooms that is an Array of rooms" do
      expect(@test_hotel_2.list_of_all_rooms).must_be_instance_of Array
      @test_hotel_2.list_of_all_rooms.each do |room|
        expect(room).must_be_instance_of Hotel::Room
      end
    end
    
    it "has an attribute list_of_all_rooms that includes all rooms from 1-20" do
      i = 0
      (1..20).to_a.each do |number|
        expect(@test_hotel_2.list_of_all_rooms[i].room_number).must_equal number
        i += 1
      end
    end
    
    it "has an attribute list_of_all_reservations that is an empty array" do
      expect(@test_hotel_2.list_of_all_reservations).must_equal []
    end
    
    it "has an attribute list_of_all_blocks that is an empty array" do
      expect(@test_hotel_2.list_of_all_blocks).must_equal []
    end
    
  end
  
  describe "make_reservation method" do
    it "creates a new instance of Reservation" do
      expect(@test_reservation_1).must_be_instance_of Hotel::Reservation
    end
    
    it "raises an ArgumentError if given an invalid start or end date" do
      expect{@test_hotel.make_reservation(start_date: @test_date_2, end_Date: @test_date_1)}.must_raise ArgumentError
      expect{@test_hotel.make_reservation(start_date: "9banana", end_Date: @test_date_1)}.must_raise ArgumentError
      expect{@test_hotel.make_reservation(start_date: @test_date_1, end_Date: "9banana")}.must_raise ArgumentError
      expect{@test_hotel.make_reservation(start_date: nil, end_Date: @test_date_1)}.must_raise ArgumentError
      expect{@test_hotel.make_reservation(start_date: @test_date_1, end_Date: nil)}.must_raise ArgumentError
      expect{@test_hotel.make_reservation(start_date: nil, end_Date: nil)}.must_raise ArgumentError
    end
    
    it "raises an ArgumentError if a start/end date are not provided" do
      expect{@test_hotel.make_reservation(end_date: @test_date_1)}.must_raise ArgumentError
      expect{@test_hotel.make_reservation(start_date: @test_date_1)}.must_raise ArgumentError
      expect{@test_hotel.make_reservation}.must_raise ArgumentError
    end
    
    it "chooses a valid room number that is an integer between 1 and 20" do
      expect(@test_reservation_1.room_number).must_be_instance_of Integer
      expect(@test_reservation_1.room_number).must_be :<=, 20
      expect(@test_reservation_1.room_number).must_be :>=, 1
    end
    
    it "chooses the first room number that is available during the given date range" do
      expect(@test_reservation_1.room_number).must_equal 1
      expect(@test_reservation_2.room_number).must_equal 2
      expect(@test_reservation_3.room_number).must_equal 3
      expect(@test_reservation_4.room_number).must_equal 1
      expect(@test_reservation_5.room_number).must_equal 2
    end
    
    it "raises an ArgumentError if no rooms are available during the given date range" do
      20.times do |i|
        @test_hotel_3.make_reservation(start_date: @test_date_1, end_date: @test_date_5)
      end
      expect{@test_hotel_3.make_reservation(start_date: @test_date_1, end_date: @test_date_5)}.must_raise ArgumentError
    end
    
    it "generates reservation numbers in order, starting at 100" do
      expect(@test_reservation_1.reservation_number).must_be_instance_of Integer
      expect(@test_reservation_1.reservation_number).must_equal 100
      expect(@test_reservation_2.reservation_number).must_equal 101
      expect(@test_reservation_3.reservation_number).must_equal 102
      expect(@test_reservation_4.reservation_number).must_equal 103
      expect(@test_reservation_5.reservation_number).must_equal 104
    end
    
    it "Will not let you normally reserve a room that is part of a block" do
      reservation = @test_hotel_5.make_reservation(start_date: @test_date_3, end_date: @test_date_1)
      expect(reservation.room_number).must_equal 4
    end
    
  end
  
  describe "list_of_reservations_by_date method" do
    
    it "returns an array of reservations" do
      expect(@test_hotel.list_of_reservations_by_date(date_to_search: Date.today)).must_be_instance_of Array
      @test_hotel.list_of_reservations_by_date(date_to_search: Date.today).each do |reservation|
        expect(reservation).must_be_instance_of Hotel::Reservation
      end
    end
    
    it "only includes reservations for the given date" do
      @test_hotel.list_of_reservations_by_date(date_to_search: Date.today).each do |reservation|
        expect(reservation.date_range.date_range_includes?(date: Date.today)).must_equal true
      end
      expect(@test_hotel.list_of_reservations_by_date(date_to_search: Date.today)).wont_include @test_reservation_1
      expect(@test_hotel.list_of_reservations_by_date(date_to_search: Date.today)).wont_include @test_reservation_2
      expect(@test_hotel.list_of_reservations_by_date(date_to_search: Date.today)).wont_include @test_reservation_5
      expect(@test_hotel.list_of_reservations_by_date(date_to_search: Date.today).length).must_equal 2
    end
    
    it "includes all reservations for the given date" do
      expect(@test_hotel.list_of_reservations_by_date(date_to_search: Date.today)).must_include @test_reservation_3
      expect(@test_hotel.list_of_reservations_by_date(date_to_search: Date.today)).must_include @test_reservation_4
    end
    
  end
  
  describe "list_of_available_rooms_by_date method" do
    
    it "returns an array of rooms" do
      expect(@test_hotel.list_of_available_rooms_by_date(date_to_check: Date.today)).must_be_instance_of Array
      @test_hotel.list_of_available_rooms_by_date(date_to_check: Date.today).each do |room|
        expect(room).must_be_instance_of Hotel::Room
      end
    end
    
    it "only includes rooms that are available on the given date" do
      expect(@test_hotel.list_of_available_rooms_by_date(date_to_check: Date.today)).wont_include @test_hotel.find_room(@test_reservation_3.room_number)
      expect(@test_hotel.list_of_available_rooms_by_date(date_to_check: Date.today)).wont_include @test_hotel.find_room(@test_reservation_4.room_number)
      expect(@test_hotel.list_of_available_rooms_by_date(date_to_check: Date.today).length).must_equal 18
    end
    
    it "includes all rooms that are available on the given date" do
      expect(@test_hotel.list_of_available_rooms_by_date(date_to_check: Date.today)).must_include @test_hotel.find_room(@test_reservation_2.room_number)
      expect(@test_hotel.list_of_available_rooms_by_date(date_to_check: Date.today)).must_include @test_hotel.find_room(@test_reservation_5.room_number)
    end
    
    it "includes rooms that have a previous reservation ending on the given date" do
      ended_reservation = @test_hotel_4.make_reservation(start_date: Date.today.prev_day, end_date: Date.today)
      expect(@test_hotel_4.list_of_available_rooms_by_date(date_to_check: Date.today)).must_include @test_hotel_4.find_room(ended_reservation.room_number)
    end
    
  end
  
  describe "find_room method" do
    before do
      @found_room = @test_hotel.find_room(@test_reservation_4.room_number)
    end
    
    it "returns an instance of Hotel::Room" do
      expect(@found_room).must_be_instance_of Hotel::Room
    end
    
    it "returns a room whose room_number matches the room number provided" do
      expect(@found_room.room_number).must_equal 1
      expect(@found_room).must_equal @test_hotel.list_of_all_rooms[0]
    end
    
    it "raises an ArgumentError if an invalid room number is provided" do 
      expect{@test_hotel.find_room(0)}.must_raise ArgumentError
      expect{@test_hotel.find_room("9banana")}.must_raise ArgumentError
      expect{@test_hotel.find_room(-1)}.must_raise ArgumentError
      expect{@test_hotel.find_room(1.5)}.must_raise ArgumentError
    end
  end
  
  describe "find_reservation method" do
    before do
      @found_reservation = @test_hotel.find_reservation(@test_reservation_1.reservation_number)
    end
    
    it "returns an instance of Hotel::Reservation" do
      expect(@found_reservation).must_be_instance_of Hotel::Reservation
    end
    
    it "returns a reservation whose reservation_number matches the reservation number provided" do
      expect(@found_reservation.reservation_number).must_equal 100
      expect(@found_reservation).must_equal @test_hotel.list_of_all_reservations[0]
    end
    
    it "raises an ArgumentError if an invalid reservation number is provided" do
      expect{@test_hotel.find_reservation(99)}.must_raise ArgumentError
      expect{@test_hotel.find_reservation(0)}.must_raise ArgumentError
      expect{@test_hotel.find_reservation(-100)}.must_raise ArgumentError
      expect{@test_hotel.find_reservation(100.5)}.must_raise ArgumentError
      expect{@test_hotel.find_reservation("9banana")}.must_raise ArgumentError
    end
  end
  
  describe "make_block method" do
    
    it "returns an instance of Hotel::Block" do
      expect(@new_block).must_be_instance_of Hotel::Block
    end
    
    it "raises an ArgumentError if given an invalid start or end date" do
      expect{@test_hotel.make_block(start_date: @test_date_2, end_Date: @test_date_1, collection_of_room_numbers: [1,2,3], discounted_rate: 175)}.must_raise ArgumentError
      expect{@test_hotel.make_block(start_date: "9banana", end_Date: @test_date_1, collection_of_room_numbers: [1,2,3], discounted_rate: 175)}.must_raise ArgumentError
      expect{@test_hotel.make_block(start_date: @test_date_1, end_Date: "9banana", collection_of_room_numbers: [1,2,3], discounted_rate: 175)}.must_raise ArgumentError
      expect{@test_hotel.make_block(start_date: nil, end_Date: @test_date_1, collection_of_room_numbers: [1,2,3], discounted_rate: 175)}.must_raise ArgumentError
      expect{@test_hotel.make_block(start_date: @test_date_1, end_Date: nil, collection_of_room_numbers: [1,2,3], discounted_rate: 175)}.must_raise ArgumentError
      expect{@test_hotel.make_block(start_date: nil, end_Date: nil, collection_of_room_numbers: [1,2,3], discounted_rate: 175)}.must_raise ArgumentError
    end
    
    it "raises an ArgumentError if a start/end date are not provided" do
      expect{@test_hotel.make_block(end_date: @test_date_1, collection_of_room_numbers: [1,2,3], discounted_rate: 175)}.must_raise ArgumentError
      expect{@test_hotel.make_block(start_date: @test_date_1, collection_of_room_numbers: [1,2,3], discounted_rate: 175)}.must_raise ArgumentError
      expect{@test_hotel.make_block(collection_of_room_numbers: [1,2, 3], discounted_rate: 175)}.must_raise ArgumentError
    end
    
    it "converts start and end date into a date range" do
      expect(@new_block.block_date_range).must_be_instance_of Hotel::DateRange
    end
    
    it "raises an ArgumentError if a requested room is unavailable during the given date range" do
      @test_hotel_6.make_reservation(start_date: @test_date_1, end_date: @test_date_5)
      expect{@test_hotel_6.make_block(start_date: @test_date_1, end_date: @test_date_5, collection_of_room_numbers: [1,2,3], discounted_rate: 175)}.must_raise ArgumentError
    end
    
    it "raises an ArgumentError if you attempt to include the same room in multiple blocks at the same time" do
      expect{@test_hotel_5.make_block(start_date: @test_date_5, end_date: @test_date_7, collection_of_room_numbers: [1,2,3], discounted_rate: 175)}.must_raise ArgumentError
    end
    
    it "adds the new block to the list of all blocks" do
      expect(@test_hotel_5.list_of_all_blocks).must_include @new_block
      expect(@test_hotel_5.list_of_all_blocks.length).must_equal 2
    end
    
    it "creates a block id that is the next available consecutive Integer" do
      expect(@new_block.block_id).must_equal 1
    end
  end
  
  describe "find_block method" do
    before do
      @found_block = @test_hotel_5.find_block(block_id: @new_block.block_id)
    end
    
    it "returns an instance of Hotel::Block" do
      expect(@found_block).must_be_instance_of Hotel::Block
    end
    
    it "returns a block whose block_id matches the block id provided" do
      expect(@found_block).must_equal @new_block
      expect(@found_block.block_id).must_equal 1
    end
    
    it "raises an ArgumentError if an invalid block number is provided" do
      expect{@test_hotel_5.find_block(block_id: 99)}.must_raise ArgumentError
      expect{@test_hotel_5.find_block(block_id: 0)}.must_raise ArgumentError
      expect{@test_hotel_5.find_block(block_id: -100)}.must_raise ArgumentError
      expect{@test_hotel_5.find_block(block_id: 1.5)}.must_raise ArgumentError
      expect{@test_hotel_5.find_block(block_id: "9banana")}.must_raise ArgumentError
    end
  end
  
  describe "block_has_rooms_available method" do
    it "returns true if the given block has rooms available" do
      result = @test_hotel_5.block_has_rooms_available?(block_id: @new_block_2.block_id)
      expect(result).must_equal true
    end
    
    it "returns false if the given block does not have rooms available" do
      result = @test_hotel_5.block_has_rooms_available?(block_id: @new_block.block_id)
      expect(result).must_equal false
    end
    
  end
  
  describe "make_reservation_in_block method" do
    
    it "creates a new instance of Reservation" do
      expect(@block_reservation_1).must_be_instance_of Hotel::Reservation
    end
    
    it "chooses a valid room number that is an integer between 1 and 20" do
      expect(@block_reservation_1.room_number).must_be_instance_of Integer
      expect(@block_reservation_1.room_number).must_be :<=, 20
      expect(@block_reservation_1.room_number).must_be :>=, 1
    end
    
    it "chooses the first room number that is available in the block" do
      expect(@block_reservation_1.room_number).must_equal 1
      expect(@block_reservation_2.room_number).must_equal 2
      expect(@block_reservation_3.room_number).must_equal 3
    end
    
    it "raises an ArgumentError if no rooms are available in the block" do
      expect{@test_hotel_5.make_reservation_in_block(block_id: @new_block.block_id)}.must_raise ArgumentError
    end
    
    it "generates reservation numbers in order, starting at 100" do
      expect(@block_reservation_1.reservation_number).must_be_instance_of Integer
      expect(@block_reservation_1.reservation_number).must_equal 100
      expect(@block_reservation_2.reservation_number).must_equal 101
      expect(@block_reservation_3.reservation_number).must_equal 102
    end
    
    it "changes the cost per night to reflect the discount" do
      new_cost = @block_reservation_1.cost_per_night
      expect(new_cost).must_equal 175
    end
    
    it "assigns the reservation a block id number" do
      expect(@block_reservation_1.block_id).must_equal 1
      expect(@block_reservation_2.block_id).must_equal 1
      expect(@block_reservation_3.block_id).must_equal 1
    end
    
    it "makes block reservations appear in the list of all reservations" do
      expect(@test_hotel_5.list_of_all_reservations.include? @block_reservation_1).must_equal true
      expect(@test_hotel_5.list_of_all_reservations.include? @block_reservation_2).must_equal true
      expect(@test_hotel_5.list_of_all_reservations.include? @block_reservation_3).must_equal true
    end
    
  end
  
  
  
end