require 'minitest/autorun'
require 'minitest/pride'
require './lib/boat'
require './lib/renter'
require 'pry'

class RenterTest < Minitest::Test

  def test_renter_exists

    renter = Renter.new("Patrick Star", "4242424242424242")

    expected = Renter
    actual = renter
    assert_instance_of expected, actual
  end

  def test_renter_has_a_name

    renter = Renter.new("Patrick Star", "4242424242424242")

    expected = "Patrick Star"
    actual = renter.name
    assert_equal expected, actual
  end

  def test_renter_has_cc_number

    renter = Renter.new("Patrick Star", "4242424242424242")

    expected = "4242424242424242"
    actual = renter.credit_card_number
    assert_equal expected, actual
  end
end
