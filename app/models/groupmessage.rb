class Groupmessage < ApplicationRecord
  belongs_to :user
  belongs_to :group
  
  validates :body, presence: true, length: { maximum: 300 }
end
