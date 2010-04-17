class SourcesController < ApplicationController
  def index
    @tree = Source.tree
  end
  
  def create
    
  end
  
  def delete
    
  end
  
  def show
    @source = Source.find(params[:id])
  end
end
