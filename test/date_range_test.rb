require "./test/test_helper"

# describe date range class
describe "Hotel::DateRange class" do
  # test that it accurately stores the start and end dates
  it "accurately stores the given start and end dates" do
    test_date = Hotel::DateRange.new((Date.parse('2013-11-26')), (Date.parse('2013-12-03')))
    
    expect(test_date.start_date.mon).must_equal 11
    expect(test_date.start_date.mday).must_equal 26
    expect(test_date.start_date.year).must_equal 2013
    expect(test_date.end_date.mon).must_equal 12
    expect(test_date.end_date.mday).must_equal 3
    expect(test_date.end_date.year).must_equal 2013
  end
  
  # test that the stored start date and end date are instances of Date class
  it "stores the given start and end dates as instances of Date class" do
    test_date = Hotel::DateRange.new(Date.today.prev_day, Date.today)
    
    expect(test_date.start_date).must_be_instance_of Date
    expect(test_date.end_date).must_be_instance_of Date
  end
  
  # test that it raises an ArgumentError if given an end date that is before a start date
  it "raises an ArgumentError if given an end date that is before the start date" do
    expect{Hotel::DateRange.new(Date.today, Date.today.prev_day)}.must_raise ArgumentError
  end
  
  # test that it raises an ArgumentError if given an invalid start or end date
  it "raises an ArgumentError if given a nil start or end date" do
    expect{Hotel::DateRange.new(nil, Date.today)}.must_raise ArgumentError
    expect{Hotel::DateRange.new(Date.today, nil)}.must_raise ArgumentError
  end
  
  # test that it raises an ArgumentError if the start date or end date are not provided
  it "raises an ArgumentError if the start date or end date are not provided" do
    expect{Hotel::DateRange.new(Date.today)}.must_raise ArgumentError
    expect{Hotel::DateRange.new}.must_raise ArgumentError
  end
  
  # describe the overlap? method
  describe "overlap? method" do
    # test that it returns false when given 2 date ranges that do not overlap
    it "returns false when given date ranges that do not overlap" do
      test_date = Hotel::DateRange.new(Date.today.prev_day, Date.today)
      test_date_2 = Hotel::DateRange.new(Date.today.next_day, Date.today.next_day.next_day)
      
      result = test_date.overlap?(test_date_2)
      
      expect(result).must_equal false
    end
    
    # test that it returns true when given 2 date ranges that overlap
    it "returns true when given date ranges that overlap" do
      test_date = Hotel::DateRange.new(Date.today.prev_day, Date.today)
      test_date_2 = Hotel::DateRange.new(Date.today.prev_day, Date.today)
      
      result = test_date.overlap?(test_date_2)
      
      expect(result).must_equal true
    end
    
    # test that it returns false when given 2 date ranges that overlap on only one day
    it "returns false when given date ranges that only overlap on one day" do
      test_date = Hotel::DateRange.new(Date.today.prev_day, Date.today)
      test_date_2 = Hotel::DateRange.new(Date.today, Date.today.next_day)
      
      result = test_date.overlap?(test_date_2)
      
      expect(result).must_equal false
    end 
  end
end