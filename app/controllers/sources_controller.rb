class SourcesController < ApplicationController
  before_filter :authenticate_user!
  def index
    @tree = current_user.sources.tree
  end
  
  def create
    
  end
  
  def delete
    
  end
  
  def show
    @source = current_user.sources.find(params[:id])
  end
end
