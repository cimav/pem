class AddSerialToSepCertificates < ActiveRecord::Migration[5.2]
  def change
  	add_column :pem_files, :serial, :string
  end
end
