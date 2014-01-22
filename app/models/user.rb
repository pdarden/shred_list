class User < ActiveRecord::Base
  include FriendlyId
  friendly_id :username
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, authentication_keys: [:login]
  attr_accessor :login

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { value: login.downcase }]).first
    else
      where(conditions).first
    end
  end

  validates_presence_of :first_name, :last_name, :email, :password, :username, :password_confirmation
  validates_uniqueness_of :username,
    case_insensitive: true

  has_many :offers,
    inverse_of: :user,
    dependent: :destroy
  has_many :listings,
    inverse_of: :user,
    dependent: :destroy
  has_many :replies,
    inverse_of: :sender,
    dependent: :destroy
end

