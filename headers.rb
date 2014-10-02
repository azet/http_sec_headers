#!/usr/bin/env ruby
#
# check for HTTP security headers
#
require 'open-uri'

if not ARGV.first
  puts "ruby check.rb https://example.com"
  exit 1
end

page = ARGV.first
begin
  open(page).meta.each do |x|
    puts "[+] #{page} supports HSTS." if x.first == "strict-transport-security"
    puts "[+] #{page} supports HPKP." if x.first == "public-key-pins"
  end
rescue => e
  puts "[+] #{page} redirects to HTTPS." if e.message =~ /redirection/
  page = page.gsub("http", "https")
  retry
end
