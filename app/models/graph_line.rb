class GraphLine < ActiveRecord::Base
  default_scope :order => "sortindex"
  belongs_to :graph
  belongs_to :source
end
