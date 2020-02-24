class CreateRecruits < ActiveRecord::Migration[5.2]
  def change
    create_table :recruits do |t|
      t.integer :company_id
      t.string :title
      t.text :do
      t.integer :occupation
      t.string :job_description
      t.integer :employment_status
      t.string :field

      t.timestamps
    end
  end
end
