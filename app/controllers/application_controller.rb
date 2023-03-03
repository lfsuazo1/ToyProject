class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!

  def after_sign_in_path_for(resource)
    admin_questions_path
  end

  def after_sign_out_path_for(resource)
    new_user_session_path
  end

end
