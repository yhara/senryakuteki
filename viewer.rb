#!/usr/bin/env ruby -Ke
require 'rubygems'
require 'sinatra'
require 'environment.rb'
require 'senryakuteki.rb'

Sinatra::Default.set(:logging => true)

helpers do
  include Rack::Utils
  alias_method :h, :escape_html
end

template :layout do
  <<-EOD
  <html>
  <head><title>超戦略的ブロガー</title></head>
  <body>
  <h1>超戦略的ブロガー</h1>
  <%= yield %>
  </body>
  </html>
  EOD
end

get '*' do
  erb <<-EOD
  <form method='POST'>
  <textarea name='text' cols='80' rows='20'></textarea>
  <input type='submit' value='変換'>
  </form>
  EOD
end

post '*' do
  @text = Senryakuteki.convert(params['text'])
  erb <<-EOD
  <div>
    <%= h @text %>
  </div>

  <a href='.'>別の文章を変換する</a>
  EOD
end
