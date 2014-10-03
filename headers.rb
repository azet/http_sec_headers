#!/usr/bin/env ruby -W0
#
# check for HTTP security headers
#
require 'open-uri'

def scan_headers field, page
  field.map!(&:downcase)
  case
  when field.first == "strict-transport-security"
    puts "[+] #{page} supports HSTS."
  when field.first == "public-key-pins"
    puts "[+] #{page} supports HPKP."
  when field == ['x-frame-options', 'deny']
    puts "[+] #{page} provides 'Clickjacking Protection' (X-Frame-Options: deny)."
  when field == ['x-frame-options', 'sameorigin']
    puts "[+] #{page} set X-Frame-Options to SAMEORIGIN."
  when field == ['x-content-type-options', 'nosniff']
    puts "[+] #{page} set X-Content-Type-Options to nosniff."
  when field == ['x-xss-protection', '1; mode=block']
    puts "[+] #{page} provides XSS Protection (X-Xss-Protection: 1; mode=block)."
  when field.first == "content-security-policy"
  when field.first == "content-security-policy-report-only"
    puts "[+] #{page} sets Content-Security-Policy."
  when field.first == "content-encoding"
    puts "[-] #{page} uses HTTP compression (BREACH)!"
  end
end

if not ARGV.first
  puts "Usage: ruby headers.rb http://example.com"
  exit 1
end
page = ARGV.first

begin
  open(page).meta.each do |field|
    scan_headers field, page
  end
rescue => e
  case
  when e.message =~ /verify failed/
    puts "[-] #{page} has no valid TLS certificate!"
    # when overriding this constant, ruby will - correctly - issue a warning
    # we supress the warning with the parameter -W0, since we still want to
    # run the remaining checks that the script offers without being bothered
    OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
    retry
  when e.message =~ /redirection\s+forbidden:\s+http:\S+\s+->\s+https:/i
    puts "[+] #{page} redirects to HTTPS."
    page = page.gsub("http", "https")
    retry
  else
    puts "[-] #{page} downgrades HTTPS to HTTP!"
    page = page.gsub("https", "http")
    retry
  end
end

