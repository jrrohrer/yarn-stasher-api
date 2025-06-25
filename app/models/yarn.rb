class Yarn < ApplicationRecord
  belongs_to :user
  has_many :project_yarns, dependent: :destroy
  has_many :projects, through: :project_yarns
  has_many :tags, as: :taggable, dependent: :destroy

  validates :colorway, presence: true
end
