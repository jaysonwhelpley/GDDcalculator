class CreateDays < ActiveRecord::Migration[5.2]
  def change
    create_table :days do |t|

      t.date    :the_date
      t.float   :temp_max_c
      t.float   :temp_min_c
      t.float   :temp_max_f
      t.float   :temp_min_f

      t.timestamps
    end
  end
end
