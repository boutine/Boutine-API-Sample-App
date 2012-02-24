class BoutineToken < ConsumerToken
  belongs_to :user
  attr_accessible :user, :user_id

  BOUTINE_SETTINGS = {
    :site => "http://localhost:3000",
    :request_token_path => "/oauth/request_token",
    :access_token_path => "/oauth/access_token",
    :authorize_path => "/oauth/authorize"
  }


  def self.consumer(options={})
    @consumer ||= OAuth::Consumer.new(credentials[:key], credentials[:secret], BOUTINE_SETTINGS.merge(options))
  end
end
