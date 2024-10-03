class TypingController < ApplicationController
  def home
    @results = Typing::Result.order(time: :asc)
  end

  def play

  end
end
