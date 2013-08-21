class ReverseController < ApplicationController
  def index
    @location = Location.last
  end
end
