class UserSettings::AvatarsController < ApplicationController
  def confirm
    @user = User.new(avatar_params)
    if !@user.avatar.present?
      @user.avatar.retrieve_from_cache! @user.avatar_cache
    end
    @user.avatar_cache = @user.avatar.cache_name
    respond_to do |format|
      data = {}
      data[:html] = render_to_string(partial: 'user_settings/avatars/confirm')
      format.json { render json: data }
    end
  end

  def update
    # current_user.avatar = avatar_params[:avatar]
    @user = current_user
    @user.avatar = avatar_params[:avatar]
    @user.avatar_cache = avatar_params[:avatar_cache]
    @user.avatar.retrieve_from_cache! @user.avatar_cache
    if @user.save
      redirect_to user_settings_profile_path
    else
      # 失敗処理
    end
  end

  def destroy
    current_user.update!(avatar: nil)
    redirect_to user_settings_profile_path
  end

  private
  def avatar_params
    params.require(:user).permit(:avatar, :avatar_cache)
  end
end
