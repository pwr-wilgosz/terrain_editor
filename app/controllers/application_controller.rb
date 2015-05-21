class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: "Nie masz odpowiednich uprawnień, by wykonać tę akcję."
  end
end
