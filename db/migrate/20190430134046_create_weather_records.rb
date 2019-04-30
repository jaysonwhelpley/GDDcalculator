class CreateWeatherRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :weather_records do |t|


      t.float       :temp_max_c
      t.float       :temp_min_c
      t.float       :temp_max_f
      t.float       :temp_min_f
      t.float       :temp_f
      t.float       :temp_c

      t.references  :day
      t.integer     :time

      t.timestamps
    end
  end
end
