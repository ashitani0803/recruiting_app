class AddColumnToRecruits < ActiveRecord::Migration[5.2]
  def change
		add_column :recruits, :image_id, :string
  end
end
