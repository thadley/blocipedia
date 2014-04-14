class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_and_belongs_to_many :wikis, :join_table => 'users_wikis'

  def role?(base_role)
    role == base_role.to_s
  end

  def self.all_except(user)
    where.not(id: user)
  end

end
