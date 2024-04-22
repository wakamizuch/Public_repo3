class Fight < ApplicationRecord
  belongs_to :user, class_name: 'UserInfo', foreign_key: 'user_id'
  belongs_to :task, class_name: 'Task', foreign_key: 'task_id'
end
