require 'spec_helper'

describe Devise::Models::ImapAuthenticatable do

  let :subject do
    User.new
  end

  it 'should validate a users password' do
    subject.email = 'someemail@domain.com'
    Devise::ImapAdapter.should_receive(:valid_credentials?).with('someemail@domain.com', 'password').and_return(true)
    subject.valid_password?('password').should be_true
  end

end