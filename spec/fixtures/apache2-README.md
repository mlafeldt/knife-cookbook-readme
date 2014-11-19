Apache2 Cookbook
================

Installs and configures all aspects of apache2 using Debian style symlinks with helper definitions

Requirements
------------

### Platform:

* Redhat
* Centos
* Scientific
* Fedora
* Debian
* Ubuntu
* Arch
* Freebsd
* Amazon

### Cookbooks:

*No dependencies defined*

Attributes
----------

<table>
  <tr>
    <td>Attribute</td>
    <td>Description</td>
    <td>Default</td>
  </tr>
  <tr>
    <td><code>node['apache']</code></td>
    <td>Hash of Apache attributes</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>node['apache']['dir']</code></td>
    <td>Location for Apache configuration</td>
    <td><code>/etc/apache2</code></td>
  </tr>
  <tr>
    <td><code>node['apache']['log_dir']</code></td>
    <td>Location for Apache logs</td>
    <td><code>/etc/apache2</code></td>
  </tr>
  <tr>
    <td><code>node['apache']['user']</code></td>
    <td>User Apache runs as</td>
    <td><code>www-data</code></td>
  </tr>
  <tr>
    <td><code>node['apache']['binary']</code></td>
    <td>Apache server daemon program</td>
    <td><code>/usr/sbin/apache2</code></td>
  </tr>
  <tr>
    <td><code>node['apache']['icondir']</code></td>
    <td>Directory location for icons</td>
    <td><code>/usr/share/apache2/icons</code></td>
  </tr>
  <tr>
    <td><code>node['apache']['listen_ports']</code></td>
    <td>Ports that Apache should listen on</td>
    <td><code>["80", "443"]</code></td>
  </tr>
  <tr>
    <td><code>node['apache']['contact']</code></td>
    <td>Email address of webmaster</td>
    <td><code>ops@example.com</code></td>
  </tr>
  <tr>
    <td><code>node['apache']['timeout']</code></td>
    <td>Connection timeout value</td>
    <td><code>300</code></td>
  </tr>
  <tr>
    <td><code>node['apache']['keepalive']</code></td>
    <td>HTTP persistent connections</td>
    <td><code>On</code></td>
  </tr>
  <tr>
    <td><code>node['apache']['keepaliverequests']</code></td>
    <td>Number of requests allowed on a persistent connection</td>
    <td><code>100</code></td>
  </tr>
  <tr>
    <td><code>node['apache']['keepalivetimeout']</code></td>
    <td>Time to wait for requests on persistent connection</td>
    <td><code>5</code></td>
  </tr>
  <tr>
    <td><code>node['apache']['servertokens']</code></td>
    <td>Server response header</td>
    <td><code>Prod</code></td>
  </tr>
  <tr>
    <td><code>node['apache']['serversignature']</code></td>
    <td>Configure footer on server-generated documents</td>
    <td><code>On</code></td>
  </tr>
  <tr>
    <td><code>node['apache']['traceenable']</code></td>
    <td>Determine behavior of TRACE requests</td>
    <td><code>On</code></td>
  </tr>
  <tr>
    <td><code>node['apache']['allowed_openids']</code></td>
    <td>Array of OpenIDs allowed to authenticate</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>node['apache']['prefork']</code></td>
    <td>Hash of Apache prefork tuning attributes.</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>node['apache']['prefork']['startservers']</code></td>
    <td>Number of MPM servers to start</td>
    <td><code>16</code></td>
  </tr>
  <tr>
    <td><code>node['apache']['prefork']['minspareservers']</code></td>
    <td>Minimum number of spare server processes</td>
    <td><code>16</code></td>
  </tr>
  <tr>
    <td><code>node['apache']['prefork']['maxspareservers']</code></td>
    <td>Maximum number of spare server processes</td>
    <td><code>32</code></td>
  </tr>
  <tr>
    <td><code>node['apache']['prefork']['serverlimit']</code></td>
    <td>Upper limit on configurable server processes</td>
    <td><code>400</code></td>
  </tr>
  <tr>
    <td><code>node['apache']['prefork']['maxclients']</code></td>
    <td>Maximum number of simultaneous connections</td>
    <td><code>400</code></td>
  </tr>
  <tr>
    <td><code>node['apache']['prefork']['maxrequestsperchild']</code></td>
    <td>Maximum number of request a child process will handle</td>
    <td><code>10000</code></td>
  </tr>
  <tr>
    <td><code>node['apache']['worker']</code></td>
    <td>Hash of Apache prefork tuning attributes.</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>node['apache']['worker']['startservers']</code></td>
    <td>Initial number of server processes to start</td>
    <td><code>4</code></td>
  </tr>
  <tr>
    <td><code>node['apache']['worker']['maxclients']</code></td>
    <td>Maximum number of simultaneous connections</td>
    <td><code>1024</code></td>
  </tr>
  <tr>
    <td><code>node['apache']['worker']['minsparethreads']</code></td>
    <td>Minimum number of spare worker threads</td>
    <td><code>64</code></td>
  </tr>
  <tr>
    <td><code>node['apache']['worker']['maxsparethreads']</code></td>
    <td>Maximum number of spare worker threads</td>
    <td><code>192</code></td>
  </tr>
  <tr>
    <td><code>node['apache']['worker']['threadsperchild']</code></td>
    <td>Constant number of worker threads in each server process</td>
    <td><code>64</code></td>
  </tr>
  <tr>
    <td><code>node['apache']['worker']['maxrequestsperchild']</code></td>
    <td>Maximum number of request a child process will handle</td>
    <td><code>0</code></td>
  </tr>
  <tr>
    <td><code>node['apache']['default_modules']</code></td>
    <td>Default modules to enable via recipes</td>
    <td><code>status alias auth_basic authn_file authz_default authz_groupfile authz_host authz_user autoindex dir env mime negotiation setenvif</code></td>
  </tr>
  <tr>
    <td><code>node['apache']['mod_ssl']['cipher_suite']</code></td>
    <td>String of SSL ciphers to use for SSLCipherSuite</td>
    <td><code>RC4-SHA:HIGH:!ADH</code></td>
  </tr>
