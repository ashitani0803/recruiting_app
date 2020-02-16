class Feed < ApplicationRecord
    has_many :favorites, dependent: :destroy
    belongs_to :company
end
