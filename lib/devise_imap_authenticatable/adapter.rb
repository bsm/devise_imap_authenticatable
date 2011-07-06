require 'net/imap'

module Devise

  # Simple adapter for imap credential checking
  module ImapAdapter

    def self.valid_credentials?(username, password)
      imap = if Net::IMAP::VERSION >= "1.1.0"
        Net::IMAP.new ::Devise.imap_host, :port => ::Devise.imap_port, :ssl => ::Devise.imap_ssl
      else
        Net::IMAP.new ::Devise.imap_host, ::Devise.imap_port, ::Devise.imap_ssl
      end

      imap.authenticate ::Devise.imap_mechanism, username, password
      true
    rescue Net::IMAP::ResponseError
      false
    ensure
      imap.try(:disconnect)
    end

  end
end