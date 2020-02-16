class CreateSupports < ActiveRecord::Migration[5.2]
  def change
    create_table :supports do |t|
      t.integer :user_id
      t.integer :recruit_id

      t.timestamps
    end
  end
end
