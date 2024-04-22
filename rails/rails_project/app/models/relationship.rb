class Relationship < ApplicationRecord
  # https://zenn.dev/ganmo3/articles/6e6d915c390515
  # 勝手に_id が付与されるので、_idは省略する必要がある
  # class_nameのforegn_key のなかにわたしたちRelationshipの belongs_toは所属しますよという声明
  belongs_to :follower, class_name: 'UserInfo', foreign_key: 'follower_id'
  belongs_to :followed, class_name: 'UserInfo', foreign_key: 'followed_id'
end
