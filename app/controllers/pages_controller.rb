class PagesController < ApplicationController

  skip_before_filter :require_user

  def index
    render :layout => false
  end

end
