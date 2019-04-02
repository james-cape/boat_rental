require 'minitest/autorun'
require 'minitest/pride'
require './lib/boat'
require './lib/renter'
require 'pry'

class RenterTest < Minitest::Test

  def test_renter_exists_has_name_and_cc_number
    renter = Renter.new("Patrick Star", "4242424242424242")
    assert_instance_of Renter, renter
    assert_equal "Patrick Star", renter.name
    assert_equal "4242424242424242", renter.credit_card_number
  end


end
