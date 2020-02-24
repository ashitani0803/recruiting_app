class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.integer :head_status
      t.string :postal_code
      t.string :prefecture
      t.string :municipality
      t.string :building
      t.integer :company_id

      t.timestamps
    end
  end
end
