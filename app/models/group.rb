class Group < ApplicationRecord
  belongs_to :user
  has_many :joins, dependent: :destroy
  has_many :users_joined, through: :joins, source: :user
  validates :name, presence: true, length: {in: 5..34}
  validates :description, presence: true, length: {in: 10..100}
end
