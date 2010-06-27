class Graph < ActiveRecord::Base
  has_many :graph_lines, :dependent => :destroy 
  has_many :graph_shares, :dependent => :destroy
  
  belongs_to :user
  has_many :collaborators, :class_name => 'User', :through => :graph_shares, :source => :user    

  scope :visible_to, lambda {|user|
    joins(:graph_shares).where(["graphs.user_id=? OR graph_shares.user_id=?", user.id, user.id])
  }
  
end
