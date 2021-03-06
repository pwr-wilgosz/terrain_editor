class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to new_user_session_path, alert: "Nie masz odpowiednich uprawnień, by wykonać tę akcję. Zaloguj się lub zarejestruj"
  end
end
