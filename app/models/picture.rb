class Picture < ActiveRecord::Base
  validates_presence_of :image

  belongs_to :equipment,
    inverse_of: :pictures

  mount_uploader :image, ImageUploader
end
