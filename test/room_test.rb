require "./test/test_helper"

describe "Room class" do
  
  it "makes a new instance of Room class" do
    test_room = Hotel::Room.new(room_number: 1)
    
    expect(test_room).must_be_instance_of Hotel::Room
  end
  
  it "accurately stores the provided room number" do
    test_room = Hotel::Room.new(room_number: 15)
    
    test_room_number = test_room.room_number
    
    expect(test_room_number).must_equal 15
    
  end
  
  it "raises an error if an invalid room number is entered" do
    expect{Hotel::Room.new(room_number: 0)}.must_raise ArgumentError
    expect{Hotel::Room.new(room_number: -4)}.must_raise ArgumentError
    expect{Hotel::Room.new(room_number: 3.2)}.must_raise ArgumentError
    expect{Hotel::Room.new(room_number: '9banana')}.must_raise ArgumentError
  end
  
end