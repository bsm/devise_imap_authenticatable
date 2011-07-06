require 'devise_imap_authenticatable/strategy'

module Devise
  module Models

    # IMAP Authenticatable Module
    #
    # == Examples
    #
    #    User.find(1).valid_password?('password123')         # returns true/false
    #
    module ImapAuthenticatable
      extend ActiveSupport::Concern

      included do
        attr_accessor     :password
        before_validation :downcase_keys
        before_validation :strip_whitespace
      end

      # Verifies a given password
      def valid_password?(password)
        Devise::ImapAdapter.valid_credentials? send(::Devise.authentication_keys.first), password
      end

      # Callback, override in your model
      def after_imap_authentication
      end

      protected

        # Downcase case-insensitive keys
        def downcase_keys
          (self.class.case_insensitive_keys || []).each { |k| self[k].try(:downcase!) }
        end

        def strip_whitespace
          (self.class.strip_whitespace_keys || []).each { |k| self[k].try(:strip!) }
        end

      module ClassMethods

        # Override in your models if you want to auto-create users
        def build_for_imap_authentication(conditions)
        end

        # We assume this method already gets a sanitized conditions hash
        def find_for_imap_authentication(conditions)
          find_for_authentication(conditions)
        end

      end

    end
  end
end