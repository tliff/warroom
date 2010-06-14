class GraphsController < ApplicationController
  def index
    @graphs = Graph.all
  end
  
  def new
    @graph = Graph.new
  end
  
  def edit
    @graph = Graph.find(params[:id])
    @sources = Source.all
  end
  
  def update
    
  end
  
  def create
    @graph = Graph.new(params[:graph])
    if @graph.save
      flash[:notice] = "Graph has been created..."
    else
      flash[:error] = "Could not create Graph"
    end
    redirect_to graphs_path
  end

  def show
    @graph = Graph.find(params[:id])
  end

end
