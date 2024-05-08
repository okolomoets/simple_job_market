class CreateApplications < ActiveRecord::Migration[7.1]
  def change
    create_table :applications do |t|
      t.integer :job_id, null: false
      t.string :candidate_name, null: false

      t.timestamps
    end
  end
end
