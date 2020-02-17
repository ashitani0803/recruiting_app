class CreateCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :companies do |t|
      t.string :company_name
      t.string :person_name
      t.string :email
      t.string :phone_number
      t.string :logo_id
      t.integer :establish_year
      t.string :establish_month
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
