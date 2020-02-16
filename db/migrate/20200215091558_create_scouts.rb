class CreateScouts < ActiveRecord::Migration[5.2]
  def change
    create_table :scouts do |t|
      t.integer :company_id
      t.integer :user_id
      t.text :message

      t.timestamps
    end
  end
end
