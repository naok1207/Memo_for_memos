class UserSettings::AccountsController < UserSettingsController
  def show; end

  def update
    if current_user.update_password(params[:old_password], params[:new_password], params[:new_password_confirmation])
      redirect_to user_settings_account_path
    else
      render :show
    end
  end
end
