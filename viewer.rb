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
  <head>
    <title>Ķ��άŪ�֥���</title>
    <style>
    body{ width:50%; margin:auto; }
    #result{ border: 1px solid black; padding: 1em; margin: 1em; }
    #description{ font-size: small; margin: 1em auto;}
    #footer{ text-align: right; font-size: small; }
    </style>
  </head>
  <body>
  <h1><a href='.'>Ķ��άŪ�֥���</a></h1>
  <%= yield %>
  <div id='description'>
    ���͡�<a href='http://kirik.tea-nifty.com/diary/2009/03/post-abbe.html'>�ڹ���ĹBLOG�ʥ֥��� Lead��off man's Blog: ��άŪ�ϼ�</a>
  </div>
  <div id='footer'>
    powered by <a href='http://route477.net/'>Route477.net</a>
  </div>
  </body>
  </html>
  EOD
end

get '*' do
  erb <<-EOD
  <form method='POST'>
  <textarea name='text' cols='80' rows='20'>
���Υ����ӥ���Ǥ�դ�ʸ�Ϥ���Ū���ĥ��ȥ�ƥ��å����Ѵ����ޤ���
  </textarea>
  <input type='submit' value='�Ѵ�'>
  </form>
  EOD
end

post '*' do
  @text = Senryakuteki.convert(params['text'])
  erb <<-EOD
  <div id='result'>
    <%= h @text %>
  </div>

  <div style='margin-left: 1em;'>
    <a href='.'>�̤�ʸ�Ϥ��Ѵ�����</a>
  </div>

  EOD
end
