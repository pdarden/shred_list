class RidingStyle < ActiveRecord::Base
  validates_presence_of :name
  has_many :equipment,
    inverse_of: :riding_style,
    dependent: :nullify
end

