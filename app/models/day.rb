class Day < ApplicationRecord
  has_many  :weather_records
  has_many  :sentinel_lowest, class_name: "Sentinel", foreign_key: :lowest_day
  has_many  :sentinel_target, class_name: "Sentinel", foreign_key: :target_day
  validates :the_date, uniqueness: true

  def self.today
    Day.where(:the_date == DateTime.now).first
  end

  def self.new_day
    Day.create(the_date: DateTime.now)
  end

end
