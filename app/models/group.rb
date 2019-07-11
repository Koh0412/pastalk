class Group < ApplicationRecord
  belongs_to :user
  
  has_many :connects, dependent: :destroy
  has_many :connected, through: :connects, source: :user
  
  has_many :groupmessages, dependent: :destroy
  
  validates :name, presence: true, length: { maximum: 50 }
  validates :content, length: { maximum: 255 }
  
    def self.group_search(search)
        if !search.blank?
            Group.where(['name LIKE ?', "%#{search}%"])
        end
    end
end
