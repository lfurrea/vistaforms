class CreateApplications < ActiveRecord::Migration
  def change
    create_table :applications do |t|
      t.string :cu_name
      t.string :cu_email

      t.timestamps
    end
  end
end
