class CreateSentinels < ActiveRecord::Migration[5.2]
  def change
    create_table :sentinels do |t|

      t.string        :title

      t.float         :temp_lowest_f
      t.float         :temp_lowest_c
      t.date          :lowest_day

      t.float         :target_c
      t.float         :target_f

      t.float         :gdd # this is GDDs accumulated since :lowest_day

      t.timestamps
    end
  end
end
