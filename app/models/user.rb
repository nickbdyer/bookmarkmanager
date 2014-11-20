require 'bcrypt'
require 'mailgun'

class User

  AC_KEY = ENV['MAILGUN_AC']

  include DataMapper::Resource

  property :id, Serial
  property :email, String, :unique => true, :message => "This email is already taken"
  property :password_digest, Text
  property :password_token, Text
  property :password_token_timestamp, Time


  attr_reader :password
  attr_accessor :password_confirmation

  validates_confirmation_of :password, :message => "Sorry, your passwords don't match"

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def self.authenticate(email, password)
    user = first(:email => email)
    if user && BCrypt::Password.new(user.password_digest) == password
      user
    else
      nil
    end
  end
  
  def send_simple_message
    RestClient.post "https://#{AC_KEY}"\
    "@api.mailgun.net/v2/sandbox3900260de0784f0eb0f3ec80a443c03f.mailgun.org/messages",
    :from => "Mailgun Sandbox <postmaster@sandbox3900260de0784f0eb0f3ec80a443c03f.mailgun.org>",
    :to => "Nick <nbdyer@gmail.com>",
    :subject => "Password Reset",
    :text => "Congratulations Nick, you just sent an email with Mailgun! Follow this link to reset your password. http://localhost:9292/users/reset_password/#{self.password_token} "
  end

end
