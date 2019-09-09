require "./test/test_helper"

describe "Block class" do
  
  describe "initialize method" do
    
    before do
      @test_date_range = Hotel::DateRange.new(start_date: Date.today.prev_day, end_date: Date.today.next_day)
      @test_block = Hotel::Block.new(block_date_range: @test_date_range, collection_of_room_numbers: [1,2,3], discounted_rate: 185, block_id: 1)
    end
    
    it "creates an instance of Hotel::Block" do
      expect(@test_block).must_be_instance_of Hotel::Block
    end
    
    it "accurately stores the block date range as an instance of DateRange" do
      expect(@test_block.block_date_range).must_be_instance_of Hotel::DateRange
    end
    
    it "accurately stores the collection of room numbers as an Array of Integers" do
      expect(@test_block.collection_of_room_numbers).must_be_instance_of Array
      @test_block.collection_of_room_numbers.each do |room_number|
        expect(room_number).must_be_instance_of Integer
      end
    end
    
    it "raises an ArgumentError if given an invalid collection of room numbers" do
      expect{Hotel::Block.new(block_date_range: @test_date_range, collection_of_room_numbers: "9banana", discounted_rate: 185, block_id: 2)}.must_raise ArgumentError
      expect{Hotel::Block.new(block_date_range: @test_date_range, collection_of_room_numbers: ["a", "b", "c"], discounted_rate: 195, block_id: 3)}.must_raise ArgumentError
      expect{Hotel::Block.new(block_date_range: @test_date_range, collection_of_room_numbers: [], discounted_rate: 205, block_id: 4)}.must_raise ArgumentError
      expect{Hotel::Block.new(block_date_range: @test_date_range, collection_of_room_numbers: [1, 2, 3, 4, 5, 6], discounted_rate: 205, block_id: 4)}.must_raise ArgumentError
    end
    
    it "accurately stores the discounted rate" do
      expect(@test_block.discounted_rate).must_equal 185
    end
    
    it "raises an ArgumentError if the discounted rate is not an Integer or Float" do
      expect{Hotel::Block.new(block_date_range: @test_date_range, collection_of_room_numbers: [1, 2, 3], discounted_rate: "abc", block_id: 5)}.must_raise ArgumentError
      expect{Hotel::Block.new(block_date_range: @test_date_range, collection_of_room_numbers: [1, 2, 3], discounted_rate: -175, block_id: 6)}.must_raise ArgumentError
    end
    
    it "accurately stores the block id as an Integer" do
      expect(@test_block.block_id).must_equal 1
    end
  end
  
end