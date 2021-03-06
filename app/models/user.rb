class User < ApplicationRecord
    before_save { self.email.downcase! }
    
    validates :name, presence: true, length: { maximum: 50 }
    validates :email, presence: true, length: { maximum: 255 }, 
     format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
     uniqueness: { case_sensitive: false }
    validates :comment, length: { maximum: 150 } 

    # タグ
    has_many :tags, dependent: :destroy
    
    # グループトーク
    has_many :connects, dependent: :destroy
    has_many :connectings, through: :connects, source: :group
    has_many :groups
    has_many :groupmessages
    has_many :user_messages, through: :groupmessages, source: :group
    
    # DM
    has_many :messages
    has_many :sent_messages, through: :messages, source: :receive_user
    has_many :reverces_of_message, class_name: 'Message', foreign_key: 'receive_user_id'
    has_many :received_messages, through: :reverces_of_message, source: :user
    
    # フォロー
    has_many :relationships, dependent: :destroy
    has_many :followings, through: :relationships, source: :follow
    has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
    has_many :followers, through: :reverses_of_relationship, source: :user
    
    has_secure_password
    
    # search
    def self.user_search(search)
        if !search.blank?
            User.where(['name LIKE ?', "%#{search}%"])
        end
    end
    
    def self.tag_search(tag_search)
        if !tag_search.blank?
            Tag.where(['name LIKE ?', "%#{tag_search}%"])
        end
    end
    
    # follow
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
    
    # connect
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
