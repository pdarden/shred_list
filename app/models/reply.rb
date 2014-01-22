class Reply < ActiveRecord::Base
  validates_presence_of :body, :offer_id, :sender_id
  belongs_to :offer,
    inverse_of: :replies
  belongs_to :sender,
    class_name: 'User',
    inverse_of: :replies
end
