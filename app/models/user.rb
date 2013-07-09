class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable ,:omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name,:last_name,:linkedin_uid,:mobile_number,
                  :city,:location, :address,:provider

  has_many :authentications
  has_many :spaces


  ## Validations
  validates :first_name,presence: true, length: {minimum: 2,maximum: 50 }
  validates :last_name, length: {maximum: 50 }, allow_blank: true
  validates :address, length: {maximum: 250 }, allow_blank: true


  def self.find_for_linkedin_oauth(access_token, signed_in_resource=nil)
    data = access_token.extra.raw_info
    if user = self.find_by_email(data.try(:emailAddress))
      user
    else # Create a user with a stub password.
      user = User.new(email: data.try(:emailAddress),first_name:data.try(:firstName),last_name: data.try(:lastName),linkedin_uid: data.try(:id),
                      city: data.try(:location).try(:name),address: data.try(:mainAddress),
                       provider: "linkedin")
      #user.password = Devise.friendly_token[0,20]
      user
    end
  end

end
