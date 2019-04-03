class Dock

  attr_reader :name,
              :max_rental_time,
              :rental_log,
              :revenue

  def initialize(name, max_rental_time)
    @name = name
    @max_rental_time = max_rental_time
    @rental_log = {}
    @revenue = 0
  end

  def rent(boat, renter)
    @rental_log[boat] = renter
  end

  def charge(boat)
    charge_info = {}
    renter = rental_log[boat]

    charged_amount = boat.price_per_hour * boat.hours_rented
    if boat.hours_rented > max_rental_time
      charged_amount = max_rental_time * boat.price_per_hour
    end

    charge_info[:card_number] = renter.credit_card_number
    charge_info[:amount] = charged_amount
    charge_info
  end

  def return(boat)
    @revenue += charge(boat)[:amount]
  end

  def log_hour
    @rental_log.each do |boat, renter|
      boat.add_hour
    end
  end

end
