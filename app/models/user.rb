class User < ApplicationRecord
  belongs_to :province, optional: true
  has_many :orders

  def admin?
    role == "admin"
  end

  def customer?
    role == "customer"
  end

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end