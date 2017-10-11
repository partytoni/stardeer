class Place < ApplicationRecord
  has_many :posts
  validates :name, presence: true
  validates :address, presence: true
  validates :site, presence: true
  validates :place_id, presence: true
  validates :city, presence: true
  validates :cc, presence: true

  validates_uniqueness_of :place_id,    scope: :site
end
