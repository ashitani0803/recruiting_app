class AddStatusToFeed < ActiveRecord::Migration[5.2]
  def change
    add_column :feeds, :status, :integer
  end
end
