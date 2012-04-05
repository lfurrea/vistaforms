class CreateForms < ActiveRecord::Migration
  def change
    create_table :forms do |t|
      t.string :name
      t.integer :carrier_id

      t.timestamps
    end
    add_index :forms, [:carrier_id, :created_at]
  end
end
