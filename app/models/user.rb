class User < ApplicationRecord

  def admin?
  role == "admin"
end

def customer?
  role == "customer"
end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
