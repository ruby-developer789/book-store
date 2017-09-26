class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable#, :authentication_keys => [:username]

  has_many :orders, dependent: :destroy
  has_one :cart

  def email_required?
    false
  end

  def email_changed?
    false
  end
end
