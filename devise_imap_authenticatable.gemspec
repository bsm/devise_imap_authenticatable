require File.expand_path('../lib/devise_imap_authenticatable/version', __FILE__)

# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = '>= 1.8.7'
  s.required_rubygems_version = ">= 1.3.6"

  s.name        = "devise_imap_authenticatable"
  s.summary     = "IMAP authentication for Devise"
  s.description = "Authenticate users against an IMAP server"
  s.version     = Devise::ImapAuthenticatable::VERSION

  s.authors     = ["John Medforth", "Dimitrij Denissenko"]
  s.email       = "dimitrij@blacksquaremedia.com"
  s.homepage    = "https://github.com/bsm/devise_imap_authenticatable"

  s.require_path = 'lib'
  s.files        = Dir['LICENSE', 'README', 'lib/**/*']

  s.add_dependency "devise", ">= 1.4.0", "< 2.0.0"
  s.add_dependency "rails", ">= 3.0.0", "< 3.3.0"

  s.add_development_dependency "rspec"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "sqlite3"

end
