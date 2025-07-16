class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  helper_method :current_user, :logged_in?

  private
  # Tenta encontrar um possível usuario com login feito e qual usuario
  def current_user
    @current_user ||= user.find_by(id: session[:user_id]) if session[:user_id]
  end

  # Método booleano para verificar se existe um usuario com login feito
  def logged_in?
    !!current_user
  end

  # PRECISA FAZER UM METODO (Def autorize) PARA 
  # PROTEGER AS PAGINAS Q PRECISAM DE LOGIN ?

end
