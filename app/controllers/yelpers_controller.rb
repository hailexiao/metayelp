class YelpersController < ApplicationController
  def index
    @yelpers = Yelper.all
  end
end
