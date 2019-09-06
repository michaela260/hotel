require "date"

# create class DateRange

module Hotel
  class DateRange
    
    attr_reader :start_date, :end_date
    
    # define initialize method with attributes start_date and end_date
    def initialize(start_date: , end_date: )
      @start_date = start_date
      @end_date = end_date
      
      if @start_date == nil || @end_date == nil
        raise ArgumentError.new "Error! You entered a nil start or end date."
      elsif @start_date >= @end_date
        raise ArgumentError.new "Error! You entered a start date later than the end date! Please try again."
      end
    end
    # define overlap? method with the parameter being date_range_2
    def overlap?(date_range_2)
      if date_range_2 == nil
        raise ArgumentError.new "Error! You did not enter a valid date range to compare."
      end
      
      # check if the first date overlaps with the second date; return true/false accordingly
      if @end_date <= date_range_2.start_date || @start_date >= date_range_2.end_date
        return false
      else
        return true
      end
    end
  end
end