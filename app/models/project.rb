class Project < ApplicationRecord
  belongs_to :user
  has_many :yarns, through: :project_yarns
  has_many :project_yarns, dependent: :destroy
end
