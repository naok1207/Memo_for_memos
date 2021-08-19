# curl -X POST -H 'Authorization: Token <アクセストークン>' -H 'Content-Type:application/json' http://localhost:3000/api/memos -d '{"title": <作成するタイトル名>}'
class Api::MemosController < ApplicationController
  include ActionController::HttpAuthentication::Token::ControllerMethods
  skip_before_action :verify_authenticity_token
  before_action :authenticate

  def create
    memo = @user.memos.new(memo_params)
    memo.save
    head :no_content
  end

  protected

  def authenticate
    authenticate_or_request_with_http_token do |token, _options|
      @user = User.find_by(access_token: token)
    end
  end

  private

  def memo_params
    params.require(:memo).permit(:title)
  end
end
