class WelcomeController < ApplicationController
  before_filter :authenticate_user!

  def index
    @consumer_tokens = BoutineToken.where(:user_id => current_user)
  end

  def products
    # result = current_user.boutine_token.client.get('/api/v1/products/1').body
    # Or initialize and call Boutine's API manually as following:
    consumer_key    = OAUTH_CREDENTIALS[:boutine][:key]
    consumer_secret = OAUTH_CREDENTIALS[:boutine][:secret]

    consumer = OAuth::Consumer.new(consumer_key, consumer_secret, {:site=>"http://localhost:3000"})

    access_token  = current_user.boutine_token.token
    access_secret = current_user.boutine_token.secret
    access_token  = OAuth::AccessToken.new(consumer, access_token, access_secret)
    product_id = params[:id]
    if product_id
      result = access_token.get("/api/v1/products/#{params[:id]}", {'User-Agent' => 'My user agent'}).body
    else
      result = access_token.get("/api/v1/products/", {'User-Agent' => 'My user agent'}).body
    end

    render text: result
  end


end
