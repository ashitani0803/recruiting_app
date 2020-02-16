class Recruit < ApplicationRecord
    belongs_to :company
    has_many :bookmarks, dependent: :destroy
    has_many :supports, dependent: :destroy
    has_many :entries, dependent: :destroy
end
