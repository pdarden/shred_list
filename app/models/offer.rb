class Offer < ActiveRecord::Base
  validates_presence_of :description
  belongs_to :user,
    inverse_of: :offers
  belongs_to :listing,
    inverse_of: :offers
  has_many :pictures,
    as: :picturable,
    dependent: :destroy
  accepts_nested_attributes_for :pictures, allow_destroy: true
  has_many :replies,
    source: :senders,
    dependent: :destroy

end

