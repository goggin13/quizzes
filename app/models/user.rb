class User < ApplicationRecord
  ADMIN_EMAIL = "goggin13@gmail.com"
  validates_uniqueness_of :username
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  before_save :copy_email_to_username
  has_many :user_answers, dependent: :destroy
  has_many :user_results, dependent: :destroy

  def copy_email_to_username
    if username.blank? && !email.blank?
      self.username = email
    end
  end

  def admin?
    email == ADMIN_EMAIL
  end

  def email_required?
    false
  end

  def email_changed?
    false
  end
end
