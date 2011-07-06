require 'spec_helper'

describe Devise::Strategies::ImapAuthenticatable do

  let :env do
    Rack::MockRequest.env_for 'sessions/',
      :method => 'POST',
      :params => { :user => { :email => 'tom@example.com', :password => 'secret'}, :controller => 'devise/sessions' }
  end

  let :new_user do
    User.new
  end

  let :user do
    User.new do |u|
      u.id = 123
      u.email = 'tom@example.com'
      u.instance_eval { def persisted?; true; end }
    end
  end

  subject do
    s = described_class.new(env)
    s.stub!(:scope => :user)
    s.valid?
    s
  end

  it { should be_a(Devise::Strategies::Authenticatable) }

  describe "authentication" do

    it 'should find and authenticate user' do
      User.should_receive(:find_for_imap_authentication).with(:email => "tom@example.com").and_return(user)
      user.should_receive(:valid_password?).with('secret').and_return(true)
      user.should_receive(:after_imap_authentication).with()
      subject.authenticate!.should == :success
    end

    it 'should fail if user not found' do
      User.should_receive(:find_for_imap_authentication).with(:email => "tom@example.com").and_return(nil)
      user.should_not_receive(:after_imap_authentication)
      subject.authenticate!.should == :failure
    end

    it 'should try to build a new user if user not found' do
      User.should_receive(:find_for_imap_authentication).with(:email => "tom@example.com").and_return(nil)
      User.should_receive(:build_for_imap_authentication).with(:email => "tom@example.com").and_return(new_user)
      new_user.should_receive(:valid_password?).with('secret').and_return(true)
      subject.authenticate!.should == :success
    end

    it 'should fail if password is invalid' do
      User.should_receive(:find_for_imap_authentication).with(:email => "tom@example.com").and_return(user)
      user.should_receive(:valid_password?).with('secret').and_return(false)
      subject.authenticate!.should == :failure
    end

  end

end
