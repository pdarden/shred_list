class Equipment < ActiveRecord::Base
  validates_presence_of :original_price, :category_id, :brand_id
  validates_numericality_of :original_price,
    greater_than_or_equal_to: 0
  belongs_to :brand,
    inverse_of: :equipment
  belongs_to :category,
    inverse_of: :equipment
  belongs_to :riding_style,
    inverse_of: :equipment
  belongs_to :listing,
    inverse_of: :equipment
  has_many :pictures,
    as: :picturable,
    dependent: :destroy

  def price_in_dollars
    "#{'%.2f' % (original_price.to_d / 100) if original_price}"
  end

  def price_in_dollars=(dollars)
    dollars = dollars.to_s.gsub(/[^0-9\.]+/, '')
    self.original_price = dollars.to_d * 100 if dollars.present?
  end
end

