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
  <head><title>Ķ��άŪ�֥���</title></head>
  <body>
  <h1>Ķ��άŪ�֥���</h1>
  <%= yield %>
  </body>
  </html>
  EOD
end

get '*' do
  erb <<-EOD
  <form method='POST'>
  <textarea name='text' cols='80' rows='20'></textarea>
  <input type='submit' value='�Ѵ�'>
  </form>
  EOD
end

post '*' do
  @text = Senryakuteki.convert(params['text'])
  erb <<-EOD
  <div>
    <%= h @text %>
  </div>

  <a href='.'>�̤�ʸ�Ϥ��Ѵ�����</a>
  EOD
end
