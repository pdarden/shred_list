class Offer < ActiveRecord::Base
  validates_presence_of :description
  belongs_to :user,
    inverse_of: :offers
  belongs_to :listing,
    inverse_of: :offers
  has_many :equipment,
    as: :equipmentable,
    dependent: :destroy
end
