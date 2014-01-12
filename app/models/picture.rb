class Picture < ActiveRecord::Base
  validates_presence_of :image

  belongs_to :picturable,
    polymorphic: true

  mount_uploader :image, ImageUploader
end
