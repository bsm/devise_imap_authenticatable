require 'spec_helper'

describe Devise::Models::ImapAuthenticatable do

  let :subject do
    User.new
  end

  it 'should downcase the email' do
    subject.email = 'EmaIl@HerE.cOM'
    subject.valid?
    subject.email.should == 'email@here.com'
  end

  it 'should validate a users password' do
    subject.email = 'someemail@domain.com'
    Devise::ImapAdapter.should_receive(:valid_credentials?).with('someemail@domain.com', 'password').and_return(true)
    subject.valid_password?('password').should be_true
  end

  it 'should find for a User for imap authentication' do
    @peter = stub('User')
    User.should_receive(:find_for_authentication).and_return(@peter)
    User.find_for_imap_authentication(:email => 'peter@company.com').should == @peter
  end


end