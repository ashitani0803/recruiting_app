class CreateCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :logo
      t.integer :establishment_year
      t.string :establishment_month
      t.string :link
      t.string :mission_title
      t.text :mission_body
      t.text :value
      t.text :what
      t.text :why
      t.text :how

      t.timestamps
    end
  end
end
