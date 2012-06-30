# encoding: utf-8

class Scraper
  attr_accessor :display_name, :primary_location, :description, :name, :address, :city, :state, :phone_number

  require 'open-uri'

  def initialize(url)
    doc = Nokogiri::HTML(open(url))

    self.display_name = doc.css('title').text.split(" - ").first.strip
    self.name = doc.css('.deal-title p').text.split(' • ')[0]
    self.primary_location = doc.css('.deal-title p').text.split(' • ')[1]
    self.description = doc.css('.highlights ul li').text.gsub("\n","--")
    self.phone_number = doc.css('.meta .phone').text.gsub("|","")
    self.address = doc.css('.meta .street_1').text.gsub("\n","--")
    self.city = doc.css('.deal-title p').text.split(%r{\W{2,}})[-2]
    self.state = doc.css('.deal-title p').text.split(",")[-1].strip
  end

end
