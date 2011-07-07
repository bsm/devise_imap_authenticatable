require 'net/imap'
require 'timeout'

module Devise

  # Simple adapter for imap credential checking
  module ImapAdapter
    extend self

    def valid_credentials?(username, password)
      imap = new_connection
      Timeout.timeout(::Devise.imap_timeout) do
        imap.login username, password
      end
      true
    rescue Net::IMAP::ResponseError, Timeout::Error
      false
    ensure
      imap.try(:disconnect)
    end

    def new_connection
      if previous_version?
        Net::IMAP.new ::Devise.imap_host, ::Devise.imap_port, ::Devise.imap_ssl
      else
        Net::IMAP.new ::Devise.imap_host, :port => ::Devise.imap_port, :ssl => ::Devise.imap_ssl
      end
    end

    def previous_version?
      Net::IMAP::VERSION < "1.1.0"
    end

  end
end