class Listing < ActiveRecord::Base

  validates_presence_of :title, :description, :state_id
  validates_numericality_of :asking_price,
    greater_than_or_equal_to: 0,
    allow_nil: true

  belongs_to :user,
    inverse_of: :listings
  belongs_to :state,
    inverse_of: :listings

  has_many :equipment,
    inverse_of: :listing,
    dependent: :destroy
  has_many :offers,
    inverse_of: :listing,
    dependent: :destroy

  def price_in_dollars
    "#{'%.2f' % (asking_price.to_d / 100) if asking_price}"
  end

  def price_in_dollars=(dollars)
    dollars = dollars.to_s.gsub(/[^0-9\.]+/, '')
    self.asking_price = dollars.to_d * 100 if dollars.present?
  end

  def owned_by?(viewer)
    if !viewer.nil?
      self.user_id == viewer.id
    end
  end

  def has_image?
    self.each do |equip|
      next if equip.pictures.nil?
      equip.pictures.first.image_url
    end
  end

  def equipment_image
    pictures = equipment.sample.pictures
    pictures.sample.image_url(:thumb).to_s if pictures.count > 0
  end

  def state_name
    id = self.state_id
    State.find(id).name
  end

  def categories
    equipment.map{ |e| Category.find(e.category_id) }.uniq
  end

  def brands
    equipment.map{ |e| Brand.find(e.brand_id) }.uniq
  end

  def user_id
    self.user.id
  end

  def username
    user.username.capitalize
  end
end

