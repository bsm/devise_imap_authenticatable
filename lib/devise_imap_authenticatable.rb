$: << File.expand_path('../', __FILE__)

require 'devise'
require 'devise_imap_authenticatable/strategy'
require 'devise_imap_authenticatable/model'
require 'devise_imap_authenticatable/adapter'
require 'devise_imap_authenticatable/version'

module Devise

  # IMAP Host address for authentication.
  mattr_accessor :imap_host
  @@imap_host = 'localhost'

  # IMAP Host address for authentication.
  mattr_accessor :imap_port
  @@imap_port = 143

  # Use SSL for IMAP for authentication.
  mattr_accessor :imap_ssl
  @@imap_ssl = false

  mattr_accessor :imap_mechanism
  @@imap_mechanism = "login"
end

# Add imap_authenticatable module
Devise.add_module :imap_authenticatable,
  :strategy   => true,
  :model      => true,
  :route      => :session,
  :controller => :sessions
