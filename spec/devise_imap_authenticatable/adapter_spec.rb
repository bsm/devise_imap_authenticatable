require 'spec_helper'

describe Devise::ImapAdapter do
  before do
    @imap_connection = mock('ImapConnection')
    @imap_connection.stub!(:login).and_return(true)
    @imap_connection.stub!(:disconnect).and_return(true)
    Devise::ImapAdapter.stub!(:previous_version?).and_return(false)
  end

  let :response do
    mock "IMAP RESPONSE", :data => mock('DATA', :text => '')
  end

  describe 'valid_credentials?' do
    before do
      Net::IMAP.stub!(:new).and_return(@imap_connection)
    end

    it 'should create a connection to the lap server (older versions)' do
      Net::IMAP.should_receive(:new).with('localhost', :port => 143, :ssl => false)
      described_class.valid_credentials?('email@here.com', 'password')
    end

    it 'should create a connection to the lap server (older versions)' do
      Devise::ImapAdapter.stub!(:previous_version?).and_return(true)
      Net::IMAP.should_receive(:new).with('localhost', 143, false)
      described_class.valid_credentials?('email@here.com', 'password')
    end

    it 'should login the user' do
      @imap_connection.should_receive(:login).with('email@here.com', 'password')
      described_class.valid_credentials?('email@here.com', 'password')
    end

    it 'should disconnect' do
      @imap_connection.should_receive(:disconnect)
      described_class.valid_credentials?('email@here.com', 'password')
    end

    it 'should return true when authentication works' do
      described_class.valid_credentials?('email@here.com', 'password').should be_true
    end

    it 'should catch errors when authentication fails' do
      @imap_connection.stub!(:login).and_raise(Net::IMAP::ResponseError.new(response))
      described_class.valid_credentials?('email@here.com', 'password').should be_false
    end

  end

end