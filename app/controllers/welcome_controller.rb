class WelcomeController < ApplicationController
  def index
    @maps = Map.all
  end

  def about
  end

  def contact
    @contact_message = ContactMessage.new
  end
end
