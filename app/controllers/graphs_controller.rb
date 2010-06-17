class GraphsController < ApplicationController
  before_filter :authenticate_user!
  def index
    @graphs = current_user.graphs
  end
  
  def new
    @graph = current_user.graphs.new
  end
  
  def edit
    @graph = current_user.graphs.find(params[:id])
    @sources = current_user.sources
  end
  
  def destroy
    @graph = current_user.graphs.find(params[:id])
    if @graph.delete
      flash[:notice] = "Graph has been deleted..."
    else
      flash[:error] = "Could not delete Graph"
    end
    redirect_to graphs_path
  end
  
  def update
    @graph = current_user.graphs.find(params[:id])
    @graph.update_attributes(params[:graph])
    if @graph.save
      flash[:notice] = "Graph has been created..."
    else
      flash[:error] = "Could not create Graph"
    end
    redirect_to edit_graph_path(@graph)
  end
  
  def create
    @graph = current_user.graphs.new(params[:graph])
    if @graph.save
      flash[:notice] = "Graph has been created..."
    else
      flash[:error] = "Could not create Graph"
    end
    redirect_to graphs_path
  end

  def show
    @graph = current_user.graphs.find(params[:id])
  end
  
  def updatesources
    @graph = current_user.graphs.find(params[:id])
    order = params[:order].split(';')
    graph_lines = []
    i=0
    order.each do |o|
      if matches = /graph_line_(\d+)/.match(o)
        gl = GraphLine.find(matches[1])
        gl.sortindex = i
        gl.save if gl.changed?
        graph_lines << gl.id
      elsif matches = /source_(\d+)/.match(o)
        source = Source.find(matches[1])
        gl = @graph.graph_lines.create(:source_id => source.id, :sortindex => i, :name => source.identifier, :color => "#0000ff")
        graph_lines << gl.id
      end
      i+=1
    end
    @graph.graph_lines.map(&:id).reject{|gl| graph_lines.member?(gl)}.each do |gl|
      gl.delete
    end
    respond_to do |format|
      format.js do
        render :layout => false 
      end
    end
  end

end
