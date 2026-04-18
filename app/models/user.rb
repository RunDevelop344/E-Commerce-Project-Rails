class User < ApplicationRecord
  belongs_to :province, optional: true
  has_many :orders

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :role, presence: true, inclusion: { in: %w[admin customer] }

  def admin?
    role == "admin"
  end

  def customer?
    role == "customer"
  end

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
