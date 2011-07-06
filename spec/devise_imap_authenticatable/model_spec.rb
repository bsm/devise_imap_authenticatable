require 'spec_helper'

describe Devise::Models::ImapAuthenticatable do

  subject do
    User.new :email => 'tom@example.com'
  end

  it 'should downcase the email' do
    subject.email = 'EmaIl@HerE.cOM'
    subject.valid?
    subject.email.should == 'email@here.com'
  end

  it 'should validate a users password' do
    Devise::ImapAdapter.should_receive(:valid_credentials?).with('tom@example.com', 'secret').and_return(true)
    subject.valid_password?('secret').should be_true
  end

  it 'should find for a User for imap authentication' do
    @peter = stub('User')
    User.should_receive(:find_for_authentication).and_return(@peter)
    User.find_for_imap_authentication(:email => 'peter@company.com').should == @peter
  end


end