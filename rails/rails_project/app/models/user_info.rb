class UserInfo < ApplicationRecord
    # 私たちuserInfoのuserIdは、たくさんのrelationは持っていますよという意思表明
        # 
    has_many :follower_relationships, class_name: 'Relationship', foreign_key: 'follower_id'
    has_many :followed_relationships, class_name: 'Relationship', foreign_key: 'followed_id'

    has_many :user_id_relationships, class_name: 'Fight',foreign_key:'user_id'
    
    validates :name, {uniqueness:true}
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email,uniqueness:true, presence: true, length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX }
            
    has_secure_password
end
