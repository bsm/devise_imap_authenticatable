require 'spec_helper'

describe Devise::Strategies::ImapAuthenticatable do

  let :env do
    Rack::MockRequest.env_for('/')
  end

  subject do
    described_class.new env
  end

  it { should be_a(Devise::Strategies::Authenticatable) }

end
