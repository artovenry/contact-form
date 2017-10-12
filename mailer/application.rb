require "sinatra/base"
require "rack-protection"
require "sinatra/json"
require "action_mailer"
require "yaml"

class Mailer < ActionMailer::Base
  def notify_webmaster(contact)
    @contact= contact
    mail subject: "HPから問い合わせがありました", template_path: ""
  end
end

class Hash
  def symbolize_keys!
    keys.each {|key|self[(key.to_sym rescue key) || key] = delete(key)}
    self
  end
  alias :sym! :symbolize_keys!
end

class Application < Sinatra::Base
  ActionMailer::Base.class_eval do
    env= Application.environment.to_s
    root= File.expand_path("..", __FILE__)
    CONFIG= YAML.load_file("#{root}/credentials/config.contact.yaml")
    self.delivery_method= :smtp
    self.smtp_settings= CONFIG[env]["smtp_settings"].sym!
    default CONFIG[env]["addresses"].sym!
    self.view_paths= [root]
  end

  require "sinatra/reloader"
  require "sinatra/cross_origin"
  register Sinatra::CrossOrigin
  register Sinatra::Reloader

  if settings.development? 
    options "*" do
      response.headers["Access-Control-Allow-Origin"] = "*"
      response.headers["Access-Control-Allow-Credentials"] = "true"
      response.headers["Access-Control-Allow-Methods"] = "HEAD,GET,PUT,POST,DELETE,OPTIONS"
      response.headers["Access-Control-Allow-Headers"] = "X-Requested-With, X-HTTP-Method-Override, Content-Type, Cache-Control, Accept"
      200
    end
  end

  configure :development do
    disable :protection
    enable :cross_origin
    set :show_exceptions, false
  end

  before do
    if request.content_length.to_i > 0
      request.body.rewind
      @body= JSON.parse request.body.read, symbolize_names: true
    end
  end

  post "/" do
    sleep(rand(2..7)) if settings.development?
    begin
      Mailer.notify_webmaster(@body).deliver_now
      json response: {status: :success}
    rescue  Errno => error
      status 500
      json response: {status: :fail, error: error.errno}
    rescue Net::SMTPError => error
      status 500
      json response: {status: :fail, error: error}
    rescue
      status 500
      json response: {status: :fail}
    end
  end
end
