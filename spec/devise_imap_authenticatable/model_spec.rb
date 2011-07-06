require 'spec_helper'

describe Devise::Models::ImapAuthenticatable do

  subject do
    User.new :email => 'tom@example.com'
  end

  it 'should validate a users password' do
    Devise::ImapAdapter.should_receive(:valid_credentials?).with('tom@example.com', 'secret').and_return(true)
    subject.valid_password?('secret').should be_true
  end

end