class Typing::HomeController < ApplicationController
  def home
    @results = Typing::Result.order(time: :asc)
  end
end
