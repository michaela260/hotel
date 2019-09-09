require "./test/test_helper"

# date_range, room number, cost per night, booking number, block_id, total cost

# Describe test for reservation
describe "Reservation class" do
  
  describe "initialize method" do
    before do
      @test_date_range = Hotel::DateRange.new(start_date: Date.today.prev_day, end_date: Date.today.next_day)
      @test_reservation = Hotel::Reservation.new(date_range: @test_date_range, room_number: 15, reservation_number: 500)
      @test_reservation_2 = Hotel::Reservation.new(date_range: @test_date_range, room_number: 15, block_id: 1, cost_per_night: 175, reservation_number: 300)
    end
    
    it "creates an instance of Reservation " do
      expect(@test_reservation).must_be_instance_of Hotel::Reservation
    end
    
    it "accurately stores the reservation date range as an instance of DateRange" do
      expect(@test_reservation.date_range).must_be_instance_of Hotel::DateRange
    end
    
    it "accurately stores the room number as an Integer" do
      expect(@test_reservation.room_number).must_be_instance_of Integer
    end
    
    it "accurately stores the the reservation number as an Integer" do
      expect(@test_reservation.reservation_number).must_be_instance_of Integer
    end
    
    it "accurately stores the block id number if provided" do
      expect(@test_reservation.block_id).must_equal 0
      expect(@test_reservation_2.block_id).must_equal 1
    end
    
    it "stores the cost per night as discounted if an alternate cost is provided" do
      expect(@test_reservation_2.cost_per_night).must_equal 175
    end
    
    it "stores the cost per night as $200 by default" do
      expect(@test_reservation.cost_per_night).must_equal 200
    end
    
    it "accurately calculates the total cost" do
      expect(@test_reservation.date_range.number_of_nights).must_equal 2
      expect(@test_reservation.total_cost).must_equal 400
    end
    
  end
  
end
