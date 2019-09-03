require "./test/test_helper"

# create describe for room test
describe "Room class" do
  
  # create test to check that the default cost is $200
  it "makes the default cost of each room $200" do
    # Arrange
    test_room = Hotel::Room.new(room_number: 1)
    
    # Act
    test_cost = test_room.room_cost
    
    # Assert
    expect(test_cost).must_equal 200
  end
  
  # create test to check that the room cost matches the entered cost
  
  it "accurately stores the provided room cost" do
    test_room = Hotel::Room.new(room_cost: 350, room_number: 1)
    
    test_cost = test_room.room_cost
    
    expect(test_cost).must_equal 350
    
  end
  
  it "raises an error if an invalid room cost is entered" do
    expect{Hotel::Room.new(room_cost: -143, room_number: 1)}.must_raise ArgumentError
    expect{Hotel::Room.new(room_cost: '9banana', room_number: 1)}.must_raise ArgumentError
  end
  
  # create test to check that room number matches the entered number
  it "accurately stores the provided room number" do
    # Arrange
    test_room = Hotel::Room.new(room_number: 15)
    
    # Act
    test_room_number = test_room.room_number
    
    # Assert
    expect(test_room_number).must_equal 15
    
  end
  
  it "raises an error if an invalid room number is entered" do
    expect{Hotel::Room.new(room_number: 0)}.must_raise ArgumentError
    expect{Hotel::Room.new(room_number: -4)}.must_raise ArgumentError
    expect{Hotel::Room.new(room_number: 3.2)}.must_raise ArgumentError
    expect{Hotel::Room.new(room_number: '9banana')}.must_raise ArgumentError
  end
  
end