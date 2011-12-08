require 'spec_helper'

describe Devise::Strategies::ImapAuthenticatable do

  def env
    Rack::MockRequest.env_for 'sessions/',
      :method => 'POST',
      :params => { :user => { :email => 'tom@example.com', :password => 'secret'}, :controller => 'devise/sessions' },
      "devise.allow_params_authentication" => '1'
  end

  subject do
    described_class.new env, :user
  end

  before do
    User.delete_all
    subject.should be_valid
  end

  it { should be_a(Devise::Strategies::Authenticatable) }

  describe "authentication" do

    it 'should find and authenticate user' do
      User.create! :email => 'tom@example.com'
      Devise::ImapAdapter.should_receive(:valid_credentials?).with('tom@example.com', 'secret').and_return(true)
      subject.authenticate!.should == :success
    end

    it 'should fail if user not found' do
      subject.authenticate!.should == :failure
    end

    it 'should try to build a new user if user not found' do
      User.should_receive(:build_for_imap_authentication).with(:email => "tom@example.com").and_return User.new(:email => "tom@example.com")
      Devise::ImapAdapter.should_receive(:valid_credentials?).with('tom@example.com', 'secret').and_return(false)
      subject.authenticate!.should == :failure
    end

    it 'should fail if password is invalid' do
      User.create! :email => 'tom@example.com'
      Devise::ImapAdapter.should_receive(:valid_credentials?).with('tom@example.com', 'secret').and_return(false)
      subject.authenticate!.should == :failure
    end

  end

end
