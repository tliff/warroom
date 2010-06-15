class InfoController < ApplicationController

  def index
    if current_user
      redirect_to graphs_path
    end
  end
end
