class WelcomeController < ApplicationController
  
  def home
  	@articles = Article.all
  end

  def about
  end
end
