class Equipment < ActiveRecord::Base
  validates_presence_of :original_price
  validates_numericality_of :original_price,
    greater_than_or_equal_to: 0
  belongs_to :brand,
    inverse_of: :equipment
  belongs_to :category,
    inverse_of: :equipment
  belongs_to :riding_style,
    inverse_of: :equipment
  belongs_to :equipmentable,
    polymorphic: true
  has_many :pictures,
    dependent: :destroy

end
