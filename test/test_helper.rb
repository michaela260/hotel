# Add simplecov
require "simplecov"
SimpleCov.start
require "minitest"
require "minitest/autorun"
require "minitest/reporters"
require "date"

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

# require_relative your lib files here!
require_relative "../lib/block.rb"
require_relative "../lib/date_range.rb"
require_relative "../lib/room.rb"
require_relative "../lib/reservation.rb"
require_relative "../lib/manager.rb"