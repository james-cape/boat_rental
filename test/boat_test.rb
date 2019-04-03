require 'minitest/autorun'
require 'minitest/pride'
require './lib/boat'
require 'pry'

class BoatTest < Minitest::Test

  def test_boat_exists
    kayak = Boat.new(:kayak, 20)

    expected = Boat
    actual = kayak
    assert_instance_of expected, actual
  end

  def test_boat_type
    kayak = Boat.new(:kayak, 20)

    expected = :kayak
    actual = kayak.type
    assert_equal expected, actual
  end

  def test_boat_price_per_hour
    kayak = Boat.new(:kayak, 20)

    expected = 20
    actual = kayak.price_per_hour
    assert_equal expected, actual
  end

  def test_hours_rented_start_at_0
    kayak = Boat.new(:kayak, 20)

    expected = 0
    actual = kayak.hours_rented
    assert_equal expected, actual
  end

  def test_hours_can_be_added
    kayak = Boat.new(:kayak, 20)
    kayak.add_hour
    kayak.add_hour
    kayak.add_hour

    expected = 3
    actual = kayak.hours_rented
    assert_equal expected, actual
  end


end
