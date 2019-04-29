class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         has_many :user_groups, dependent:   :destroy
         has_many :groups, through: :user_groups
         has_many :notices

         def is_group_joined?(group)
         	UserGroup.where(user_id: self.id,group_id:group.id).present?
         end
end
