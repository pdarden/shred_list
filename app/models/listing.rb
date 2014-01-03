class Listing < ActiveRecord::Base
  validates_presence_of :title, :description
  validates_numericality_of :asking_price,
    only_integer: true,
    greater_than_or_equal_to: 0
  belongs_to :user,
    inverse_of: :listings
  belongs_to :state,
    inverse_of: :listings
end
