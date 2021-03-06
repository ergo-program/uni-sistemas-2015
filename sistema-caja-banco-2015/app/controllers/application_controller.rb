class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  add_flash_types :success, :warning, :danger, :info
  before_action :authenticate_user!

  before_action :configure_permitted_parameters, if: :devise_controller?
  protected

  def configure_permitted_parameters
  	devise_parameter_sanitizer.for(:sign_up)  { |u| u.permit( :username, :email,:password, :password_confirmation , :apellido, :numero_ci, :direccion, :ciudad_id, :pai_id, :telefono, :celular, :estado, roles: [] ) }
  end 

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  before_filter do
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end
end

