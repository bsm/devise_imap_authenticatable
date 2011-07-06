require 'devise_imap_authenticatable/strategy'

module Devise
  module Models

    module ImapAuthenticatable
      extend ActiveSupport::Concern

      included do
        attr_accessor :password
      end

      # Checks if a resource is valid upon authentication.
      def valid_imap_authentication?(password)
        Devise::ImapAdapter.valid_credentials?(self.email, password)
      end

      module ClassMethods

        # Authenticate a user based on configured attribute keys. Returns the
        # authenticated user if it's valid or nil.
        def authenticate_with_imap(attributes={})
          return nil unless attributes[:email].present?

          # Find the resource by email
          resource = where(:email => attributes[:email]).first

          # Create the resource if no resource is found
          if resource.blank?
            resource = new
            resource[:email] = attributes[:email]
          end

          # Validate the resource
          if resource.try(:valid_imap_authentication?, attributes[:password])
            resource.save if resource.new_record?
            return resource
          else
            return nil
          end

        end

      end
    end
  end
end