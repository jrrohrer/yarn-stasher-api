class Tag < ApplicationRecord
  belongs_to :taggable, polymorphic: true
  validates :name, presence: true

  # the 'tag_type' attribute is optional, I can foresee a future use for categories of tags, such as 'fiber' or 'event'
end
