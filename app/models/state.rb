class State < ActiveRecord::Base
  validates_presence_of :name
  has_many :listings, inverse_of: :state, dependent: :nullify
end

