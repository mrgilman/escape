class Lodging < ActiveRecord::Base
  belongs_to :trip
  attr_accessible :name, :address, :city, :state, :country, :phone_number, :start_date, :end_date

  def self.create_from_tripit(trip, tripit_id)
    lodgings = trip.user.tripit_trip(tripit_id).lodgings
    lodgings.each do |lodging|
      trip.lodgings.create(:name         => lodging.supplier_name,
                           :address      => lodging.address.try(:addr1),
                           :city         => lodging.address.try(:city),
                           :state        => lodging.address.try(:state),
                           :country      => lodging.address.try(:country),
                           :phone_number => lodging.supplier_phone,
                           :start_date   => lodging.start_date_time,
                           :end_date     => lodging.end_date_time)
    end
  end

  def self.create_from_livingsocial(trip, scrape)
    trip.lodgings.create(:name         => scrape.name,
                         :address      => scrape.address,
                         :city         => scrape.city,
                         :state        => scrape.state,
                         :phone_number => scrape.phone_number)
  end
end
