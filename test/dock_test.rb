require 'minitest/autorun'
require 'minitest/pride'
require './lib/boat'
require './lib/renter'
require './lib/dock'
require 'pry'

class DockTest < Minitest::Test

  def test_dock_exists
    dock = Dock.new("The Rowing Dock", 3)
    assert_instance_of Dock, dock
  end

  def test_dock_has_name
    dock = Dock.new("The Rowing Dock", 3)
    assert_equal "The Rowing Dock", dock.name
  end

  def test_dock_has_max_rental_time
    dock = Dock.new("The Rowing Dock", 3)
    assert_equal 3, dock.max_rental_time
  end

  def test_dock_can_rent_boats
    dock = Dock.new("The Rowing Dock", 3)
    kayak_1 = Boat.new(:kayak, 20)
    kayak_2 = Boat.new(:kayak, 20)
    sup_1 = Boat.new(:standup_paddle_board, 15)
    patrick = Renter.new("Patrick Star", "4242424242424242")
    eugene = Renter.new("Eugene Crabs", "1313131313131313")
    dock.rent(kayak_1, patrick)
    dock.rent(kayak_2, patrick)
    dock.rent(sup_1, eugene)

    expected = {kayak_1 => patrick, kayak_2 => patrick, sup_1 => eugene}
    actual = dock.rental_log
    assert_equal expected, actual
  end

  def test_dock_charges_customers
    dock = Dock.new("The Rowing Dock", 3)
    kayak_1 = Boat.new(:kayak, 20)
    kayak_2 = Boat.new(:kayak, 20)
    sup_1 = Boat.new(:standup_paddle_board, 15)
    patrick = Renter.new("Patrick Star", "4242424242424242")
    eugene = Renter.new("Eugene Crabs", "1313131313131313")
    dock.rent(kayak_1, patrick)
    dock.rent(kayak_2, patrick)
    dock.rent(sup_1, eugene)

    kayak_1.add_hour
    kayak_1.add_hour

    expected = {card_number: "4242424242424242", amount: 40}
    actual = dock.charge(kayak_1)
    assert_equal expected, actual
  end

  def test_dock_charges_customers_but_not_past_max_time
    dock = Dock.new("The Rowing Dock", 3)
    kayak_1 = Boat.new(:kayak, 20)
    kayak_2 = Boat.new(:kayak, 20)
    sup_1 = Boat.new(:standup_paddle_board, 15)
    patrick = Renter.new("Patrick Star", "4242424242424242")
    eugene = Renter.new("Eugene Crabs", "1313131313131313")
    dock.rent(kayak_1, patrick)
    dock.rent(kayak_2, patrick)
    dock.rent(sup_1, eugene)

    kayak_1.add_hour
    kayak_1.add_hour

    sup_1.add_hour
    sup_1.add_hour
    sup_1.add_hour
    sup_1.add_hour
    sup_1.add_hour

    expected = {card_number: "1313131313131313", amount: 45}
    actual = dock.charge(sup_1)
    assert_equal expected, actual
  end


  def test_revenue_not_generated_until_boats_are_returned
    dock = Dock.new("The Rowing Dock", 3)
    kayak_1 = Boat.new(:kayak, 20)
    kayak_2 = Boat.new(:kayak, 20)
    canoe = Boat.new(:canoe, 25)
    sup_1 = Boat.new(:standup_paddle_board, 15)
    sup_2 = Boat.new(:standup_paddle_board, 15)
    patrick = Renter.new("Patrick Star", "4242424242424242")
    eugene = Renter.new("Eugene Crabs", "1313131313131313")

        # Rent Boats out to first Renterdock.rent(kayak_1, patrick)
    dock.rent(kayak_2, patrick)

        # kayak_1 and kayak_2 are rented an additional hourdock.log_hour
    dock.rent(canoe, patrick)

        # kayak_1, kayak_2, and canoe are rented an additional hourdock.log_hour

        # Revenue should not be generated until boats are returned
    expected = 0
    actual = dock.revenue
    assert_equal expected, actual
  end

  def test_revenue_after_some_boats_returned

    dock = Dock.new("The Rowing Dock", 3)
    kayak_1 = Boat.new(:kayak, 20)
    kayak_2 = Boat.new(:kayak, 20)
    canoe = Boat.new(:canoe, 25)
    sup_1 = Boat.new(:standup_paddle_board, 15)
    sup_2 = Boat.new(:standup_paddle_board, 15)
    patrick = Renter.new("Patrick Star", "4242424242424242")
    eugene = Renter.new("Eugene Crabs", "1313131313131313")

        # Rent Boats out to first Renter
    dock.rent(kayak_1, patrick)
    dock.rent(kayak_2, patrick)

        # kayak_1 and kayak_2 are rented an additional hour
    dock.log_hour
    dock.rent(canoe, patrick)
        # kayak_1, kayak_2, and canoe are rented an additional hour
    dock.log_hour
        # Revenue should not be generated until boats are returned
        # binding.pry
    dock.return(kayak_1)
    dock.return(kayak_2)
    dock.return(canoe)
    # binding.pry

    expected = 105
    actual = dock.revenue
        # Revenue thus far
    assert_equal expected, actual
        # => 105
  end

  def test_z

    dock = Dock.new("The Rowing Dock", 3)
    kayak_1 = Boat.new(:kayak, 20)
    kayak_2 = Boat.new(:kayak, 20)
    canoe = Boat.new(:canoe, 25)
    sup_1 = Boat.new(:standup_paddle_board, 15)
    sup_2 = Boat.new(:standup_paddle_board, 15)
    patrick = Renter.new("Patrick Star", "4242424242424242")
    eugene = Renter.new("Eugene Crabs", "1313131313131313")

        # Rent Boats out to first Renter
    dock.rent(kayak_1, patrick)
    dock.rent(kayak_2, patrick)

        # kayak_1 and kayak_2 are rented an additional hour
    dock.log_hour
    dock.rent(canoe, patrick)
        # kayak_1, kayak_2, and canoe are rented an additional hour
    dock.log_hour
        # Revenue should not be generated until boats are returned
        # binding.pry
    dock.return(kayak_1)
    dock.return(kayak_2)
    dock.return(canoe)

        # Rent Boats out to a second Renter
    dock.rent(sup_1, eugene)
    dock.rent(sup_2, eugene)
    dock.log_hour
    dock.log_hour
    dock.log_hour

        # Any hours rented past the max rental time don't factor into revenue
    dock.log_hour
    dock.log_hour
    dock.return(sup_1)
    dock.return(sup_2)

    expected = 195
    actual = dock.revenue
        # Total revenue
    assert_equal expected, actual
  end

end
