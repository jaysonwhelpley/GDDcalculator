class RawInfo < ApplicationRecord

  enum info_type: [
    :day,
    :wr
  ]

  # def self.wo_pull(s_date,e_date)
  #
  #   require 'httparty'
  #
  #   url = "http://api.worldweatheronline.com/premium/v1/past-weather.ashx?q=40.1250032,-80.33&date=#{s_date}&enddate=#{e_date}&tp=1&format=json&key=#{Rails.application.credentials.dig(:wwos_key)}"
  #
  #   res = HTTParty.get(url)
  #
  #   RawInfo.create(
  #     entry: res
  #   )
  #
  #   res['data']['weather'].each do |d|
  #
  #     day = nil
  #
  #     if Day.find_by(the_date: d['date'].to_s)
  #       day = Day.find_by(the_date: d['date'].to_s)
  #       # day.update!(
  #       #     temp_max_c: d['maxtempC'],
  #       #     temp_max_f: d['maxtempF'],
  #       #     temp_min_c: d['mintempC'],
  #       #     temp_min_f: d['mintempF']
  #       # )
  #       puts "DAY #{day.the_date} ALREADY EXISTS"
  #     else
  #       day = Day.create!(
  #         the_date: Date.parse(d['date'].to_s, '%Y-%m-%d'),
  #         temp_max_c: d['maxtempC'],
  #         temp_min_c: d['mintempC'],
  #         temp_max_f: d['maxtempF'],
  #         temp_min_f: d['mintempF']
  #       )
  #       puts "CREATED DAY #{day.the_date}"
  #     end
  #
  #     d['hourly'].each do |h|
  #
  #       wr = nil
  #       time = h['time']
  #
  #       puts day
  #
  #       if day.weather_records.find_by(time: time)
  #         wr = day.weather_records.find_by(time: time)
  #         wr.update(
  #           temp_f: h['tempF'],
  #           temp_c: h['tempC']
  #         )
  #         puts "UPDATED RECORD FOR #{wr.time} ON #{day.the_date}"
  #       else
  #
  #         wr = WeatherRecord.create!(
  #           time:   time,
  #           temp_f: h['tempF'],
  #           temp_c: h['tempC'],
  #           day:    day
  #         )
  #         puts "CREATED RECORD FOR #{wr.time} ON #{day.the_date}"
  #       end
  #     end
  #
  #   end
  #
  #   # RawInfo.create!(entry: res.to_s)
  #
  #
  # end
  def self.ds_pull(s_date,e_date = nil)

    require 'httparty'

    parsed_s_date = DateTime.parse("#{s_date} 00:00 -0400").strftime('%s')

    if e_date
      parsed_e_date = DateTime.parse("#{e_date} 00:00 -0400").strftime('%s')
    end

    check_times = [parsed_s_date.to_i]

    if parsed_e_date.present?

      if parsed_s_date > parsed_e_date
        switch_s_date = parsed_e_date
        switch_e_date = parsed_s_date
        parsed_e_date = switch_e_date
        parsed_s_date = switch_s_date
      end

      i = parsed_s_date.to_i

      while i < parsed_e_date.to_i do
        i = i + 86400
        check_times << i
      end

    end

    ap check_times

    check_times.each do |c|

      url = "https://api.darksky.net/forecast/#{Rails.application.credentials.dig(:darksky_key)}/40.12,-80.33,#{c}?units=si"

      res = HTTParty.get(url)

      RawInfo.create(
        info_type: :day,
        api_call: "darksky",
        entry: res
      )

      ap res['daily']['data'][0]

      res['daily']['data'].each do |d|

        day = nil
        date = Date.strptime(d['time'].to_s, '%s')

        if Day.find_by(the_date: date)
          day = Day.find_by(the_date: date)
          # day.update!(
          #     temp_max_c: d['maxtempC'],
          #     temp_max_f: d['maxtempF'],
          #     temp_min_c: d['mintempC'],
          #     temp_min_f: d['mintempF']
          # )
          puts "DAY #{day.the_date} ALREADY EXISTS"
        else
          day = Day.create!(
            the_date: date,
            temp_max_c: d['temperatureHigh'],
            temp_min_c: d['temperatureLow'],
            temp_max_f: (((d['temperatureHigh'].to_f)*1.8)+32).round(1),
            temp_min_f: (((d['temperatureLow'].to_f)*1.8)+32).round(1)
          )
          puts "CREATED DAY #{day.the_date}"
        end

        res['hourly']['data'].each do |h|

          wr = nil
          time = h['time']

          puts day

          if day.weather_records.find_by(time: time)
            wr = day.weather_records.find_by(time: time)
            # wr.update(
            #   temp_f: (((h['temperature'].to_f)*1.8)+32).round(1),
            #   temp_c: h['temperature']
            # )
            puts "RECORD EXISTS FOR #{wr.time} ON #{day.the_date}"
          else

            wr = WeatherRecord.create!(
              time:   time,
              temp_f: (((h['temperature'].to_f)*1.8)+32).round(1),
              temp_c: h['temperature'],
              day:    day
            )
            puts "CREATED RECORD FOR #{wr.time} ON #{day.the_date}"
          end
        end
      end
    end
  end
end
