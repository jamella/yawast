## YAWAST [![Build Status](https://travis-ci.org/adamcaudill/yawast.png?branch=master)](https://travis-ci.org/adamcaudill/yawast) [![Code Climate](https://codeclimate.com/github/adamcaudill/yawast.png)](https://codeclimate.com/github/adamcaudill/yawast) [![Coverage Status](https://coveralls.io/repos/github/adamcaudill/yawast/badge.svg?branch=master)](https://coveralls.io/github/adamcaudill/yawast?branch=master) [![Gem Version](https://badge.fury.io/rb/yawast.svg)](https://badge.fury.io/rb/yawast)

**The YAWAST Antecedent Web Application Security Toolkit**

YAWAST is an application meant to simplify initial analysis and information gathering for penetration testers and security auditors. It performs basic checks in these categories:

* TLS/SSL - Versions and cipher suites supported; common issues.
* Information Disclosure - Checks for common information leaks.
* Presence of Files or Directories - Checks for files or directories that could indicate a security issue.
* Common Vulnerabilities
* Missing Security Headers

This is meant to provide a easy way to perform initial analysis and information discovery. It's not a full testing suite, and it certainly isn't Metasploit. The idea is to provide a quick way to perform initial data collection, which can then be used to better target further tests. It is especially useful when used in conjunction with Burp Suite (via the `--proxy` parameter).

### Installing

The simplest method to install is to use the RubyGem installer:

`gem install yawast`

This allows for simple updates (`gem update yawast`) and makes it easy to ensure that you are always using the latest version.

YAWAST requires Ruby 2.2+, and is tested on Mac OSX and Linux (Windows should work; please open a ticket if you have issues).

**Kali Rolling**

To install on Kali, just run `gem install yawast` - all of the dependentcies are already installed.

**Ubuntu 16.04**

To install YAWAST, you first need to install a couple packages via `apt-get`:

```
sudo apt-get install ruby ruby-dev
sudo gem install yawast
```

**Mac OSX**

The version of Ruby shipped with Mac OSX 10.11 is too old, so the recommended solution is to use RVM:

```
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
\curl -sSL https://get.rvm.io | bash -s stable
source ~/.rvm/scripts/rvm
rvm install 2.2
rvm use 2.2 --default
gem install yawast
```

### Tests

The following tests are performed:

* *(Generic)* Info Disclosure: X-Powered-By header present
* *(Generic)* Info Disclosure: X-Pingback header present
* *(Generic)* Info Disclosure: X-Backend-Server header present
* *(Generic)* Info Disclosure: X-Runtime header present
* *(Generic)* Info Disclosure: Via header present
* *(Generic)* Info Disclosure: PROPFIND Enabled
* *(Generic)* TRACE Enabled
* *(Generic)* X-Frame-Options header not present
* *(Generic)* X-Content-Type-Options header not present
* *(Generic)* Content-Security-Policy header not present
* *(Generic)* Public-Key-Pins header not present
* *(Generic)* X-XSS-Protection disabled header present
* *(Generic)* SSL: HSTS not enabled
* *(Generic)* Source Control: Common source control directories present
* *(Generic)* Presence of crossdomain.xml or clientaccesspolicy.xml
* *(Generic)* Presence of sitemap.xml
* *(Generic)* Presence of WS_FTP.LOG
* *(Generic)* Presence of RELEASE-NOTES.txt
* *(Generic)* Presence of readme.html
* *(Generic)* Missing cookie flags (Secure & HttpOnly)
* *(Generic)* Search for common directories
* *(Apache)* Info Disclosure: Module listing enabled
* *(Apache)* Info Disclosure: Server version
* *(Apache)* Info Disclosure: OpenSSL module version
* *(Apache)* Presence of /server-status
* *(Apache)* Presence of /server-info
* *(IIS)* Info Disclosure: Server version
* *(ASP.NET)* Info Disclosure: ASP.NET version
* *(ASP.NET)* Info Disclosure: ASP.NET MVC version
* *(ASP.NET)* Presence of Trace.axd
* *(ASP.NET)* Presence of Elmah.axd
* *(ASP.NET)* Debugging Enabled
* *(nginx)* Info Disclosure: Server version
* *(PHP)* Info Disclosure: PHP version

CMS Detection:

* Generic (Generator meta tag) *[Real detection coming as soon as I get around to it...]*

SSL Information:

* Certificate details
* Certificate chain
* Supported ciphers
* Maximum requests in a single connection

Checks for the following SSL issues are performed:

* Expired Certificate
* Self-Signed Certificate
* MD5 Signature
* SHA1 Signature
* RC4 Cipher Suites
* Weak (< 128 bit) Cipher Suites
* SWEET32

In addition to these tests, certain basic information is also displayed, such as IPs (and the PTR record for each IP), HTTP HEAD request, and others.

### TLS / SSL Testing

