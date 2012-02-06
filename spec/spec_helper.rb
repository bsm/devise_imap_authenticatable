ENV["RAILS_ENV"] ||= 'test'

$: << File.expand_path('../../lib', __FILE__)
require 'rubygems'
require 'bundler/setup'

require 'rails'
require 'rails/test_help'
require 'action_controller/railtie'
require 'devise_imap_authenticatable'
require 'devise/orm/active_record'
require 'active_support/core_ext/string'

ActiveRecord::Base.tap do |base|
  base.configurations["test"] = { 'adapter' => 'sqlite3', 'database' => ":memory:" }
  base.establish_connection(:test)
  base.connection.create_table :users do |t|
    t.string  :email
  end
end

Devise.setup do |config|
  config.case_insensitive_keys = [ :email ]
  config.strip_whitespace_keys = [ :email ]
  config.reset_password_within = 6.hours
  config.use_salt_as_remember_token = true
end

class TestScenario < Rails::Application
  config.root = File.expand_path('../scenario', __FILE__)
  config.active_support.deprecation = $stderr

  def build_middleware_stack
    nil
  end
end
TestScenario.initialize!

class User < ActiveRecord::Base
  devise :imap_authenticatable
end
Devise.add_mapping(:user, {})
