class Listing < ActiveRecord::Base

  validates_presence_of :title, :description
  validates_numericality_of :asking_price,
    greater_than_or_equal_to: 0,
    allow_nil: true

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

  def owned_by?(viewer)
    self.user_id == viewer.id
  end

end
