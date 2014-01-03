class Brand < ActiveRecord::Base
  validates_presence_of :name
  has_many :equipment,
    inverse_of: :brand,
    dependent: :nullify
end
