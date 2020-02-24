class Feature < ApplicationRecord
	has_many :recruit_features
	has_many :recruits, through: :recruit_features
end
