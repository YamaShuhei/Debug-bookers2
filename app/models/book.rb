class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user
  has_many :book_comments, dependent: :destroy
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  # def self.week_count
  #   Book.joins(:favorites).where(favorites: { created_at: 0.days.ago.prev_week..0.days.ago.prev_week(:sunday)}).group(:id).order("count(*) desc")
  # end

def self.looks(search, word)
  if search == "perfect_match"
    @book = Book.where("title LIKE?", "#{word}")
  elsif search == "forward_match"
    @book = Book.where("title LIKE?", "#{word}%")
  elsif search == "backward_match"
    @book = Book.where("title LIKE?", "%#{word}")
  elsif search == "partical_match"
    @book = Book.where("title LIKE?", "%#{word}%")
  else
    @book = Book.all
  end
end

end
