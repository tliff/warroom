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
  
  def updatesources
    @graph = Graph.find(params[:id])
    order = params[:order].split(';')
    graph_lines = []
    i=0
    order.each do |o|
      if matches = /graph_line_(\d+)/.match(o)
        gl = GraphLine.find(matches[1])
        gl.sortindex = i
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
