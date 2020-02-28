class Company < ApplicationRecord
    has_many :users
    has_many :addresses, dependent: :destroy
    has_many :feeds, dependent: :destroy
    has_many :follows, dependent: :destroy
    has_many :scouts, dependent: :destroy
    has_many :recruits, dependent: :destroy
    has_many :rooms, dependent: :destroy

    acts_as_paranoid

    accepts_nested_attributes_for :addresses, allow_destroy: true

    attachment :logo

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    VALID_PHONE_NUMBER_REGEX = /\A\d{10,11}\z/

    validates :company_name, :person_name, presence: true
    validates :email, format: { with: VALID_EMAIL_REGEX }, presence: true
    validates :phone_number, format: { with: VALID_PHONE_NUMBER_REGEX }, presence: true

    def self.company_search(search)
        return Company.all unless search
        Company.where(['company_name LIKE ?', '%#{search}%'])
    end
end
