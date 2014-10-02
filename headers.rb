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
    x.map!(&:downcase)
    puts "[+] #{page} supports HSTS" if x.first == "strict-transport-security"
    puts "[+] #{page} supports HPKP" if x.first == "public-key-pins"
    puts "[+] #{page} provides 'Clickjacking Protection' (X-Frame-Options: deny)" \
      if x == ['x-frame-options', 'deny']
    puts "[+] #{page} set X-Frame-Options to SAMEORIGIN"                          \
      if x == ['x-frame-options', 'sameorigin']
    puts "[+] #{page} set X-Content-Type-Options to nosniff"                      \
      if x == ['x-content-type-options', 'nosniff']
    puts "[+] #{page} set XSS Protection (X-Xss-Protection: 1; mode=block)"       \
      if x == ['x-xss-protection', '1; mode=block']
    puts "[+] #{page} sets Content-Security-Policy"                               \
      if x.first == "content-security-policy" or                                  \
         x.first == "content-security-policy-report-only"
  end
rescue => e
  puts "[+] #{page} redirects to HTTPS." if e.message =~ /redirection/
  page = page.gsub("http", "https")
  retry
end
