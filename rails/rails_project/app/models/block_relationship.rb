class BlockRelationship < ApplicationRecord
  belongs_to :blocker, class_name: 'UserInfo', foreign_key: 'blocker_id'
  belongs_to :blocked, class_name: 'UserInfo', foreign_key: 'blocked_id'
  
end
