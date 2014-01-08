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

  def price_in_dollars
    "#{'%.2f' % (original_price.to_d / 100) if original_price}"
  end

  def price_in_dollars=(dollars)
    dollars = dollars.to_s.gsub(/[^0-9\.]+/, '')
    self.original_price = dollars.to_d * 100 if dollars.present?
  end
end
