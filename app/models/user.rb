class User < ApplicationRecord
  attr_accessor :current_password

  enum role: [:standard, :premium, :admin]

  has_many :wikis, dependent: :destroy

  after_initialize :set_role
  before_save { self.email = email.downcase if email.present? }
  after_save :downgrade_private_wikis

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  private

  def downgrade_private_wikis
    if self.standard?
      self.wikis.where(private: true).each do |wiki|
        wiki.private = false
        wiki.save
      end
    end
  end

  def set_role
    self.role ||= 0
  end

end
