## HTTP Security Headers
Check for HTTP Security Headers.

### Usage
#### headers.rb
```
$ ruby headers.rb http://twitter.com
[+] http://twitter.com redirects to HTTPS.
[+] https://twitter.com sets Content-Security-Policy.
[+] https://twitter.com supports HSTS.
[+] https://twitter.com set X-Content-Type-Options to nosniff.
[+] https://twitter.com set X-Frame-Options to SAMEORIGIN.
[+] https://twitter.com provides XSS Protection (X-Xss-Protection: 1; mode=block).
```

### Resources
  * [OWASP Wiki on Security Related HTTP Headers](https://www.owasp.org/index.php/List_of_useful_HTTP_headers)
  * [Wikipedia on HTTP Header Fields](https://en.wikipedia.org/wiki/List_of_HTTP_header_fields#Common_non-standard_response_fields)
  * [Wikipedia on HSTS](https://en.wikipedia.org/wiki/HTTP_Strict_Transport_Security)
  * [Wikipedia on BREACH](https://en.wikipedia.org/wiki/BREACH_(security_exploit))

## License
CC0 1.0: https://creativecommons.org/publicdomain/zero/1.0/
