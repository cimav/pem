class CreatePemFiles < ActiveRecord::Migration[5.2]
  def change
    create_table :pem_files do |t|
      t.string :email
      t.integer :status
      t.text :key
      t.text :cer

      t.timestamps
    end
  end
end
