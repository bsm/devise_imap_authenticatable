require 'devise/strategies/authenticatable'

module Devise
  module Strategies

    # Strategy for signing in a user based on his login and password using IMAP.
    # Redirects to sign_in page if it's not authenticated
    class ImapAuthenticatable < Authenticatable

      def authenticate!
        resource = valid_password? && (find_resource || build_resource)

        if validate(resource){ resource.valid_password?(password) }
          resource.after_imap_authentication
          success!(resource)
        elsif !halted?
          fail(:invalid)
        end
      end

      private

        def find_resource
          mapping.to.find_for_imap_authentication(authentication_hash)
        end

        def build_resource
          mapping.to.build_for_imap_authentication(authentication_hash)
        end

    end
  end
end
Warden::Strategies.add :imap_authenticatable, Devise::Strategies::ImapAuthenticatable