class CreateFeeds < ActiveRecord::Migration[5.2]
  def change
    create_table :feeds do |t|
      t.integer :company_id
      t.string :title
      t.string :image_id
      t.text :body

      t.timestamps
    end
  end
end
