class ApplicationController < ActionController::Base
  before_action :admin_only!
  skip_before_action :admin_only!, if: :devise_controller?

  def admin_only!
    unless signed_in? && current_user.admin?
      redirect_to public_index_url
    end
  end
end
