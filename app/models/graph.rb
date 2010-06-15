class Graph < ActiveRecord::Base
  has_many :graph_lines, :dependent => :destroy 
  belongs_to :user
  
end
