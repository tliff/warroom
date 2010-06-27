class Ability
  include CanCan::Ability

  def initialize(user)
    # Actions on Graphs
    
    # the owner and people who the graph is shared to can see it
    can :show, Graph do |g|
      g.user == user || GraphShare.where(:user => user).where(:graph => g).exists?
    end

    # the owner can edit the graph
    can :edit, Graph do |g|
      g.user == user
    end

    #the owner can delete the graph
    can :delete, Graph do |g|
      g.user == user
    end

  end
end
