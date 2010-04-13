class GraphsController < ApplicationController
  def index
    @tree = Source.tree
  end
  
  def create
    
  end
end
