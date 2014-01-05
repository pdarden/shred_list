class Listing < ActiveRecord::Base

  validates_presence_of :title, :description
  validates_numericality_of :asking_price,
    only_integer: true,
    greater_than_or_equal_to: 0

  belongs_to :user,
    inverse_of: :listings
  belongs_to :state,
    inverse_of: :listings

  has_many :equipment,
    as: :equipmentable,
    dependent: :destroy
  has_many :offers,
    inverse_of: :listing,
    dependent: :destroy

  accepts_nested_attributes_for :equipment,
    reject_if: lambda { |a| a[:original_price].blank? },
    allow_destroy: true

  def asking_price=(val)
    write_attribute :asking_price, standardize_numbers(val)
  end

  def standardize_numbers(num)
    if num.to_s.match('.')
      num.to_s.sub!('.', '').to_i * 100
    else
      num.to_i * 100
    end
  end

  def price_in_dollars
    (asking_price.to_f / 100).round(2)
  end

end
