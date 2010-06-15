require 'digest/sha1'

class SecretsController < ApplicationController
  before_filter :authenticate_user!  
  def index
    @secrets = current_user.secrets
  end
  
  def destroy
    @secret = current_user.secrets.find(params[:id])
    if @secret.delete
      flash[:notice] = "Secret has been deleted..."
    else
      flash[:error] = "Error deleting secret"
    end
    redirect_to secrets_path
  end
  
  
  def create
    @secret = current_user.secrets.new(:secret => Digest::SHA1.hexdigest(current_user.id.to_s + Time.now.to_s + 'salty' + rand.to_s))
    if @secret.save
      flash[:notice] = "Successfully created new secret..."
    else
      flash[:error] = "Could not create secret..."
    end
    redirect_to secrets_path
  end
  
end
