class UserSettings::AccountsController < UserSettingsController
  def show; end

  def update
    render :show
  end
end
