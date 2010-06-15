class ReportsController < ApplicationController
  before_filter :authenticate_user!
  def create
    data = Crack::JSON.parse(params[:data])
    if !(@secret = Secret.find_by_secret(params[:secret]) )
      render :nothing => true
      return
    end

    data.each do |d|
      Sample.create_from_webpush(d, @secret)
    end
    render :nothing => true 
  end
end
