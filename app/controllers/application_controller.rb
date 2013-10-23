class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :null_session #set up session control by sending a access_token with every request
  before_filter :set_format
  before_filter :find_user
  before_filter :set_access_control_headers
  around_filter :response_to_jsonp

  class UnauthorizedError < StandardError; end #extract all errors into errors.rb file

  def set_format
    request.format = 'json'
  end

  def set_access_control_headers
    if request.host == URI.parse(ChoremateApi::Application.config.api_url).host
      # copied from api.github.com
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'GET, POST, PATCH, PUT, DELETE'
      headers['Access-Control-Allow-Headers'] = 'Authorization, Content-Type, If-Match, If-Modified-Since, If-None-Match, If-Unmodified-Since, X-Requested-With'
      headers['Access-Control-Max-Age'] = '86400'

      # OPTIONS immediately return 200 with empty body
      head(:ok) if request.request_method == "OPTIONS"
    end
  end

  protected

  def response_to_jsonp
    yield
    ensure
      response.content_type = 'application/json'
      response.body = "#{{
      data: JSON.parse(response.body),
      meta: {
        status: response.status,
        success: (200...300).include?(response.status.to_i)
      }
      }.to_json}"
      response.status = :ok
  end

  def require_auth
    unless @user
      render json: {error: "Cannot authenticate user token"}, status: :unauthorized
    end
  end

  def find_user
    @user ||= if !params[:access_token].blank?
      User.find_by_access_token(params[:access_token])
    elsif !params[:email].blank? && !params[:password].blank?
      User.authenticate(params[:email], params[:password])
    end
  end

end
