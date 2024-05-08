class CreateApplicationEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :application_events do |t|
      t.string :type, null: false
      t.integer :application_id, null: false
      t.json :data, default: {}
      
      t.timestamps
    end

    add_index :application_events, [:type, :application_id]
  end
end
