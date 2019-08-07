# Secure Web server

As you know your CMDB contains sensitive data no 3rd-party should ever have access to – even from your local network. To harden this virtual appliance you _should_ enforce HTTPS for all clients (Web browser and 3rd-party tools). All non-secure connections will be redirected to a secure connection.

A quick win is your Web server also can switch to the new and significant faster HTTP/2 protocol which requires a secure connection over HTTPS.

**Notice:** After enabling these settings only modern Web browsers and 3rd-party tools are able to connect to i-doit via HTTPS. So please keep your software applications and libraries up-to-date.

## Copy certificates

First step is to copy your X.509-based certificate file (including the complete intermediate certificate chain) and the private key file to `/etc/ssl/`.

**Notice:** We do not provide pre-generated certificates. Please use your own certificate authority (CA) to generate them or try a well-known CA like [Let's Encrypt](https://letsencrypt.org/).

## Change Apache settings

On the command-line edit the file `/etc/apache2/sites-available/i-doit-secure.conf` with `root` rights:

~~~ {.bash}
sudo editor /etc/apache2/sites-available/i-doit-secure.conf
~~~

At the beginning you see some lines beginning with `Define`.

Change `IDOIT_HOST` with the proper hostname/FQDN/IP address you're using for this virtual appliance.

Also replace the values in `IDOIT_CERT_FILE` and `IDOIT_CERT_KEY_FILE` with the paths to your certificates.

An optional extra step to anonymize Apache's access logs. Un-comment the setting `LogFormat` so no IP addresses will be logged anymore.

If you're unsure what each setting mean refer to the [Apache Web server documentation](https://httpd.apache.org/docs/2.4/en/).

## Enable settings

Replace the pre-defined non-secure settings with these settings and restart Apache Web server:

~~~ {.bash}
sudo a2dissite i-doit
sudo a2ensite i-doit-secure
sudo a2enmod headers
sudo a2enmod ssl
sudo a2enmod http2
sudo apachectl configtest
sudo systemctl restart apache2.server
~~~

Make sure no error occurs.

## Does it work?

Now comes the exciting part: Does everything smoothly?

1.  If you open i-doit in your favorite Web browser insecurely with `http://` you should be redirected to `https://` automagically.
2.  Take a deeper look at what information your Web browser provides about the connection to i-doit. There should be no warnings.
3.  For command-line lovers try out these commands:

~~~ {.bash}
curl http://cmdb.example.com/ --head
~~~

This outputs the following headers (not all headers are shown):

~~~
HTTP/1.1 301 Moved Permanently
Content-Security-Policy: default-src 'unsafe-inline' 'unsafe-eval' data: http://cmdb.example.com:80 https://cmdb.example.com:443
X-Frame-Options: SAMEORIGIN
X-XSS-Protection: 1; mode=block
X-Content-Type-Options: nosniff
Strict-Transport-Security: max-age=15768000; includeSubDomains
Location: https://cmdb.example.com/
~~~

Redirection to HTTPS works like a charme. Now try:

~~~ {.bash}
curl https://cmdb.example.com/ --head
~~~

Output:

~~~
HTTP/2 200
content-security-policy: default-src 'unsafe-inline' 'unsafe-eval' data: http://cmdb.example.com:80 https://cmdb.example.com:443
x-frame-options: SAMEORIGIN
x-xss-protection: 1; mode=block
x-content-type-options: nosniff
strict-transport-security: max-age=15768000; includeSubDomains
~~~

Nice. Not only Apache gives you an HTTP status code `200 OK` via a secure connection over HTTPS but also the used protocol is HTTP/2.

In both examples there are some security- and privacy-related HTTP headers we included as best practice.

Last thing is to check the certificate provided by Apache:

~~~ {.bash}
openssl s_client -showcerts -connect cmdb.example.com:443
~~~

This gives you many details about the connection itself and the used certificate (and chain). Make sure `TLSv1.2` is used.
