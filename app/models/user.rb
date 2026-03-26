class User < ApplicationRecord
  def change
    add_column :users, :role, :string, default: "customer"
  end
end
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
