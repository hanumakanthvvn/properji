class Admin < ActiveRecord::Base
  attr_accessible :email, :password, :name
  devise :database_authenticatable, :timeoutable
end
