class Wiki < ActiveRecord::Base
  
  belongs_to :user
  has_and_belongs_to_many :collaborators, :class_name => 'User', :join_table => 'users_wikis'

  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true

end
