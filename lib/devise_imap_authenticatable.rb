require 'devise'

require 'devise_imap_authenticatable/model'
require 'devise_imap_authenticatable/strategy'
require 'devise_imap_authenticatable/version'
require 'devise_imap_authenticatable/imap_adapter'


module Devise
  # imap server address for authentication.
  mattr_accessor :imap_server
  @@imap_server = nil

end

# Add ldap_authenticatable strategy to defaults.
#
Devise.add_module(:imap_authenticatable,
                  :route => :session, ## This will add the routes, rather than in the routes.rb
                  :strategy => true,
                  :controller => :sessions,
                  :model => 'devise_imap_authenticatable/model')