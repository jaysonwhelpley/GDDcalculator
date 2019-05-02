class CreateSentinels < ActiveRecord::Migration[5.2]
  def change
    create_table :sentinels do |t|

      t.string        :title
      t.float         :gdd # this is GDDs accumulated since :lowest_day
      t.float         :target_gdd

      t.float         :temp_lowest_f
      t.float         :temp_lowest_c

      t.references    :lowest_day, foreign_key: {to_table: :days}

      t.float         :target_c
      t.float         :target_f

      t.references    :target_day, foreign_key: {to_table: :days}, null: true


      t.timestamps
    end
  end
end
