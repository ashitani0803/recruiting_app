class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_PHONE_NUMBER_REGEX = /\A\d{10,11}\z/


  acts_as_paranoid

  attachment :image

  enum sex: { male: 0, female: 1}
  enum authority_status: { admin: 0, general: 1}

  belongs_to :company, optional: true
  has_many :follows, dependent: :destroy
  has_many :scouts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :rooms, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :supports, dependent: :destroy
  has_many :bookmarks, dependent: :destroy


  validates :name, :sex, :birth_year, :birth_month, :birth_day, presence: true, on: :create
  validates :email, format: { with: VALID_EMAIL_REGEX }, presence: true, on: :create
  validates :phone_number, format: { with: VALID_PHONE_NUMBER_REGEX }, allow_blank: true, on: :update


  def self.user_search(search)
    return User.all unless search
    User.where(['name LIKE ? OR introduction LIKE ? OR educational_background LIKE ? OR work_experience LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%"])
  end

  def self.scout_search(search)
      if search
          User.where(['name LIKE ? OR introduction LIKE ? OR educational_background LIKE ? OR work_experience LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%"])
      end
  end

end
