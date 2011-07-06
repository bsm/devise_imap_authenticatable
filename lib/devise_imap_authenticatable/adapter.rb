#require 'net/imap'

module Devise

  # Simple adapter for imap credential checking
  module ImapAdapter

    def self.valid_credentials?(username, password)
      #TODO! we need to check the creds here
      false
    end

  end

end