class Offer < ActiveRecord::Base
  validates_presence_of :description
  belongs_to :user,
    inverse_of: :offers
  belongs_to :listing,
    inverse_of: :offers
  has_many :equipment,
    inverse_of: :offers,
    dependent: :destroy
end
