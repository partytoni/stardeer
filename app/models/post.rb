class Post < ApplicationRecord
  belongs_to :user
  belongs_to :place
  validates :user_id, presence: true
  validates :text, presence: true, length: { maximum: 140 }

end
