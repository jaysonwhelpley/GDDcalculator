class Day < ApplicationRecord
  has_many  :weather_records
  validates :the_date, uniqueness: true

  def self.today
    Day.where(:the_date == DateTime.now).first
  end

  def self.new_day
    Day.create(the_date: DateTime.now)
  end

end
