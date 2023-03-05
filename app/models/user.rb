class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :email, presence: { message: "The email field cannot be empty" },
                    uniqueness: { message: "Email is already in use" }

  # Personalizar mensaje de error para el campo de password
  validates :password, presence: { message: "The password field cannot be empty" },
                       length: { minimum: 6, message: "The password must be at least 6 characters long" }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :question
end
