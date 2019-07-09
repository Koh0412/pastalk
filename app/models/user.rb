class User < ApplicationRecord
    before_save { self.email.downcase! }
    
    validates :name, presence: true, length: { maximum: 50 }
    validates :email, presence: true, length: { maximum: 255 }, 
     format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
     uniqueness: { case_sensitive: false }
    validates :comment, length: { maximum: 150 } 

    has_many :tags, dependent: :destroy
    
    has_many :connects, dependent: :destroy
    has_many :connectings, through: :connects, source: :group
    has_many :groups
    
    has_many :relationships, dependent: :destroy
    has_many :followings, through: :relationships, source: :follow
    has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
    has_many :followers, through: :reverses_of_relationship, source: :user
    
    has_secure_password
    
    def self.user_search(search)
        if !search.blank?
            User.where(['name LIKE ?', "%#{search}%"])
        end
    end
    
    def follow(other_user)
        unless self == other_user
            self.relationships.find_or_create_by(follow_id: other_user.id)
        end
    end
    
    def unfollow(other_user)
        relationship = self.relationships.find_by(follow_id: other_user.id)
        relationship.destroy if relationship
    end
    
    def following?(other_user)
        self.followings.include?(other_user)
    end
    
    def have_connect(group)
        self.connects.find_or_create_by(group_id: group.id)
    end
    
    def delete_connect(group)
        connect = self.connects.find_by(group_id: group.id)
        connect.destroy if connect
    end
    
    def connecting?(group)
        self.connectings.include?(group)
    end
end
