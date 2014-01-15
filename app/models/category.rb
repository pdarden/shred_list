class Category < ActiveRecord::Base
  validates_presence_of :name
  has_many :equipment,
    inverse_of: :category,
    dependent: :nullify
end

