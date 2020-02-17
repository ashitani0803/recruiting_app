class Recruit < ApplicationRecord
    belongs_to :company
    has_many :bookmarks, dependent: :destroy
    has_many :supports, dependent: :destroy
    has_many :entries, dependent: :destroy

    attachment :image

    def self.recruit_search(search)
        return Recruit.all unless search
        Recruit.where(['title LIKE ? OR do LIKE ? OR job_description LIKE ?,' "%#{search}%", "%#{search}%", "%#{search}%"])
    end
end
