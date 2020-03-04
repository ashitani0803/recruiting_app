class Feed < ApplicationRecord
    has_many :favorites, dependent: :destroy
    belongs_to :company

    attachment :image

    enum status: { draft: 0, published: 1 }

end
