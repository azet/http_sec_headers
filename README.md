## Check for HTTP Security Headers

This script currently scans for the following HTTP header fields:
  * `Strict-Transport-Security` (HSTS)
  * `Public-Key-Pins` (HPKP)
  * `X-Frame-Options: deny`
  * `X-Frame-Options: SAMEORIGIN`
  * `X-Content-Type-Options: nosniff`
  * `X-XSS-Protection: 1; mode=block`
  * If `Content-Security-Policy` or `Content-Security-Policy-Report-Only` are set
  * If `Content-Security-Policy: upgrade-insecure-requests` is set
    (force resource requests to upgrade to HTTPS)
  * If `Content-Encoding` is used (BREACH Attack)

In addition it checks if..
  * HTTP requests are being upgraded to HTTPS
  * HTTPS requests are being downgraded to HTTP
  * Invalid (e.g. self-signed, revoked, expired) SSL/TLS certificates are used

Please refer to the 'Resources' section of this document for more
information on the security implications or features of these HTTP headers fields.

**Contributions are always welcome!**

### Usage
#### headers.rb
`ruby headers.rb http://example.com [...]`

By example:
```
$ ruby headers.rb http://twitter.com http://paypal.com http://facebook.com
::: scanning http://twitter.com:
[+] http://twitter.com redirects to HTTPS.
[+] https://twitter.com sets Content-Security-Policy.
[+] https://twitter.com supports HSTS.
[+] https://twitter.com set X-Content-Type-Options to nosniff.
[+] https://twitter.com set X-Frame-Options to SAMEORIGIN.
[+] https://twitter.com provides XSS Protection (X-Xss-Protection: 1; mode=block).
::: scanning http://paypal.com:
[+] http://paypal.com redirects to HTTPS.
[+] https://paypal.com set X-Frame-Options to SAMEORIGIN.
[+] https://paypal.com supports HSTS.
::: scanning http://facebook.com:
[+] http://facebook.com redirects to HTTPS.
[+] https://facebook.com provides 'Clickjacking Protection' (X-Frame-Options: deny).
[+] https://facebook.com set X-Content-Type-Options to nosniff.
```

### Resources
  * [OWASP Wiki on Security Related HTTP Headers](https://www.owasp.org/index.php/List_of_useful_HTTP_headers)
  * [Wikipedia on HTTP Header Fields](https://en.wikipedia.org/wiki/List_of_HTTP_header_fields#Common_non-standard_response_fields)
  * [Wikipedia on HSTS](https://en.wikipedia.org/wiki/HTTP_Strict_Transport_Security)
  * [Wikipedia on BREACH](https://en.wikipedia.org/wiki/BREACH_(security_exploit))
  * [RFC 7469 (Public Key Pinning Extension for
    HTTP)](https://tools.ietf.org/html/rfc7469)
  * [Upgrade Insecure Requests
    (CSP)](http://www.w3.org/TR/upgrade-insecure-requests/)

## License
CC0 1.0 (https://creativecommons.org/publicdomain/zero/1.0)
