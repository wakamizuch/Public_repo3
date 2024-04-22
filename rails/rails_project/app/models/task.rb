class Task < ApplicationRecord

  has_many :task_id_relationships, class_name: 'Fight',foreign_key:'task_id'
end
