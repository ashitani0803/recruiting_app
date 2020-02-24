class AddColumnToUsers < ActiveRecord::Migration[5.2]
  def change
		add_column :users, :name, :string
		add_column :users, :image_id, :string
		add_column :users, :introduction, :text
		add_column :users, :educational_background, :string
		add_column :users, :work_experience, :string
		add_column :users, :company_id, :integer
		add_column :users, :birth_year, :integer
		add_column :users, :birth_month, :integer
		add_column :users, :birth_day, :integer
		add_column :users, :sex, :integer
		add_column :users, :authority_status, :integer
		add_column :users, :phone_number, :string
  end
end
