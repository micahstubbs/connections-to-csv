class User < ActiveRecord::Base
  attr_accessible :email, :provider, :name, :uid

  def self.from_omniauth(auth)
  	where(auth.slice("provider", "uid")).first || create_from_omniauth(auth)
  end

  def self.create_from_omniauth(auth)
  	create! do |user|
  	  user.provider = auth["provider"]
  	  user.name = auth["info"]["nickname"]
      user.email = auth["info"]["email"]
      user.uid = auth["uid"]
      user.token = auth["extra"]["access_token"]
      user.secret = auth["extra"]["access_token"]      

  	end
  end

=begin
# an attempt to call the LinkedIn API from within rails

  def self.retrieve_connections()
    access_token = LinkedInOAuth2::access_token
    response = access_token.get("http://api.linkedin.com/v1/people/~?format=json")
    puts response
  end  

  def self.retrieve_profile
  
    # Fill the keys and secrets you retrieved after registering your app
    api_key = ENV['LINKEDIN_KEY']
    api_secret = ENV['LINKEDIN_SECRET']
    user_token = ENV['LINKEDIN_OAUTH_USER_TOKEN']
    user_secret = ENV['LINKEDIN_OAUTH_USER_SECRET']
    
    # Specify LinkedIn API endpoint
    configuration = { :site => 'https://api.linkedin.com' }
    
    # Use your API key and secret to instantiate consumer object
    client = OAuth2::Client.new(api_key, api_secret, configuration)
    
    # Use your developer token and secret to instantiate access token object
    access_token = OAuth2::AccessToken.new(client, user_token, user_secret)
    
    # Make call to LinkedIn to retrieve your own profile
    #response = access_token.get("http://api.linkedin.com/v1/people/~")
    
    # By default, the LinkedIn API responses are in XML format. If you prefer JSON, simply specify the format in your call
    response = access_token.get("http://api.linkedin.com/v1/people/~?format=json")

    puts response
  end
=end

end
