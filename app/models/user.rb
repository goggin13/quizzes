class User < ApplicationRecord
  ADMIN_EMAIL="goggin13@gmail.com"
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def admin?
    email == ADMIN_EMAIL
  end
end
