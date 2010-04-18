class ReportsController < ApplicationController

  def create
    data = Crack::JSON.parse(params[:data])
    if !Secret.find_by_secret(params[:secret]) 
      render :nothing => true
      return
    end

    data.each do |d|
      Sample.create_from_webpush(d)
    end
    render :nothing => true 
  end
end
