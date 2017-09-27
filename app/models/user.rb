class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable#, :authentication_keys => [:username]

  ## Associations
  has_many :orders, dependent: :destroy
  has_many :cart_items, through: :cart
  has_one :cart

  ##Methods
  def cart_items_count
    self.cart_items.map(&:quantity).inject(:+) || 0
  end
end
