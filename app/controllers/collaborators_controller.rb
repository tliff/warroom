class CollaboratorsController < ApplicationController
  def new
    @graph = current_user.graphs.find params[:graph_id]
    return if !@graph
    @graph_share = @graph.graph_shares.new
    respond_to do |format|
      format.js do
        render :layout => false 
      end
    end
  end
  
  def create
    @graph = current_user.graphs.find params[:graph_id]
    return if !@graph
    @graph_share = @graph.graph_shares.new(params[:graph_share])
    respond_to do |format|
      format.js do
        if @graph_share.save
          render 'graphs/sharing', :layout => false 
        else
        end
      end
    end
  end
  
  def destroy
    @graph = current_user.graphs.find params[:graph_id]
    return if !@graph
    @graph_share = @graph.graph_shares.find(params[:id])
    @graph_share.delete
    respond_to do |format|
      format.js do
        render 'graphs/sharing', :layout => false 
      end
    end    
  end
end
