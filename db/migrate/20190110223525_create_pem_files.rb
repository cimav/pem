class CreatePemFiles < ActiveRecord::Migration[5.2]
  def change
    create_table :pem_files do |t|
      t.string :email
      t.integer :status
      t.text :private_key
      t.text :public_key
      t.text :private_key_open

      t.timestamps
    end
  end
end
