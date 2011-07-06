require 'spec_helper'

describe Devise::ImapAdapter do
  before do
    @imap_connection = mock('ImapConnection')
    @imap_connection.stub!(:authenticate).and_return(true)
    @imap_connection.stub!(:disconnect).and_return(true)
  end

  describe 'valid_credentials?' do
    before do
      Net::IMAP.stub!(:new).and_return(@imap_connection)
    end

    it 'should create a connection to the lap server' do
      Net::IMAP.should_receive(:new).with('localhost', 143, false)
      described_class.valid_credentials?('email@here.com', 'password')
    end

    it 'should authenticate the user' do
      @imap_connection.should_receive(:authenticate).with('login', 'email@here.com', 'password')
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
      @imap_connection.stub!(:authenticate).and_raise(Net::IMAP::ResponseError)
      described_class.valid_credentials?('email@here.com', 'password').should be_false
    end

  end

end