class Micropost < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :like_users, through: :likes, source: :user
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader

  before_validation :kill_whitespace
  geocoded_by :address
  after_validation :geocode

  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 20 }
  validates :content, length: { maximum: 140 }
  validates :picture, presence: { message: 'が選択されていません' }

  paginates_per 9

  def like(user)
    likes.create(user_id: user.id)
  end

  def unlike(user)
    likes.find_by(user_id: user.id).destroy
  end

  def like?(user)
    like_users.include?(user)
  end

  private

  def kill_whitespace
      self.title = title.gsub(/[[:space:]]/, '') if self.title.present?
  end
end
