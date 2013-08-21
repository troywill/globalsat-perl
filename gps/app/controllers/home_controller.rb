class HomeController < ApplicationController
  def index
    @location = Location.last
  end
end
