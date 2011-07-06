$: << File.expand_path('../', __FILE__)

require 'devise'
require 'devise_imap_authenticatable/strategy'
require 'devise_imap_authenticatable/model'
require 'devise_imap_authenticatable/version'
require 'devise_imap_authenticatable/adapter'


module Devise

  # IMAP server address for authentication.
  mattr_accessor :imap_server
  @@imap_server = nil

  mattr_accessor :imap_host
  @@imap_server = 'localhost'

  mattr_accessor :imap_port
  @@imap_port = 143

  mattr_accessor :imap_ssl
  @@imap_ssl = false

  mattr_accessor :imap_mechanism
  @@imap_mechanism = "login"
end

# Add imap_authenticatable module
Devise.add_module :imap_authenticatable,
  :route      => :session,
  :strategy   => true,
  :controller => :sessions,
  :model      => 'devise_imap_authenticatable/model'
