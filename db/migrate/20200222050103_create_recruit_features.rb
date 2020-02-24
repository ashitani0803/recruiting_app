class CreateRecruitFeatures < ActiveRecord::Migration[5.2]
  def change
    create_table :recruit_features do |t|
      t.integer :recruit_id
      t.integer :feature_id

      t.timestamps
    end
  end
end
