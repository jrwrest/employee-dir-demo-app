class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :avatar
  attr_accessor :skip_password_validation


  def self.search(search)
    if search
      where('name or email LIKE ?', "%#{search}%")
    else
      where(nil)
    end
  end

  private

  def password_required?
        return false if skip_password_validation
     super
  end

end
