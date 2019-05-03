class CreateWeatherRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :weather_records do |t|

      t.float       :temp_f
      t.float       :temp_c

      t.references  :day
      t.integer     :time

      t.timestamps
    end

    add_index :weather_records, :temp_c
    add_index :weather_records, :temp_f

  end
end
