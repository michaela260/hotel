require "./test/test_helper"

# date_range, room number, cost per night, booking number, block_id, total cost

# Describe test for reservation
describe "Reservation class" do
  
  describe "initialize method" do
    before do
      @test_date_range = Hotel::DateRange.new(start_date: Date.today.prev_day, end_date: Date.today.next_day)
      @test_reservation = Hotel::Reservation.new(date_range: @test_date_range)
      @test_reservation_2 = Hotel::Reservation.new(date_range: @test_date_range, block_id: 1)
    end
    
    it "creates an instance of Reservation " do
      expect(@test_reservation).must_be_instance_of Hotel::Reservation
    end
    
    it "accurately stores the reservation date range as an instance of DateRange" do
      expect(@test_reservation.date_range).must_be_instance_of Hotel::DateRange
    end
    
    it "assigns a room number between 1 and 20" do
      expect(@test_reservation.room_number).must_be_instance_of Integer
      expect(@test_reservation.room_number).must_be :<=, 20
      expect(@test_reservation.room_number).must_be :>=, 1
    end
    
    it "assigns a 3-digit integer as the booking number" do
      expect(@test_reservation.booking_number).must_be_instance_of Integer
      expect(@test_reservation.booking_number / 100).must_be :<, 10
      expect(@test_reservation.booking_number / 100).must_be :>=, 1
    end
    
    it "accurately stores the block id number if provided" do
      expect(@test_reservation.block_id).must_equal 0
      expect(@test_reservation_2.block_id).must_equal 1
    end
    
    it "stores the cost per night as $150 if a block id is provided" do
      expect(@test_reservation_2.cost_per_night).must_equal 150
    end
    
    it "stores the cost per night as $200 if a block id is not provided" do
      expect(@test_reservation.cost_per_night).must_equal 200
    end
    
    it "accurately calculates the total cost" do
      expect(@test_reservation.date_range.number_of_nights).must_equal 2
      expect(@test_reservation.total_cost).must_equal 400
    end
    
  end
  
end