YAWAST offers two modes for testing TLS / SSL - one is custom, and most useful for internal systems, and the other uses the [SSL Labs](https://www.ssllabs.com/) API.

#### Internal Mode

To use the custom internal TLS / SSL scanner (which uses your copy of OpenSSL), simply pass `--internalssl` on the command line. Here is a sample of the output generated by this tester.

```
[I] Found X509 Certificate:
[I] 		Issued To: sni67677.cloudflaressl.com / 
[I] 		Issuer: COMODO ECC Domain Validation Secure Server CA 2 / COMODO CA Limited
[I] 		Version: 2
[I] 		Serial: 14171089194524384184707003668844347326
[I] 		Subject: /OU=Domain Control Validated/OU=PositiveSSL Multi-Domain/CN=sni67677.cloudflaressl.com
[I] 		Expires: 2016-09-11 23:59:59 UTC
[I] 		Signature Algorithm: ecdsa-with-SHA256
[I] 		Key: EC-prime256v1
[I] 			Key Hash: 1a23d84441f9b811dc188bab42b2375873c42ba2
[I] 		Extensions:
[I] 			authorityKeyIdentifier = keyid:40:09:61:67:F0:BC:83:71:4F:DE:12:08:2C:6F:D4:D4:2B:76:3D:96, 
[I] 			subjectKeyIdentifier = D0:F8:D6:82:36:B5:5C:AC:2D:9A:8E:7B:D9:D5:E6:99:38:B6:8C:FE
[I] 			keyUsage = critical, Digital Signature
[I] 			basicConstraints = critical, CA:FALSE
[I] 			extendedKeyUsage = TLS Web Server Authentication, TLS Web Client Authentication
[I] 			certificatePolicies = Policy: 1.3.6.1.4.1.6449.1.2.2.7,   CPS: https://secure.comodo.com/CPS, Policy: 2.23.140.1.2.1, 
[I] 			crlDistributionPoints = , Full Name:,   URI:http://crl.comodoca4.com/COMODOECCDomainValidationSecureServerCA2.crl, 
[I] 			authorityInfoAccess = CA Issuers - URI:http://crt.comodoca4.com/COMODOECCDomainValidationSecureServerCA2.crt, OCSP - URI:http://ocsp.comodoca4.com, 
[I] 		Alternate Names:
[I] 			sni67677.cloudflaressl.com
[I] 			*.adamcaudill.com
[I] 			*.bsidesknoxville.com
[I] 			*.secrypto.com
[I] 			*.smimp.org
[I] 			*.underhandedcrypto.com
[I] 			adamcaudill.com
[I] 			bsidesknoxville.com
[I] 			secrypto.com
[I] 			smimp.org
[I] 			underhandedcrypto.com
[I] 		Hash: 9be2091903a01bcff3ec4049ed1d037a8c611010

[I] Certificate: Chain
[I] 		Issued To: sni67677.cloudflaressl.com / 
[I] 			Issuer: COMODO ECC Domain Validation Secure Server CA 2 / COMODO CA Limited
[I] 			Expires: 2016-09-11 23:59:59 UTC
[I] 			Key: EC-prime256v1
[I] 			Signature Algorithm: ecdsa-with-SHA256
[I] 			Hash: 9be2091903a01bcff3ec4049ed1d037a8c611010

[I] 		Issued To: COMODO ECC Domain Validation Secure Server CA 2 / COMODO CA Limited
[I] 			Issuer: COMODO ECC Certification Authority / COMODO CA Limited
[I] 			Expires: 2029-09-24 23:59:59 UTC
[I] 			Key: EC-prime256v1
[I] 			Signature Algorithm: ecdsa-with-SHA384
[I] 			Hash: 75cfd9bc5cefa104ecc1082d77e63392ccba5291

[I] 		Issued To: COMODO ECC Certification Authority / COMODO CA Limited
[I] 			Issuer: AddTrust External CA Root / AddTrust AB
[I] 			Expires: 2020-05-30 10:48:38 UTC
[I] 			Key: EC-secp384r1
[I] 			Signature Algorithm: sha384WithRSAEncryption
[I] 			Hash: ae223cbf20191b40d7ffb4ea5701b65fdc68a1ca


		Qualys SSL Labs: https://www.ssllabs.com/ssltest/analyze.html?d=adamcaudill.com&hideResults=on

Supported Ciphers (based on your OpenSSL version):
	Checking for TLSv1 suites (98 possible suites)
[I] 		Version: TLSv1  	Bits: 256	Cipher: ECDHE-ECDSA-AES256-SHA
[I] 		Version: TLSv1  	Bits: 128	Cipher: ECDHE-ECDSA-AES128-SHA
[W] 		Version: TLSv1  	Bits: 112	Cipher: ECDHE-ECDSA-DES-CBC3-SHA
	Checking for TLSv1_2 suites (98 possible suites)
[I] 		Version: TLSv1.2	Bits: 256	Cipher: ECDHE-ECDSA-AES256-GCM-SHA384
[I] 		Version: TLSv1.2	Bits: 256	Cipher: ECDHE-ECDSA-AES256-SHA384
[I] 		Version: TLSv1.2	Bits: 256	Cipher: ECDHE-ECDSA-AES256-SHA
[I] 		Version: TLSv1.2	Bits: 128	Cipher: ECDHE-ECDSA-AES128-GCM-SHA256
[I] 		Version: TLSv1.2	Bits: 128	Cipher: ECDHE-ECDSA-AES128-SHA256
[I] 		Version: TLSv1.2	Bits: 128	Cipher: ECDHE-ECDSA-AES128-SHA
[W] 		Version: TLSv1.2	Bits: 112	Cipher: ECDHE-ECDSA-DES-CBC3-SHA
	Checking for TLSv1_1 suites (98 possible suites)
[I] 		Version: TLSv1.1	Bits: 256	Cipher: ECDHE-ECDSA-AES256-SHA
[I] 		Version: TLSv1.1	Bits: 128	Cipher: ECDHE-ECDSA-AES128-SHA
[W] 		Version: TLSv1.1	Bits: 112	Cipher: ECDHE-ECDSA-DES-CBC3-SHA
	Checking for SSLv3 suites (98 possible suites)
```

This version is more limited than the SSL Labs option, though will work in cases where SSL Labs is unable to connect to the target server.

#### SSL Labs Mode

The default mode is to use the SSL Labs API, which makes all users bound by their [terms and conditions](https://www.ssllabs.com/downloads/Qualys_SSL_Labs_Terms_of_Use.pdf), and obviously results in the domain you are scanning being sent to them.

This mode is the most comprehensive, and contains far more data than the Internal Mode. Unless there is a good reason to use the Internal Mode, this is what you should use.

### Usage

* Standard scan: `./yawast scan <url> [--internalssl] [--tdessessioncount] [--nossl] [--nociphers] [--dir] [--proxy localhost:8080] [--cookie SESSIONID=12345]`
* HEAD-only scan: `./yawast head <url> [--internalssl] [--tdessessioncount] [--nossl] [--nociphers] [--proxy localhost:8080] [--cookie SESSIONID=12345]`
* SSL information: `./yawast ssl <url> [--internalssl] [--tdessessioncount] [--nociphers]`
* CMS detection: `./yawast cms <url> [--proxy localhost:8080] [--cookie SESSIONID=12345]`

For detailed information, just call `./yawast -h` to see the help page. To see information for a specific command, call `./yawast -h <command>` for full details.

### Using with Burp Suite

By default, Burp Suite's proxy listens on localhost at port 8080, to use YAWAST with Burp Suite (or any proxy for that matter), just add this to the command line:

`--proxy localhost:8080`

### Authenticated Testing

For authenticated testing, YAWAST allows you to specify a cookie to be passed via the `--cookie` parameter.

`--cookie SESSIONID=1234567890`

### Sample

Using `scan` - the normal go-to option, here's what you get when scanning my website:

```
$yawast scan https://adamcaudill.com --tdessessioncount --dir
__   _____  _    _  ___   _____ _____ 
\ \ / / _ \| |  | |/ _ \ /  ___|_   _|
 \ V / /_\ \ |  | / /_\ \\ `--.  | |  
  \ /|  _  | |/\| |  _  | `--. \ | |  
  | || | | \  /\  / | | |/\__/ / | |  
  \_/\_| |_/\/  \/\_| |_/\____/  \_/  

YAWAST v0.3.0 - The YAWAST Antecedent Web Application Security Toolkit
 Copyright (c) 2013-2016 Adam Caudill <adam@adamcaudill.com>
 Support & Documentation: https://github.com/adamcaudill/yawast
 Ruby 2.2.4-p230; OpenSSL 1.0.2f  28 Jan 2016 (x86_64-darwin15)

Scanning: https://adamcaudill.com/

DNS Information:
[I] 		104.28.27.55 (N/A)
				https://www.shodan.io/host/104.28.27.55
				https://censys.io/ipv4/104.28.27.55
[I] 		104.28.26.55 (N/A)
				https://www.shodan.io/host/104.28.26.55
				https://censys.io/ipv4/104.28.26.55
[I] 		2400:CB00:2048:1::681C:1A37 (N/A)
				https://www.shodan.io/host/2400:cb00:2048:1::681c:1a37
[I] 		2400:CB00:2048:1::681C:1B37 (N/A)
				https://www.shodan.io/host/2400:cb00:2048:1::681c:1b37
[I] 		TXT: v=spf1 mx a ptr include:_spf.google.com ~all
[I] 		MX: aspmx4.googlemail.com (30)
[I] 		MX: aspmx.l.google.com (10)
[I] 		MX: alt1.aspmx.l.google.com (20)
[I] 		MX: aspmx2.googlemail.com (30)
[I] 		MX: alt2.aspmx.l.google.com (20)
[I] 		MX: aspmx3.googlemail.com (30)
[I] 		MX: aspmx5.googlemail.com (30)
[I] 		NS: vera.ns.cloudflare.com
[I] 		NS: hal.ns.cloudflare.com

[I] HEAD:
[I] 		date: Fri, 16 Sep 2016 00:24:15 GMT
[I] 		content-type: text/html; charset=UTF-8
[I] 		connection: close
[I] 		set-cookie: __cfduid=df78c5171c732bf2104fd8cc2dd82afd41473985455; expires=Sat, 16-Sep-17 00:24:15 GMT; path=/; domain=.adamcaudill.com; HttpOnly
[I] 		vary: Accept-Encoding,Cookie
[I] 		cache-control: max-age=3, must-revalidate
[I] 		wp-super-cache: Served supercache file from PHP
[I] 		last-modified: Fri, 16 Sep 2016 00:20:05 GMT
[I] 		x-frame-options: sameorigin
[I] 		strict-transport-security: max-age=15552000; preload
[I] 		x-content-type-options: nosniff
[I] 		server: cloudflare-nginx
[I] 		cf-ray: 2e302ca911c550da-MIA

[I] NOTE: Server appears to be Cloudflare; WAF may be in place.

[I] X-Frame-Options Header: sameorigin
[I] X-Content-Type-Options Header: nosniff
[W] Content-Security-Policy Header Not Present
[W] Public-Key-Pins Header Not Present

[I] Cookies:
[I] 		__cfduid=df78c5171c732bf2104fd8cc2dd82afd41473985455; expires=Sat, 16-Sep-17 00:24:15 GMT; path=/; domain=.adamcaudill.com; HttpOnly
[W] 			Cookie missing Secure flag


Beginning SSL Labs scan (this could take a minute or two)
[SSL Labs]	This assessment service is provided free of charge by Qualys SSL Labs, subject to our terms and conditions: https://www.ssllabs.com/about/terms.html
..........................................

[I] IP: 104.28.27.55 - Grade: A+

	Certificate Information:
[I] 		Subject: CN=sni67677.cloudflaressl.com,OU=PositiveSSL Multi-Domain,OU=Domain Control Validated
[I] 		Common Names: ["sni67677.cloudflaressl.com"]
[I] 		Alternative names:
[I] 			sni67677.cloudflaressl.com
[I] 			*.adamcaudill.com
[I] 			*.bsidesknoxville.com
[I] 			*.secrypto.com
[I] 			*.smimp.org
[I] 			*.underhandedcrypto.com
[I] 			adamcaudill.com
[I] 			bsidesknoxville.com
[I] 			secrypto.com
[I] 			smimp.org
[I] 			underhandedcrypto.com
[I] 		Not Before: 2016-08-13T00:00:00+00:00
[I] 		Not After: 2017-02-12T23:59:59+00:00
[I] 		Key: EC 256 (RSA equivalent: 3072)
[I] 		Public Key Hash: b658ea09e127fafe0416588a17446b606499df6e
[I] 		Version: 2
[I] 		Serial: 18930702358496442989903109042193740748
[I] 		Issuer: COMODO ECC Domain Validation Secure Server CA 2
[I] 		Signature algorithm: SHA256withECDSA
[I] 		Extended Validation: No (Domain Control)
[I] 		Certificate Transparency: No
[I] 		OCSP Must Staple: No
[I] 		Revocation information: CRL information available
[I] 		Revocation information: OCSP information available
[I] 		Revocation status: certificate not revoked
[I] 		Extensions:
[I] 			authorityKeyIdentifier = keyid:40:09:61:67:F0:BC:83:71:4F:DE:12:08:2C:6F:D4:D4:2B:76:3D:96, 
[I] 			subjectKeyIdentifier = D0:F8:D6:82:36:B5:5C:AC:2D:9A:8E:7B:D9:D5:E6:99:38:B6:8C:FE
[I] 			keyUsage = critical, Digital Signature
[I] 			basicConstraints = critical, CA:FALSE
[I] 			extendedKeyUsage = TLS Web Server Authentication, TLS Web Client Authentication
[I] 			certificatePolicies = Policy: 1.3.6.1.4.1.6449.1.2.2.7,   CPS: https://secure.comodo.com/CPS, Policy: 2.23.140.1.2.1, 
[I] 			crlDistributionPoints = , Full Name:,   URI:http://crl.comodoca4.com/COMODOECCDomainValidationSecureServerCA2.crl, 
[I] 			authorityInfoAccess = CA Issuers - URI:http://crt.comodoca4.com/COMODOECCDomainValidationSecureServerCA2.crt, OCSP - URI:http://ocsp.comodoca4.com, 
[I] 		Hash: 1ae6362e4fc377cccb6df6261838a5d9bb49663d
			https://censys.io/certificates?q=1ae6362e4fc377cccb6df6261838a5d9bb49663d
			https://crt.sh/?q=1ae6362e4fc377cccb6df6261838a5d9bb49663d

	Configuration Information:
		Protocol Support:
[I] 			TLS 1.0
[I] 			TLS 1.1
[I] 			TLS 1.2

		Cipher Suite Support:
[I] 			TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256            - 128-bits - ECDHE-256-bits
[I] 			TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA256            - 128-bits - ECDHE-256-bits
[I] 			TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA               - 128-bits - ECDHE-256-bits
[I] 			TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384            - 256-bits - ECDHE-256-bits
[I] 			TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA384            - 256-bits - ECDHE-256-bits
[I] 			TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA               - 256-bits - ECDHE-256-bits
[W] 			TLS_ECDHE_ECDSA_WITH_3DES_EDE_CBC_SHA              - 112-bits - ECDHE-256-bits
[I] 			TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305_SHA256      - 256-bits - ECDHE-256-bits
[I] 			OLD_TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305_SHA256  - 256-bits - ECDHE-256-bits

		Handshake Simulation:
[E] 			Android 2.3.7                - Simulation Failed
[I] 			Android 4.0.4                - TLS 1.0 - TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA
[I] 			Android 4.1.1                - TLS 1.0 - TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA
[I] 			Android 4.2.2                - TLS 1.0 - TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA
[I] 			Android 4.3                  - TLS 1.0 - TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA
[I] 			Android 4.4.2                - TLS 1.2 - TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256
[I] 			Android 5.0.0                - TLS 1.2 - OLD_TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305_SHA256
[I] 			Android 6.0                  - TLS 1.2 - OLD_TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305_SHA256
[I] 			Baidu Jan 2015               - TLS 1.0 - TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA
[I] 			BingPreview Jan 2015         - TLS 1.2 - TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256
[I] 			Chrome 51 / Win 7            - TLS 1.2 - TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256
[I] 			Firefox 31.3.0 ESR / Win 7   - TLS 1.2 - TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256
[I] 			Firefox 46 / Win 7           - TLS 1.2 - TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256
[I] 			Firefox 47 / Win 7           - TLS 1.2 - TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256
[I] 			Googlebot Feb 2015           - TLS 1.2 - TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256
[E] 			IE 6 / XP                    - Simulation Failed
[I] 			IE 7 / Vista                 - TLS 1.0 - TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA
[E] 			IE 8 / XP                    - Simulation Failed
[I] 			IE 8-10 / Win 7              - TLS 1.0 - TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA
[I] 			IE 11 / Win 7                - TLS 1.2 - TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256
[I] 			IE 11 / Win 8.1              - TLS 1.2 - TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256
[I] 			IE 10 / Win Phone 8.0        - TLS 1.0 - TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA
[I] 			IE 11 / Win Phone 8.1        - TLS 1.2 - TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256
[I] 			IE 11 / Win Phone 8.1 Update - TLS 1.2 - TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256
[I] 			IE 11 / Win 10               - TLS 1.2 - TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256
[I] 			Edge 13 / Win 10             - TLS 1.2 - TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256
[I] 			Edge 13 / Win Phone 10       - TLS 1.2 - TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256
[E] 			Java 6u45                    - Simulation Failed
[I] 			Java 7u25                    - TLS 1.0 - TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA
[I] 			Java 8u31                    - TLS 1.2 - TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256
[E] 			OpenSSL 0.9.8y               - Simulation Failed
[I] 			OpenSSL 1.0.1l               - TLS 1.2 - TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256
[I] 			OpenSSL 1.0.2e               - TLS 1.2 - TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256
[I] 			Safari 5.1.9 / OS X 10.6.8   - TLS 1.0 - TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA
[I] 			Safari 6 / iOS 6.0.1         - TLS 1.2 - TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA256
[I] 			Safari 6.0.4 / OS X 10.8.4   - TLS 1.0 - TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA
[I] 			Safari 7 / iOS 7.1           - TLS 1.2 - TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA256
[I] 			Safari 7 / OS X 10.9         - TLS 1.2 - TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA256
[I] 			Safari 8 / iOS 8.4           - TLS 1.2 - TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA256
[I] 			Safari 8 / OS X 10.10        - TLS 1.2 - TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA256
[I] 			Safari 9 / iOS 9             - TLS 1.2 - TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256
[I] 			Safari 9 / OS X 10.11        - TLS 1.2 - TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256
[I] 			Apple ATS 9 / iOS 9          - TLS 1.2 - TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256
[I] 			Yahoo Slurp Jan 2015         - TLS 1.2 - TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256
[I] 			YandexBot Jan 2015           - TLS 1.2 - TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256

		Protocol & Vulnerability Information:
[I] 			DROWN: No
[I] 			Secure Renegotiation: secure renegotiation supported
[I] 			POODLE (SSL): No
[I] 			POODLE (TLS): No
[I] 			Downgrade Prevention: Yes
[I] 			Compression: No
[I] 			Heartbleed: No
[I] 			OpenSSL CCS (CVE-2014-0224): No
[I] 			OpenSSL Padding Oracle (CVE-2016-2107): No
[I] 			Forward Secrecy: Yes (all simulated clients)
[I] 			OCSP Stapling: Yes
[I] 			FREAK: No
[I] 			Logjam: No
[I] 			DH public server param (Ys) reuse: No
[W] 			Protocol Intolerance: TLS 1.3

TLS Session Request Limit: Checking number of requests accepted using 3DES suites...
.....
[I] TLS Session Request Limit: Connection terminated after 100 requests (TLS Reconnected)

[I] HSTS: Enabled (strict-transport-security: max-age=15552000; preload)

[W] '/readme.html' found: https://adamcaudill.com/readme.html

Searching for common directories...
[I] 	Found Redirect: 'https://adamcaudill.com/0/ -> 'https://adamcaudill.com/'
[I] 	Found Redirect: 'https://adamcaudill.com/1/ -> 'https://adamcaudill.com/2013/04/16/1password-pbkdf2-and-implementation-flaws/'
[I] 	Found Redirect: 'https://adamcaudill.com/2/ -> 'https://adamcaudill.com/2015/01/01/2014-a-year-in-review/'
[I] 	Found Redirect: 'https://adamcaudill.com/20/ -> 'https://adamcaudill.com/2015/01/01/2014-a-year-in-review/'
[I] 	Found: 'https://adamcaudill.com/2003/'
[I] 	Found: 'https://adamcaudill.com/2004/'
[I] 	Found: 'https://adamcaudill.com/2005/'
[I] 	Found: 'https://adamcaudill.com/2006/'
[I] 	Found: 'https://adamcaudill.com/2007/'
[I] 	Found: 'https://adamcaudill.com/2008/'
[I] 	Found: 'https://adamcaudill.com/2009/'
[I] 	Found: 'https://adamcaudill.com/2010/'
[I] 	Found: 'https://adamcaudill.com/2011/'
[I] 	Found: 'https://adamcaudill.com/2013/'
[I] 	Found: 'https://adamcaudill.com/2014/'
[I] 	Found: 'https://adamcaudill.com/2015/'
[I] 	Found: 'https://adamcaudill.com/2016/'
[I] 	Found Redirect: 'https://adamcaudill.com/A/ -> 'https://adamcaudill.com/2014/10/17/a-backdoor-by-any-other-name/'
[I] 	Found: 'https://adamcaudill.com/About/'
[I] 	Found Redirect: 'https://adamcaudill.com/Archive/ -> 'https://adamcaudill.com/archives/'
[I] 	Found Redirect: 'https://adamcaudill.com/B/ -> 'https://adamcaudill.com/2005/09/22/back-from-new-york/'
[I] 	Found: 'https://adamcaudill.com/Blog/'
[I] 	Found Redirect: 'https://adamcaudill.com/C/ -> 'https://adamcaudill.com/2009/10/03/cancel-godaddys-domain-privacy/'
[I] 	Found Redirect: 'https://adamcaudill.com/D/ -> 'https://adamcaudill.com/2006/06/02/data-theft-its-happened-again/'
[I] 	Found Redirect: 'https://adamcaudill.com/E/ -> 'https://adamcaudill.com/2006/03/17/end-on-an-era/'
[I] 	Found Redirect: 'https://adamcaudill.com/F/ -> 'https://adamcaudill.com/2011/05/14/facebook-scams/'
[I] 	Found Redirect: 'https://adamcaudill.com/G/ -> 'https://adamcaudill.com/2003/11/26/get-cpu-speed/'
[I] 	Found Redirect: 'https://adamcaudill.com/H/ -> 'https://adamcaudill.com/2011/05/21/happy-20th-birthday-visual-basic/'
[I] 	Found Redirect: 'https://adamcaudill.com/Home/ -> 'https://adamcaudill.com/'
[I] 	Found Redirect: 'https://adamcaudill.com/I/ -> 'https://adamcaudill.com/2007/02/10/i-love-my-job/'
[I] 	Found Redirect: 'https://adamcaudill.com/Internet/ -> 'https://adamcaudill.com/2006/05/27/internet-explorer-7/'
[I] 	Found Redirect: 'https://adamcaudill.com/J/ -> 'https://adamcaudill.com/2014/07/23/jumping-through-hoops-dot-dot-dot/'
[I] 	Found Redirect: 'https://adamcaudill.com/L/ -> 'https://adamcaudill.com/lasers/'
[I] 	Found Redirect: 'https://adamcaudill.com/M/ -> 'https://adamcaudill.com/2006/09/23/make-xp-pretty/'
[I] 	Found Redirect: 'https://adamcaudill.com/N/ -> 'https://adamcaudill.com/2011/02/11/need-a-cheap-phone-charger-quick-buy-a-tracfone/'
[I] 	Found Redirect: 'https://adamcaudill.com/O/ -> 'https://adamcaudill.com/2006/06/17/of-victory-and-pair-programming/'
[I] 	Found Redirect: 'https://adamcaudill.com/P/ -> 'https://adamcaudill.com/2003/10/31/pagesource/'
[I] 	Found Redirect: 'https://adamcaudill.com/PHP/ -> 'https://adamcaudill.com/2005/03/01/phpbb-2-0-13-released-dumbss-coders-strike-again/'
[I] 	Found Redirect: 'https://adamcaudill.com/Pages/ -> 'https://adamcaudill.com/2003/10/31/pagesource/'
[I] 	Found Redirect: 'https://adamcaudill.com/R/ -> 'https://adamcaudill.com/2011/01/28/rails-3-dreamhost-ps/'
[I] 	Found Redirect: 'https://adamcaudill.com/S/ -> 'https://adamcaudill.com/2016/05/22/seamless-phishing/'
[I] 	Found Redirect: 'https://adamcaudill.com/Security/ -> 'https://adamcaudill.com/2014/03/23/security-by-buzzword-why-i-dont-support-ensafer/'
[I] 	Found Redirect: 'https://adamcaudill.com/T/ -> 'https://adamcaudill.com/2007/01/21/task-management-with-tasks/'
[I] 	Found Redirect: 'https://adamcaudill.com/U/ -> 'https://adamcaudill.com/2007/03/22/under-the-weather/'
[I] 	Found Redirect: 'https://adamcaudill.com/US/ -> 'https://adamcaudill.com/2006/07/08/useful-notepad-tip/'
[I] 	Found Redirect: 'https://adamcaudill.com/V/ -> 'https://adamcaudill.com/2006/05/10/valleyschwag/'
[I] 	Found Redirect: 'https://adamcaudill.com/W/ -> 'https://adamcaudill.com/2006/11/28/want-a-free-copy-of-vista/'
[I] 	Found Redirect: 'https://adamcaudill.com/Windows/ -> 'https://adamcaudill.com/2007/03/01/windows-vista-user-experience-guidelines/'
[I] 	Found Redirect: 'https://adamcaudill.com/X/ -> 'https://adamcaudill.com/2007/01/25/xceed-datagrid-for-wpf-released-free/'
[I] 	Found Redirect: 'https://adamcaudill.com/XML/ -> 'https://adamcaudill.com/2006/09/03/xml-notepad-2006/'
[I] 	Found Redirect: 'https://adamcaudill.com/a/ -> 'https://adamcaudill.com/2014/10/17/a-backdoor-by-any-other-name/'
[I] 	Found: 'https://adamcaudill.com/about/'
[I] 	Found Redirect: 'https://adamcaudill.com/ad/ -> 'https://adamcaudill.com/2006/03/29/advanced-net-programming/'
[I] 	Found Redirect: 'https://adamcaudill.com/adv/ -> 'https://adamcaudill.com/2006/03/29/advanced-net-programming/'
[I] 	Found Redirect: 'https://adamcaudill.com/advanced/ -> 'https://adamcaudill.com/2006/03/29/advanced-net-programming/'
[I] 	Found Redirect: 'https://adamcaudill.com/ap/ -> 'https://adamcaudill.com/2003/11/17/apisettings/'
[I] 	Found Redirect: 'https://adamcaudill.com/api/ -> 'https://adamcaudill.com/2003/11/17/apisettings/'
[I] 	Found Redirect: 'https://adamcaudill.com/ar/ -> 'https://adamcaudill.com/archives/'
[I] 	Found Redirect: 'https://adamcaudill.com/archive/ -> 'https://adamcaudill.com/archives/'
[I] 	Found: 'https://adamcaudill.com/archives/'
[I] 	Found Redirect: 'https://adamcaudill.com/asp/ -> 'https://adamcaudill.com/2007/01/25/aspnet-ajax/'
[I] 	Found Redirect: 'https://adamcaudill.com/atom/ -> 'https://adamcaudill.com/feed/atom/'
[I] 	Found Redirect: 'https://adamcaudill.com/avatars/ -> 'https://adamcaudill.com/2009/06/19/avatars-why-roll-your-own/'
[I] 	Found Redirect: 'https://adamcaudill.com/b/ -> 'https://adamcaudill.com/2005/09/22/back-from-new-york/'
[I] 	Found Redirect: 'https://adamcaudill.com/back/ -> 'https://adamcaudill.com/2005/09/22/back-from-new-york/'
[I] 	Found Redirect: 'https://adamcaudill.com/backup/ -> 'https://adamcaudill.com/2007/08/27/backups-with-jungledrive/'
[I] 	Found Redirect: 'https://adamcaudill.com/backups/ -> 'https://adamcaudill.com/2007/08/27/backups-with-jungledrive/'
[I] 	Found Redirect: 'https://adamcaudill.com/bb/ -> 'https://adamcaudill.com/2011/05/21/bbpress-20-beta-1-released/'
[I] 	Found Redirect: 'https://adamcaudill.com/bl/ -> 'https://adamcaudill.com/blog/'
[I] 	Found: 'https://adamcaudill.com/blog/'
[I] 	Found Redirect: 'https://adamcaudill.com/blue/ -> 'https://adamcaudill.com/2006/06/04/blue-hole-waterfall/'
[I] 	Found Redirect: 'https://adamcaudill.com/build/ -> 'https://adamcaudill.com/2007/01/04/building-a-windows-powertoy/'
[I] 	Found Redirect: 'https://adamcaudill.com/buy/ -> 'https://adamcaudill.com/2006/12/19/buying-a-car/'
[I] 	Found Redirect: 'https://adamcaudill.com/c/ -> 'https://adamcaudill.com/2009/10/03/cancel-godaddys-domain-privacy/'
[I] 	Found Redirect: 'https://adamcaudill.com/ca/ -> 'https://adamcaudill.com/2009/10/03/cancel-godaddys-domain-privacy/'
[I] 	Found Redirect: 'https://adamcaudill.com/can/ -> 'https://adamcaudill.com/2009/10/03/cancel-godaddys-domain-privacy/'
[I] 	Found Redirect: 'https://adamcaudill.com/cc/ -> 'https://adamcaudill.com/ccsrch/'
[I] 	Found Redirect: 'https://adamcaudill.com/ccs/ -> 'https://adamcaudill.com/ccsrch/'
[I] 	Found Redirect: 'https://adamcaudill.com/cgi-bin// -> 'https://adamcaudill.com/cgi-bin/'
[I] 	Found Redirect: 'https://adamcaudill.com/ch/ -> 'https://adamcaudill.com/2010/08/06/christopher-adam-caudill-6lbs-7oz-born-822010/'
[I] 	Found Redirect: 'https://adamcaudill.com/com/ -> 'https://adamcaudill.com/2006/03/11/common-sense-email/'
[I] 	Found Redirect: 'https://adamcaudill.com/common/ -> 'https://adamcaudill.com/2006/03/11/common-sense-email/'
[I] 	Found Redirect: 'https://adamcaudill.com/con/ -> 'https://adamcaudill.com/2003/11/11/conexant-formerly-rockwell-softmodem-hsf-modem/'
[I] 	Found Redirect: 'https://adamcaudill.com/contact/ -> '/pgp/'
[I] 	Found Redirect: 'https://adamcaudill.com/crypto/ -> 'https://adamcaudill.com/2016/03/12/crypto-crisis-fear-over-freedom/'
[I] 	Found Redirect: 'https://adamcaudill.com/d/ -> 'https://adamcaudill.com/2006/06/02/data-theft-its-happened-again/'
[I] 	Found Redirect: 'https://adamcaudill.com/dat/ -> 'https://adamcaudill.com/2006/06/02/data-theft-its-happened-again/'
[I] 	Found Redirect: 'https://adamcaudill.com/data/ -> 'https://adamcaudill.com/2006/06/02/data-theft-its-happened-again/'
[I] 	Found Redirect: 'https://adamcaudill.com/de/ -> 'https://adamcaudill.com/2012/07/27/decrypting-spark-saved-passwords/'
[I] 	Found Redirect: 'https://adamcaudill.com/dec/ -> 'https://adamcaudill.com/2012/07/27/decrypting-spark-saved-passwords/'
[I] 	Found Redirect: 'https://adamcaudill.com/detail/ -> 'https://adamcaudill.com/2006/09/03/detailed-css-changes-in-ie7/'
[I] 	Found Redirect: 'https://adamcaudill.com/dev/ -> 'https://adamcaudill.com/2016/08/17/developers-placing-trust-in-strangers/'
[I] 	Found Redirect: 'https://adamcaudill.com/devel/ -> 'https://adamcaudill.com/2016/08/17/developers-placing-trust-in-strangers/'
[I] 	Found Redirect: 'https://adamcaudill.com/develop/ -> 'https://adamcaudill.com/2016/08/17/developers-placing-trust-in-strangers/'
[I] 	Found Redirect: 'https://adamcaudill.com/developer/ -> 'https://adamcaudill.com/2016/08/17/developers-placing-trust-in-strangers/'
[I] 	Found Redirect: 'https://adamcaudill.com/developers/ -> 'https://adamcaudill.com/2016/08/17/developers-placing-trust-in-strangers/'
[I] 	Found Redirect: 'https://adamcaudill.com/development/ -> 'https://adamcaudill.com/2006/04/11/development-abstraction/'
[I] 	Found Redirect: 'https://adamcaudill.com/do/ -> 'https://adamcaudill.com/2013/07/04/do-one-thing-right/'
[I] 	Found Redirect: 'https://adamcaudill.com/e/ -> 'https://adamcaudill.com/2006/03/17/end-on-an-era/'
[I] 	Found Redirect: 'https://adamcaudill.com/en/ -> 'https://adamcaudill.com/2006/03/17/end-on-an-era/'
[I] 	Found Redirect: 'https://adamcaudill.com/error/ -> 'https://adamcaudill.com/2011/05/16/errors-on-gem-install-mysql2/'
[I] 	Found Redirect: 'https://adamcaudill.com/errors/ -> 'https://adamcaudill.com/2011/05/16/errors-on-gem-install-mysql2/'
[I] 	Found Redirect: 'https://adamcaudill.com/event/ -> 'https://adamcaudill.com/2006/09/24/eventargs-no-need-to-pass-a-new-instance/'
[I] 	Found Redirect: 'https://adamcaudill.com/f/ -> 'https://adamcaudill.com/2011/05/14/facebook-scams/'
[I] 	Found: 'https://adamcaudill.com/feed/'
[I] 	Found: 'https://adamcaudill.com/files/'
[I] 	Found Redirect: 'https://adamcaudill.com/firefox/ -> 'https://adamcaudill.com/2006/09/17/firefox-toys-errorzilla/'
[I] 	Found Redirect: 'https://adamcaudill.com/first/ -> 'https://adamcaudill.com/2013/03/26/first-do-no-harm-developers-and-bad-apis/'
[I] 	Found Redirect: 'https://adamcaudill.com/fr/ -> 'https://adamcaudill.com/2007/02/06/from-outlook-to-gmail-to-the-bat/'
[I] 	Found Redirect: 'https://adamcaudill.com/g/ -> 'https://adamcaudill.com/2003/11/26/get-cpu-speed/'
[I] 	Found Redirect: 'https://adamcaudill.com/get/ -> 'https://adamcaudill.com/2003/11/26/get-cpu-speed/'
[I] 	Found Redirect: 'https://adamcaudill.com/go/ -> 'https://adamcaudill.com/2011/01/12/google-chrome-and-h-264/'
[I] 	Found Redirect: 'https://adamcaudill.com/google/ -> 'https://adamcaudill.com/2011/01/12/google-chrome-and-h-264/'
[I] 	Found Redirect: 'https://adamcaudill.com/gp/ -> 'https://adamcaudill.com/2012/05/13/gpg4win-idea/'
[I] 	Found Redirect: 'https://adamcaudill.com/h/ -> 'https://adamcaudill.com/2011/05/21/happy-20th-birthday-visual-basic/'
[I] 	Found Redirect: 'https://adamcaudill.com/holiday/ -> 'https://adamcaudill.com/2006/12/23/holiday-schwag/'
[I] 	Found Redirect: 'https://adamcaudill.com/home/ -> 'https://adamcaudill.com/'
[I] 	Found Redirect: 'https://adamcaudill.com/host/ -> 'https://adamcaudill.com/2011/04/11/hosting-change/'
[I] 	Found Redirect: 'https://adamcaudill.com/hosting/ -> 'https://adamcaudill.com/2011/04/11/hosting-change/'
[I] 	Found Redirect: 'https://adamcaudill.com/how/ -> 'https://adamcaudill.com/2006/02/26/how-it-projects-really-work/'
[I] 	Found Redirect: 'https://adamcaudill.com/hp/ -> 'https://adamcaudill.com/2012/04/23/hp-folio-13/'
[I] 	Found Redirect: 'https://adamcaudill.com/i/ -> 'https://adamcaudill.com/2007/02/10/i-love-my-job/'
[I] 	Found Redirect: 'https://adamcaudill.com/ie/ -> 'https://adamcaudill.com/2007/01/10/ie-developer-toolbar/'
[I] 	Found Redirect: 'https://adamcaudill.com/in/ -> 'https://adamcaudill.com/2006/07/07/in-comes-the-schwag/'
[I] 	Found Redirect: 'https://adamcaudill.com/install/ -> 'https://adamcaudill.com/2006/11/18/installing-vista/'
[I] 	Found Redirect: 'https://adamcaudill.com/internet/ -> 'https://adamcaudill.com/2006/05/27/internet-explorer-7/'
[I] 	Found Redirect: 'https://adamcaudill.com/it/ -> 'https://adamcaudill.com/2006/02/26/its-official-ie7-is-cool/'
[I] 	Found Redirect: 'https://adamcaudill.com/j/ -> 'https://adamcaudill.com/2014/07/23/jumping-through-hoops-dot-dot-dot/'
[I] 	Found Redirect: 'https://adamcaudill.com/jump/ -> 'https://adamcaudill.com/2014/07/23/jumping-through-hoops-dot-dot-dot/'
[I] 	Found Redirect: 'https://adamcaudill.com/k/ -> 'https://adamcaudill.com/2006/09/16/kill-capslock/'
[I] 	Found Redirect: 'https://adamcaudill.com/l/ -> 'https://adamcaudill.com/lasers/'
[I] 	Found Redirect: 'https://adamcaudill.com/link/ -> 'https://adamcaudill.com/2012/06/06/linkedin-a-little-common-sense/'
[I] 	Found Redirect: 'https://adamcaudill.com/m/ -> 'https://adamcaudill.com/2006/09/23/make-xp-pretty/'
[I] 	Found Redirect: 'https://adamcaudill.com/microsoft/ -> 'https://adamcaudill.com/2007/01/21/microsoft-mice-another-reason-to-love-them/'
[I] 	Found Redirect: 'https://adamcaudill.com/mini/ -> 'https://adamcaudill.com/2012/05/13/minipwner/'
[I] 	Found Redirect: 'https://adamcaudill.com/monitor/ -> 'https://adamcaudill.com/2012/06/10/monitor-iphone-http-s-traffic-with-fiddler/'
[I] 	Found Redirect: 'https://adamcaudill.com/my/ -> 'https://adamcaudill.com/2012/03/31/my-5-minutes-of-infamy/'
[I] 	Found Redirect: 'https://adamcaudill.com/n/ -> 'https://adamcaudill.com/2011/02/11/need-a-cheap-phone-charger-quick-buy-a-tracfone/'
[I] 	Found Redirect: 'https://adamcaudill.com/ne/ -> 'https://adamcaudill.com/2011/02/11/need-a-cheap-phone-charger-quick-buy-a-tracfone/'
[I] 	Found Redirect: 'https://adamcaudill.com/net/ -> 'https://adamcaudill.com/2006/11/08/net-framework-30-released/'
[I] 	Found Redirect: 'https://adamcaudill.com/new/ -> 'https://adamcaudill.com/2016/01/01/new-atheism-the-philosophy-of-atheism/'
[I] 	Found Redirect: 'https://adamcaudill.com/no/ -> 'https://adamcaudill.com/2006/10/05/not-not-a-good-idea/'
[I] 	Found Redirect: 'https://adamcaudill.com/o/ -> 'https://adamcaudill.com/2006/06/17/of-victory-and-pair-programming/'
[I] 	Found Redirect: 'https://adamcaudill.com/of/ -> 'https://adamcaudill.com/2006/06/17/of-victory-and-pair-programming/'
[I] 	Found Redirect: 'https://adamcaudill.com/on/ -> 'https://adamcaudill.com/2010/06/19/on-hiring/'
[I] 	Found Redirect: 'https://adamcaudill.com/open/ -> 'https://adamcaudill.com/2007/02/02/opendns/'
[I] 	Found Redirect: 'https://adamcaudill.com/p/ -> 'https://adamcaudill.com/2003/10/31/pagesource/'
[I] 	Found Redirect: 'https://adamcaudill.com/page/ -> 'https://adamcaudill.com/2003/10/31/pagesource/'
[I] 	Found Redirect: 'https://adamcaudill.com/page2/ -> 'https://adamcaudill.com/page/2/'
[I] 	Found Redirect: 'https://adamcaudill.com/pages/ -> 'https://adamcaudill.com/2003/10/31/pagesource/'
[I] 	Found Redirect: 'https://adamcaudill.com/pass/ -> 'https://adamcaudill.com/2013/05/07/password-hashing-no-silver-bullets/'
[I] 	Found Redirect: 'https://adamcaudill.com/passw/ -> 'https://adamcaudill.com/2013/05/07/password-hashing-no-silver-bullets/'
[I] 	Found Redirect: 'https://adamcaudill.com/passwor/ -> 'https://adamcaudill.com/2013/05/07/password-hashing-no-silver-bullets/'
[I] 	Found Redirect: 'https://adamcaudill.com/password/ -> 'https://adamcaudill.com/2013/05/07/password-hashing-no-silver-bullets/'
[I] 	Found: 'https://adamcaudill.com/pgp/'
[I] 	Found: 'https://adamcaudill.com/photo/'
[I] 	Found Redirect: 'https://adamcaudill.com/php/ -> 'https://adamcaudill.com/2005/03/01/phpbb-2-0-13-released-dumbss-coders-strike-again/'
[I] 	Found Redirect: 'https://adamcaudill.com/pl/ -> 'https://adamcaudill.com/2016/05/01/plsql-developer-http-to-command-execution/'
[I] 	Found Redirect: 'https://adamcaudill.com/pls/ -> 'https://adamcaudill.com/2016/05/01/plsql-developer-http-to-command-execution/'
[I] 	Found Redirect: 'https://adamcaudill.com/power/ -> 'https://adamcaudill.com/2006/11/15/power-users-rejoice/'
[I] 	Found Redirect: 'https://adamcaudill.com/pr/ -> 'https://adamcaudill.com/2008/12/21/programmers-are-expensive/'
[I] 	Found Redirect: 'https://adamcaudill.com/pro/ -> 'https://adamcaudill.com/2008/12/21/programmers-are-expensive/'
[I] 	Found Redirect: 'https://adamcaudill.com/prog/ -> 'https://adamcaudill.com/2008/12/21/programmers-are-expensive/'
[I] 	Found Redirect: 'https://adamcaudill.com/program/ -> 'https://adamcaudill.com/2008/12/21/programmers-are-expensive/'
[I] 	Found Redirect: 'https://adamcaudill.com/q/ -> 'https://adamcaudill.com/2012/04/05/quickpacket-hosting/'
[I] 	Found Redirect: 'https://adamcaudill.com/r/ -> 'https://adamcaudill.com/2011/01/28/rails-3-dreamhost-ps/'
[I] 	Found Redirect: 'https://adamcaudill.com/random/ -> 'https://adamcaudill.com/2005/02/28/random-user-agent-in-vb-net/'
[I] 	Found Redirect: 'https://adamcaudill.com/read/ -> 'https://adamcaudill.com/reading/'
[I] 	Found Redirect: 'https://adamcaudill.com/reg/ -> 'https://adamcaudill.com/2003/10/26/register-activex-typelibs/'
[I] 	Found Redirect: 'https://adamcaudill.com/register/ -> 'https://adamcaudill.com/2003/10/26/register-activex-typelibs/'
[I] 	Found Redirect: 'https://adamcaudill.com/religion/ -> 'https://adamcaudill.com/2015/01/12/religion-free-speech-freedom-from-offense/'
[I] 	Found: 'https://adamcaudill.com/resume/'
[I] 	Found Redirect: 'https://adamcaudill.com/rss/ -> 'https://adamcaudill.com/feed/'
[I] 	Found Redirect: 'https://adamcaudill.com/rss2/ -> 'https://adamcaudill.com/feed/'
[I] 	Found Redirect: 'https://adamcaudill.com/ru/ -> 'https://adamcaudill.com/2006/09/17/running-regedit-as-system/'
[I] 	Found Redirect: 'https://adamcaudill.com/run/ -> 'https://adamcaudill.com/2006/09/17/running-regedit-as-system/'
[I] 	Found Redirect: 'https://adamcaudill.com/s/ -> 'https://adamcaudill.com/2016/05/22/seamless-phishing/'
[I] 	Found Redirect: 'https://adamcaudill.com/se/ -> 'https://adamcaudill.com/2016/05/22/seamless-phishing/'
[I] 	Found Redirect: 'https://adamcaudill.com/secure/ -> 'https://adamcaudill.com/2010/02/01/secure-password-storage/'
[I] 	Found Redirect: 'https://adamcaudill.com/security/ -> 'https://adamcaudill.com/2014/03/23/security-by-buzzword-why-i-dont-support-ensafer/'
[I] 	Found Redirect: 'https://adamcaudill.com/server/ -> 'https://adamcaudill.com/2006/03/25/server-move/'
[I] 	Found Redirect: 'https://adamcaudill.com/set/ -> 'https://adamcaudill.com/2003/10/31/setfocusbycaption/'
[I] 	Found Redirect: 'https://adamcaudill.com/simple/ -> 'https://adamcaudill.com/2003/11/26/simple-ini-api/'
[I] 	Found Redirect: 'https://adamcaudill.com/site/ -> 'https://adamcaudill.com/2006/10/30/site-updates/'
[I] 	Found Redirect: 'https://adamcaudill.com/sp/ -> 'https://adamcaudill.com/2006/12/19/spam-gmail/'
[I] 	Found Redirect: 'https://adamcaudill.com/spam/ -> 'https://adamcaudill.com/2006/12/19/spam-gmail/'
[I] 	Found Redirect: 'https://adamcaudill.com/st/ -> 'https://adamcaudill.com/2009/07/18/start-up-tools-microsoft-bizspark/'
[I] 	Found Redirect: 'https://adamcaudill.com/star/ -> 'https://adamcaudill.com/2009/07/18/start-up-tools-microsoft-bizspark/'
[I] 	Found Redirect: 'https://adamcaudill.com/start/ -> 'https://adamcaudill.com/2009/07/18/start-up-tools-microsoft-bizspark/'
[I] 	Found Redirect: 'https://adamcaudill.com/stat/ -> 'https://adamcaudill.com/2010/07/30/state-of-the-virus-art/'
[I] 	Found Redirect: 'https://adamcaudill.com/state/ -> 'https://adamcaudill.com/2010/07/30/state-of-the-virus-art/'
[I] 	Found Redirect: 'https://adamcaudill.com/super/ -> 'https://adamcaudill.com/2006/04/07/superstars-monkeys/'
[I] 	Found Redirect: 'https://adamcaudill.com/sw/ -> 'https://adamcaudill.com/2009/06/13/switching-hosts-again/'
[I] 	Found Redirect: 'https://adamcaudill.com/t/ -> 'https://adamcaudill.com/2007/01/21/task-management-with-tasks/'
[I] 	Found Redirect: 'https://adamcaudill.com/task/ -> 'https://adamcaudill.com/2007/01/21/task-management-with-tasks/'
[I] 	Found Redirect: 'https://adamcaudill.com/technology/ -> '/'
[I] 	Found Redirect: 'https://adamcaudill.com/tool/ -> 'https://adamcaudill.com/tools/'
[I] 	Found: 'https://adamcaudill.com/tools/'
[I] 	Found Redirect: 'https://adamcaudill.com/u/ -> 'https://adamcaudill.com/2007/03/22/under-the-weather/'
[I] 	Found Redirect: 'https://adamcaudill.com/up/ -> 'https://adamcaudill.com/2012/10/07/upek-windows-password-decryption/'
[I] 	Found Redirect: 'https://adamcaudill.com/us/ -> 'https://adamcaudill.com/2006/07/08/useful-notepad-tip/'
[I] 	Found Redirect: 'https://adamcaudill.com/v/ -> 'https://adamcaudill.com/2006/05/10/valleyschwag/'
[I] 	Found Redirect: 'https://adamcaudill.com/var/ -> 'https://adamcaudill.com/2005/09/26/varticles/'
[I] 	Found Redirect: 'https://adamcaudill.com/vb/ -> 'https://adamcaudill.com/2006/04/02/vb-the-dumbing-of-a-great-language/'
[I] 	Found Redirect: 'https://adamcaudill.com/vi/ -> 'https://adamcaudill.com/2013/10/23/vicidial-multiple-vulnerabilities/'
[I] 	Found Redirect: 'https://adamcaudill.com/vista/ -> 'https://adamcaudill.com/2006/11/16/vista-available-via-msdn/'
[I] 	Found Redirect: 'https://adamcaudill.com/w/ -> 'https://adamcaudill.com/2006/11/28/want-a-free-copy-of-vista/'
[I] 	Found Redirect: 'https://adamcaudill.com/web/ -> 'https://adamcaudill.com/2006/05/17/web-developer-toolbar-menu-for-opera/'
[I] 	Found Redirect: 'https://adamcaudill.com/what/ -> 'https://adamcaudill.com/2006/04/24/what-a-surprise/'
[I] 	Found Redirect: 'https://adamcaudill.com/why/ -> 'https://adamcaudill.com/2011/10/15/why-cringely-is-wrong-about-java/'
[I] 	Found Redirect: 'https://adamcaudill.com/wiki/ -> 'https://adamcaudill.com/2010/12/01/wikileaks-biggest-problem-julian-assange/'
[I] 	Found Redirect: 'https://adamcaudill.com/win/ -> 'https://adamcaudill.com/2007/03/01/windows-vista-user-experience-guidelines/'
[I] 	Found Redirect: 'https://adamcaudill.com/windows/ -> 'https://adamcaudill.com/2007/03/01/windows-vista-user-experience-guidelines/'
[I] 	Found Redirect: 'https://adamcaudill.com/wink/ -> 'https://adamcaudill.com/2006/04/15/wink-20/'
[I] 	Found Redirect: 'https://adamcaudill.com/word/ -> 'https://adamcaudill.com/2006/07/30/wordpress-204/'
[I] 	Found Redirect: 'https://adamcaudill.com/wordpress/ -> 'https://adamcaudill.com/2006/07/30/wordpress-204/'
[I] 	Found Redirect: 'https://adamcaudill.com/work/ -> 'https://adamcaudill.com/2008/12/08/working-late-again/'
[I] 	Found: 'https://adamcaudill.com/wp-content/'
[I] 	Found: 'https://adamcaudill.com/wp-includes/'
[I] 	Found Redirect: 'https://adamcaudill.com/x/ -> 'https://adamcaudill.com/2007/01/25/xceed-datagrid-for-wpf-released-free/'
[I] 	Found Redirect: 'https://adamcaudill.com/xml/ -> 'https://adamcaudill.com/2006/09/03/xml-notepad-2006/'
[I] 	Found Redirect: 'https://adamcaudill.com/y/ -> 'https://adamcaudill.com/2012/07/12/yahoos-associated-content-hacked/'
[I] 	Found Redirect: 'https://adamcaudill.com/yahoo/ -> 'https://adamcaudill.com/2012/07/12/yahoos-associated-content-hacked/'
[I] 	Found Redirect: 'https://adamcaudill.com/z/ -> 'https://adamcaudill.com/2004/12/18/zipsight-2004-1-released/'
[I] 	Found Redirect: 'https://adamcaudill.com/zip/ -> 'https://adamcaudill.com/2004/12/18/zipsight-2004-1-released/'
[I] 	Found Redirect: 'https://adamcaudill.com/zips/ -> 'https://adamcaudill.com/2004/12/18/zipsight-2004-1-released/'

[I] Meta Generator: WordPress 4.6.1
Scan complete.
```

### About The Output

You'll notice that most lines begin with a letter in a bracket, this is to tell you how to interpret the result at a glance. There are four possible values:

* [I] - This indicates that the line is informational, and doesn't necessarily indicate a security issue.
* [W] - This is a Warning, which means that it could be an issue, or could expose useful information. These need to be evaluated on a case-by-case basis to determine the impact.
* [V] - This is a Vulnerability, it indicates an issue that is known to be an issue, and needs to be addressed.
* [E] - This indicates that an error occurred, sometimes these are serious and indicate an issue with your environment, the target server, or the application. In other cases, they may just be informational to let you know that something didn't go as planned.

The indicator used may change over time based on new research or better detection techniques. In all cases, results should be carefully evaluated within the context of the application, how it's used, and what threats apply. The indicator is guidance, a hint if you will, it's up to you to determine the real impact.

### About The Name

When this project was started, the original name was "Yet Another Web Application Security Tool" - as the project became more serious, the name was changed. The current name better reflects the role of the tool, and its place in the penetration tester's workflow. It's meant to be a first step, to come before the serious manual work, and provide information to allow a tester to be up and running quicker. The tests that are performed are based on that goal, as well as the availability and complexity of tests in other tools. If another common tool can do a given task better, it won't be done here.

### Special Thanks

[dirbuster-ng](https://github.com/digination/dirbuster-ng) For the use of their `common.txt` directoty list. This list was the foundation of the list used by YAWAST.
[Shopify](https://www.shopify.com/) for [ssllabs.rb](https://github.com/Shopify/ssllabs.rb), which provides the Qualsys SSL Labs integration.

### License

Copyright (c) 2013 - 2016, Adam Caudill (adam@adamcaudill.com)

All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
