class User < ApplicationRecord
  has_many :yarns
  has_many :projects
end
