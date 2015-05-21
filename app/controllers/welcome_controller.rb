class WelcomeController < ApplicationController
  def index
  end

  def about
    @maps = Map.all
  end

  def contact
    @contact_message = ContactMessage.new
  end
end
