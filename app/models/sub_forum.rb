class SubForum < ApplicationRecord
  belongs_to :user
  validates :user_id,
    presence: true
  validates :name,
    presence: true,
    length: {maximum: Settings.maximum_name_length},
    uniqueness: {case_sensitive: true}
  scope :trending_forums,-> {last(Settings.number_of_trending_forums).reverse}
end