module FormHelper
  def setup_user(profissional)
    profissional.usuario ||= Usuario.new
    profissional
  end
end
