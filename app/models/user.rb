class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

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

  def self.user_search(search)
    return User.all unless search
    User.where(['name LIKE ?', "%#{search}%"])
  end

  def self.scout_search(search)
      if search
          User.where(['introduction LIKE ? OR educational_background LIKE ? OR work_experience LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%"])
      end
  end

end
