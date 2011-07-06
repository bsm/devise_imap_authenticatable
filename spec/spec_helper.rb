ENV["RAILS_ENV"] ||= 'test'

$: << File.expand_path('../../lib', __FILE__)
require 'rubygems'
require 'bundler'
Bundler.setup
Bundler.require :default, :test

require 'devise_imap_authenticatable'
require 'rspec'
