class User < ApplicationRecord
  attr_accessor :current_password


  after_initialize :set_role

  before_save { self.email = email.downcase if email.present? }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :wikis, dependent: :destroy

  def set_role
    self.role ||= 0
  end

  enum role: [:standard, :premium, :admin]

end
