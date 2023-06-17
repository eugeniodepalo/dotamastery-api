class SessionsController < ApplicationController
  def create
    user = create_or_update_user!
    user.regenerate_auth_token
    SyncRecentMatchesJob.perform_unique(user: user)
    redirect_to "#{request.env['omniauth.origin']}?token=#{user.auth_token}&user_id=#{user.id}"
  end

  private

  def create_or_update_user!
    auth = request.env['omniauth.auth']
    user = User.find_or_initialize_by(original_id: SteamUtils.player_id_for(auth.uid.to_i))
    user.update!(name: auth.info.nickname)
    user
  end
end
