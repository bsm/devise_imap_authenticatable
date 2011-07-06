require 'devise'
require 'devise_imap_authenticatable/model'
require 'devise_imap_authenticatable/strategy'
require 'devise_imap_authenticatable/version'
require 'devise_imap_authenticatable/adapter'


# Add imap_authenticatable module
Devise.add_module :imap_authenticatable,
  :route      => :session,
  :strategy   => true,
  :controller => :sessions,
  :model      => 'devise_imap_authenticatable/model'