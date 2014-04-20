class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_and_belongs_to_many :roles
  after_create :default_role
  def role?(role)
    return !!self.roles.find_by_name(role.to_s)
  end
  
  
  private
  def default_role
    self.roles << Role.create!(:name => "user")
  end
end
