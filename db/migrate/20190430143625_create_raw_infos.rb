class CreateRawInfos < ActiveRecord::Migration[5.2]
  def change
    create_table :raw_infos do |t|

      t.string  :entry

      t.timestamps
    end
  end
end
