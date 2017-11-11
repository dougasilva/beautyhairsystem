module SessionsHelper
  def sign_in(usuario)
    session[:usuario_id] = usuario.id
  end

  def current_user
    @current_user ||= Usuario.find_by(id: session[:usuario_id])
  end

  def block_access
    redirect_to usuarios_path if current_user.present?
  end

  def logged_in?
    !current_user.nil?
  end

  def sign_out
    session.delete(:usuario_id)
    @current_user = nil
  end
end
