class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # belongs_to :books
  has_one_attached :profile_image
  has_many :books, dependent: :destroy
  # has_many :favorites, dependent: :destroy
  # has_many :book_comments, dependent: :destroy

  # foreign_key（FK）には、@user.xxxとした際に「@user.idがfollower_idなのかfollowed_idなのか」を指定します。
  has_many :active_relationship, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationship, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # @user.booksのように、@user.yyyで、
  # そのユーザがフォローしている人orフォローされている人の一覧を出したい
  has_many :followings, through: :active_relationship, source: :followed
  has_many :followers, through: :passive_relationship, source: :follower

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }


  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end

  # フォローする
  def follow(user_id)
    active_relationship.create(followed_id: user_id)
  end

  # フォローを外す
  def unfollow(user_id)
    active_relationship.find_by(followed_id: user_id).destroy
  end

  # すでにフォローしているのか確認
  def following?(user)
    followings.include?(user)
  end
end
