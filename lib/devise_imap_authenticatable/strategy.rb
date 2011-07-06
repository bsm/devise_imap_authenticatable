require 'devise/strategies/authenticatable'

module Devise
  module Strategies

    # Strategy for signing in a user based on his login and password using IMAP.
    # Redirects to sign_in page if it's not authenticated
    class ImapAuthenticatable < Authenticatable

      def valid?
        valid_controller? && valid_params? && mapping.to.respond_to?(:authenticate_with_imap)
      end

      def authenticate!
        if resource = mapping.to.authenticate_with_imap(params[scope])
          success!(resource)
        else
          fail(:invalid)
        end
     end

      protected

        def valid_controller?
          params[:controller] == mapping.controllers[:sessions]
        end

        def valid_params?
          params[scope] && params[scope][:password].present?
        end

    end

  end
end
