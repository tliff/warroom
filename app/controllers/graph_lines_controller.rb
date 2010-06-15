class GraphLinesController < ApplicationController
  before_filter :authenticate_user!
  
  def create
    @graph = current_user.graphs.find params[:graph_id]
    return if !@graph
    @graph_line = @graph.graph_lines.create(params[:graph_line])
    if @graph_line.save
      flash[:notice] = "Source has been added to Graph"
    else
      flash[:error] = "Could not add Source to Graph"
    end
    redirect_to graph_path(@graph_line.graph)
  end
  
  def destroy
    @graph = current_user.graphs.find params[:graph_id]
    return if !@graph
    @graph_line = @graph.graph_lines.find(params[:id])
    @graph_line.delete
    respond_to do |format|
      format.js do
        render :layout => false 
      end
    end
    
  end
  
  def edit
    @graph = current_user.graphs.find params[:graph_id]
    return if !@graph
    @graph_line = @graph.graph_lines.find params[:id]
    respond_to do |format|
      format.js do
        render :layout => false 
      end
    end
  end

  def update
    @graph = current_user.graphs.find params[:graph_id]
    return if !@graph
    @graph_line = @graph.graph_lines.find params[:id]
    @graph_line.update_attributes(params[:graph_line])
    @graph_line.save
    respond_to do |format|
      format.js do
        render :layout => false 
      end
    end
  end

  def show
    @graph = current_user.graphs.find params[:graph_id]
    return if !@graph
    @graph_line = @graph.graph_lines.find(params[:id])
    respond_to do |format|
      format.json do
        render :json => {:sortindex => @graph_line.sortindex, :color => @graph_line.color, :fillColor => @graph_line.color, :label => @graph_line.name, :data => @graph_line.source.samples.map{|s| [s.sampled_at.to_i*1000, s.value]}}
      end
    end
  end
  
  def day
    show_template(300,1.day.ago)
  end
  
  def week
    show_template(1800,1.week.ago)
  end
  
  def month
    show_template(7200,1.month.ago)
  end
  
  def quarter
    show_template(28800,3.months.ago)
  end
  
  def year
    show_template(86400,1.year.ago)
  end

  private
  def show_template(i, date)
    @graph = current_user.graphs.find params[:graph_id]
    return if !@graph
    @graph_line = @graph.graph_lines.find(params[:id])
    respond_to do |format|
      format.json do
        render :json => { :sortindex => @graph_line.sortindex, 
                          :color => @graph_line.color, 
                          :fillColor => @graph_line.color, 
                          :label => @graph_line.name, 
                          :data => @graph_line.source.samples.select("AVG(values) AS values, AVG((FLOOR(EXTRACT('epoch' FROM sampled_at)/#{i}))) AS sampled_at").where(["sampled_at > ?", date]).group("(FLOOR(EXTRACT('epoch' FROM sampled_at)/#{i}))").map{|s| [s.sampled_at.to_i*1000, s.value]}}
      end
    end    
  end

end
