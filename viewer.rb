#!/usr/bin/env ruby -Ke
require 'rubygems'
require 'sinatra'
require 'environment.rb'
require 'senryakuteki.rb'

template :layout do
  <<-EOD
  <html>
  <head><title>Ä¶ÀïÎ¬Åª¥Ö¥í¥¬¡¼</title></head>
  <body>
  <h1>Ä¶ÀïÎ¬Åª¥Ö¥í¥¬¡¼</h1>
  <%= yield %>
  </body>
  </html>
  EOD
end

get '*' do
  erb <<-EOD
  <form method='POST'>
  <textarea name='text' cols='80' rows='20'></textarea>
  <input type='submit' value='ÊÑ´¹'>
  </form>
  EOD
end

post '*' do
  @text = params['text']
  erb <<-EOD
  <%= @text %>
  EOD
end
