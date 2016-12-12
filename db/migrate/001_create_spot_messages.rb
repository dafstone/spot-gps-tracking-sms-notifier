class CreateSpotMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :spot_messages do |t|
      t.string :message_type
      t.float :latitude
      t.float :longitude
      t.datetime :message_time
      t.integer :message_id
      t.text :message_content

      t.timestamps
    end
  end
end
