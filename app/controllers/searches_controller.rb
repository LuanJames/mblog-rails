class SearchesController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @results = User.search params[:q]
  end
end
