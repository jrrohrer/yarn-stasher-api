class Project < ApplicationRecord
  belongs_to :user
  has_many :project_yarns, dependent: :destroy
  has_many :yarns, through: :project_yarns
  has_many :tags, as: :taggable, dependent: :destroy

  validates_presence_of :title
end
