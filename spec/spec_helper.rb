ENV["RAILS_ENV"] ||= 'test'

$: << File.expand_path('../../lib', __FILE__)
require 'rubygems'
require 'bundler'
Bundler.setup
Bundler.require :default, :test

require 'devise/orm/active_record'
require 'active_support/core_ext/string'

SPEC_DATABASE = File.expand_path('../tmp/test.sqlite3', __FILE__)
ActiveRecord::Base.configurations["test"] = { 'adapter' => 'sqlite3', 'database' => SPEC_DATABASE }

RSpec.configure do |c|
  c.before(:all) do
    FileUtils.mkdir_p File.dirname(SPEC_DATABASE)
    base = ActiveRecord::Base
    base.establish_connection(:test)
    base.connection.create_table :users do |t|
      t.string  :email
    end
  end

  c.after(:all) do
    FileUtils.rm_f(SPEC_DATABASE)
  end
end

class User < ActiveRecord::Base
  devise :imap_authenticatable

  cattr_accessor :case_insensitive_keys
  self.case_insensitive_keys = [:email].freeze

  cattr_accessor :strip_whitespace_keys
  self.strip_whitespace_keys = [:email].freeze

end
Devise.add_mapping(:user, {})

