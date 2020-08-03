class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
	has_many :book_comments, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end


  # @book検索の完全・前方・後方・一部一致の定義
  def self.search(search, word)
    if search == "perfect_match"
      @books = Book.where("title LIKE?","#{word}")
    elsif search == "forward_match"
      @books = Book.where("title LIKE?","#{word}%")
    elsif search == "backward_match"
      @books = Book.where("title LIKE?","%#{word}")
    elsif search == "partial_match"
      @books = Book.where("title LIKE?","%#{word}%")
    else
      @books = Book.all
    end
  end
end
