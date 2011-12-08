require 'spec_helper'

describe Devise::Models::ImapAuthenticatable do

  before do
    User.delete_all
  end

  subject do
    User.create! :email => 'tom@example.com'
  end

  it 'should downcase the email' do
    subject.email = 'EmaIl@HerE.cOM'
    subject.valid?
    subject.email.should == 'email@here.com'
  end

  it 'should strip the white space from email' do
    subject.email = '  email@here.com  '
    subject.valid?
    subject.email.should == 'email@here.com'
  end

  it 'should validate a users password' do
    Devise::ImapAdapter.should_receive(:valid_credentials?).with('tom@example.com', 'secret').and_return(true)
    subject.valid_password?('secret').should be_true
  end

  it 'should find for a User for imap authentication' do
    User.find_for_imap_authentication(:email => subject.email).should == subject
  end


end