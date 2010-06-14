class GraphLinesController < ApplicationController
  def create
    @graph_line = GraphLine.create(params[:graph_line])
    if @graph_line.save
      flash[:notice] = "Source has been added to Graph"
    else
      flash[:error] = "Could not add Source to Graph"
    end
    redirect_to graph_path(@graph_line.graph)
  end

  def show
    @graph_line = GraphLine.find(params[:id])
    respond_to do |format|
      format.json do
        render :json => {:color => @graph_line.color, :fillColor => @graph_line.color, :label => @graph_line.name, :data => @graph_line.source.samples.map{|s| [s.sampled_at.to_i*1000, s.value]}}
      end
    end
  end
end
