class GraphShare < ActiveRecord::Base
  belongs_to :user
  belongs_to :graph
  validates_presence_of :user
  validates_presence_of :graph
  
  def user_email
    user.email if user
  end
  
  def user_email= email
    self.user = User.find_by_email(email)
  end
end
