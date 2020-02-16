class Company < ApplicationRecord
    has_many :addresses, dependent: :destroy
    has_many :feeds, dependent: :destroy
    has_many :follows, dependent: :destroy
    has_many :scouts, dependent: :destroy
    has_many :recruits, dependent: :destroy
end