</table>

Recipes
-------

### apache2

Main Apache configuration

### apache2::logrotate

Rotate apache2 logs. Requires logrotate cookbook

### apache2::mod_alias

Apache module 'alias' with config file

### apache2::mod_apreq2

Apache module 'apreq'

### apache2::mod_auth_basic

Apache module 'auth_basic'

### apache2::mod_auth_digest

Apache module 'auth_digest'

### apache2::mod_auth_openid

Apache module 'authopenid'

### apache2::mod_authn_file

Apache module 'authn_file'

### apache2::mod_authnz_ldap

Apache module 'authnz_ldap'

### apache2::mod_authz_default

Apache module 'authz_default'

### apache2::mod_authz_groupfile

Apache module 'authz_groupfile'

### apache2::mod_authz_host

Apache module 'authz_host'

### apache2::mod_authz_user

Apache module 'authz_user'

### apache2::mod_autoindex

Apache module 'autoindex' with config file

### apache2::mod_cgi

Apache module 'cgi'

### apache2::mod_dav

Apache module 'dav'

### apache2::mod_dav_svn

Apache module 'dav_svn'

### apache2::mod_deflate

Apache module 'deflate' with config file

### apache2::mod_dir

Apache module 'dir' with config file

### apache2::mod_env

Apache module 'env'

### apache2::mod_expires

Apache module 'expires'

### apache2::mod_fcgid

Apache module 'fcgid', package on ubuntu/debian, rhel/centos, compile source on suse; with config file

### apache2::mod_headers

Apache module 'headers'

### apache2::mod_include

Apache module 'include'

### apache2::mod_ldap

Apache module 'ldap'

### apache2::mod_log_config

Apache module 'log_config'

### apache2::mod_mime

Apache module 'mime' with config file

### apache2::mod_negotiation

Apache module 'negotiation' with config file

### apache2::mod_perl

Apache module 'perl'

### apache2::mod_php5

Apache module 'php5'

### apache2::mod_proxy

Apache module 'proxy' with config file

### apache2::mod_proxy_ajp

Apache module 'proxy_ajp'

### apache2::mod_proxy_balancer

Apache module 'proxy_balancer'

### apache2::mod_proxy_connect

Apache module 'proxy_connect'

### apache2::mod_proxy_http

Apache module 'proxy_http'

### apache2::mod_python

Apache module 'python'

### apache2::mod_rewrite

Apache module 'rewrite'

### apache2::mod_setenvif

Apache module 'setenvif' with config file

### apache2::mod_ssl

Apache module 'ssl' with config file, adds port 443 to listen_ports

### apache2::mod_status

Apache module 'status' with config file

### apache2::mod_xsendfile

Apache module 'xsendfile'


License and Author
------------------

Author: Opscode, Inc. (<cookbooks@opscode.com>)

Copyright: 2013, Opscode, Inc.

License: Apache 2.0
