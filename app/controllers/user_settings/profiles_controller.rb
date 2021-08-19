class UserSettings::ProfilesController < UserSettingsController
  def show; end

  def update
    @user = current_user
    @user.update(user_params)
    respond_to do |format|
      format.js
      format.html { redirect_to user_settings_profile_path }
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :introduction)
  end
end
