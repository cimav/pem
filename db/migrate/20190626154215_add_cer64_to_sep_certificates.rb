class AddCer64ToSepCertificates < ActiveRecord::Migration[5.2]
  def change
  	add_column :pem_files, :cer64, :text
  end
end
