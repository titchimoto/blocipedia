class Wiki < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: { minimum: 5, maximum: 75 }
  validates :body, presence: true, length: { minimum: 20 }

end
