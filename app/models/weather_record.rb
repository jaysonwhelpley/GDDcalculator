class WeatherRecord < ApplicationRecord
  belongs_to  :day

  def self.get_entry

    require 'httparty'

    url = "http://api.openweathermap.org/data/2.5/weather?lon=-80.33&lat=40.12&appid=#{Rails.application.credentials.dig(:openweathermap_key)}"

    res = HTTParty.get(url)

    # puts response2['main']

    wr = WeatherRecord.new(
      temp_max: res['main']['temp_max'],
      temp_min: res['main']['temp_min'],
      temp:     res['main']['temp']
    )

    if Day.today
      wr.day = Day.today
      wr.save!
    else
      wr.day = Day.new_day
      wr.save!
    end

    wr

  end

end
