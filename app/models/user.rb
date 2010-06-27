class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation
  
  has_many :secrets, :dependent => :destroy
  has_many :sources, :dependent => :destroy
  has_many :graphs, :dependent => :destroy
  has_many :graph_shares, :dependent => :destroy
  has_many :shared_graphs, :class_name => "Graph", :through => :graph_shares  

  
end
