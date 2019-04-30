class RawInfo < ApplicationRecord
  def self.pull(s_date,e_date)

    require 'httparty'

    # Other API possibility https://api.darksky.net/forecast/APIKEY/40.12,-80.33?units=si
    # https://darksky.net/dev/docs#time-machine-request

    url = "http://api.worldweatheronline.com/premium/v1/past-weather.ashx?q=40.1250032,-80.33&date=#{s_date}&enddate=#{e_date}&tp=1&format=json&key=#{Rails.application.credentials.dig(:wwos_key)}"

    res = HTTParty.get(url)

    RawInfo.create(
      entry: res
    )

    res['data']['weather'].each do |d|

      day = nil

      if Day.find_by(the_date: d['date'].to_s)
        day = Day.find_by(the_date: d['date'].to_s)
        day.update!(
            temp_max_c: d['maxtempC'],
            temp_max_f: d['maxtempF'],
            temp_min_c: d['mintempC'],
            temp_min_f: d['mintempF']
        )
        puts "UPDATED DAY #{day.the_date}"
      else
        day = Day.create!(
          the_date: Date.parse(d['date'].to_s, '%Y-%m-%d'),
          temp_max_c: d['maxtempC'],
          temp_min_c: d['mintempC'],
          temp_max_f: d['maxtempF'],
          temp_min_f: d['mintempF']
        )
        puts "CREATED DAY #{day.the_date}"
      end

      d['hourly'].each do |h|

        wr = nil
        time = h['time']

        puts day

        if day.weather_records.find_by(time: time)
          wr = day.weather_records.find_by(time: time)
          wr.update(
            temp_f: h['tempF'],
            temp_c: h['tempC']
          )
          puts "UPDATED RECORD FOR #{wr.time} ON #{day.the_date}"
        else

          wr = WeatherRecord.create!(
            time:   time,
            temp_f: h['tempF'],
            temp_c: h['tempC'],
            day:    day
          )
          puts "CREATED RECORD FOR #{wr.time} ON #{day.the_date}"
        end
      end

    end

    # RawInfo.create!(entry: res.to_s)


  end
end
