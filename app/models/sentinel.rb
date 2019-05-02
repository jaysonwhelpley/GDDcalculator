class Sentinel < ApplicationRecord
  belongs_to :lowest_day, class_name: "Day"
  belongs_to :target_day, class_name: "Day", optional: true

  def calculate_gdd

    self.update(target_day: nil, gdd: 0)

    start_day = self.lowest_day
    yesterday = Day.find_by(the_date: Date.yesterday.strftime('%Y-%m-%d'))

    check_days = Day.where(the_date: start_day.the_date..yesterday.the_date).order("the_date ASC")

    check_days.each do |d|

      min = d.temp_min_c
      max = d.temp_max_c

      if ( min > self.target_c) || ( max > self.target_c)

        gdd = (max+min)/2

        if gdd < self.target_c
          gdd = 0
        end

        gdd = self.gdd + gdd

        self.update!(gdd: gdd)

        if (self.target_day.nil?) && (self.gdd >= self.target_gdd)
          self.update(target_day: d)
        end

      end
    end



  end

end
