class CreateRawInfos < ActiveRecord::Migration[5.2]
  def change
    create_table :raw_infos do |t|

      t.integer :info_type
      t.string  :api_call
      t.jsonb   :entry

      t.timestamps
    end

    add_index :raw_infos, :info_type
    add_index :raw_infos, :api_call

  end
end
