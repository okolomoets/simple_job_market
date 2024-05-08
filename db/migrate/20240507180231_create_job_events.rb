class CreateJobEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :job_events do |t|
      t.string :type, null: false
      t.integer :job_id, null: false
      t.json :data, default: {}

      t.timestamps
    end

    add_index :job_events, [:type, :job_id]
  end
end
