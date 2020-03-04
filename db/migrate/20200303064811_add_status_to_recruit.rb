class AddStatusToRecruit < ActiveRecord::Migration[5.2]
  def change
    add_column :recruits, :status, :integer
  end
end
