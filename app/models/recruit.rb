class Recruit < ApplicationRecord
    belongs_to :company
    has_many :bookmarks, dependent: :destroy
    has_many :supports, dependent: :destroy
    has_many :entries, dependent: :destroy
    has_many :recruit_features
    has_many :features, through: :recruit_features

    attachment :image

    enum occupation: { engineer: 0, designer: 1, directer: 2, cooperate: 3, sales: 4, marketing: 5, writer: 6, medical: 7, other: 8 }
    enum employment_status: { new_graduate: 0, internship: 1, mid_career: 2, side_job: 3 }

    def self.recruit_search(search)
        return Recruit.all unless search
        Recruit.where(['title LIKE ? OR do LIKE ? OR job_description LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%"])
    end
end
