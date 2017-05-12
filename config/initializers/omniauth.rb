require 'omniauth-openid'
require 'omniauth-facebook'
require 'openid/store/filesystem'

OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET'], :token_params => {
    :parse => :json
  }
end
