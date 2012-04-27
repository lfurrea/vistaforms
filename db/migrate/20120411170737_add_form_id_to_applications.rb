class AddFormIdToApplications < ActiveRecord::Migration
  def change
    add_column :applications, :form_id, :integer

  end
end
