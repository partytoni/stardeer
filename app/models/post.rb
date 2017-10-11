class Post < ApplicationRecord
  belongs_to :user
  belongs_to :place
  validates :user_id, presence: true
  validates :text, presence: true, length: { maximum: 140 }
  validates :rating, presence: true
  validates_inclusion_of :rating, :in => 1..5
  validates :place_id, presence: true

  validates_uniqueness_of :place_id,    scope: :user_id
end
