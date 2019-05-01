class CreateRawInfos < ActiveRecord::Migration[5.2]
  def change
    create_table :raw_infos do |t|

      t.integer :info_type
      t.string  :api_call
      t.jsonb   :entry

      t.timestamps
    end
  end
end
