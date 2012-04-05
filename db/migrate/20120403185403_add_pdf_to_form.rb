class AddPdfToForm < ActiveRecord::Migration
  def self.up
    add_column :forms, :pdf_form_file_name, :string #Original filename
    add_column :forms, :pdf_form_content_type, :string #Mime type
    add_column :forms, :pdf_form_file_size, :integer #File size in bytes
  end

  def self.down
    remove_column :forms, :pdf_form_file_name
    remove_column :forms, :pdf_form_content_type
    remove_column :forms, :pdf_form_file_size
  end
end
