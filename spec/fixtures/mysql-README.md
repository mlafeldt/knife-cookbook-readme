Mysql Cookbook
==============

Installs and configures mysql for client or server

Requirements
------------

### Platform:

* Debian
* Ubuntu
* Centos
* Suse
* Fedora
* Redhat
* Scientific
* Amazon
* Freebsd
* Windows
* Mac_os_x

### Cookbooks:

* openssl
* build-essential (> 1.1.0)

Attributes
----------

<table>
  <tr>
    <td>Attribute</td>
    <td>Description</td>
    <td>Default</td>
  </tr>
  <tr>
    <td><code>node['mysql']['server_root_password']</code></td>
    <td>Randomly generated password for the mysqld root user</td>
    <td><code>randomly generated</code></td>
  </tr>
  <tr>
    <td><code>node['mysql']['bind_address']</code></td>
    <td>Address that mysqld should listen on</td>
    <td><code>ipaddress</code></td>
  </tr>
  <tr>
    <td><code>node['mysql']['data_dir']</code></td>
    <td>Location of mysql databases</td>
    <td><code>/var/lib/mysql</code></td>
  </tr>
  <tr>
    <td><code>node['mysql']['conf_dir']</code></td>
    <td>Location of mysql conf files</td>
    <td><code>/etc/mysql</code></td>
  </tr>
  <tr>
    <td><code>node['mysql']['ec2_path']</code></td>
    <td>Location of mysql directory on EC2 instance EBS volumes</td>
    <td><code>/mnt/mysql</code></td>
  </tr>
  <tr>
    <td><code>node['mysql']['reload_action']</code></td>
    <td>Action to take when mysql conf files are modified</td>
    <td><code>reload</code></td>
  </tr>
  <tr>
    <td><code>node['mysql']['tunable']</code></td>
    <td>Hash of MySQL tunable attributes</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>node['mysql']['tunable']['key_buffer']</code></td>
    <td></td>
    <td><code>250M</code></td>
  </tr>
  <tr>
    <td><code>node['mysql']['tunable']['max_connections']</code></td>
    <td></td>
    <td><code>800</code></td>
  </tr>
  <tr>
    <td><code>node['mysql']['tunable']['wait_timeout']</code></td>
    <td></td>
    <td><code>180</code></td>
  </tr>
  <tr>
    <td><code>node['mysql']['tunable']['net_read_timeout']</code></td>
    <td></td>
    <td><code>30</code></td>
  </tr>
  <tr>
    <td><code>node['mysql']['tunable']['net_write_timeout']</code></td>
    <td></td>
    <td><code>30</code></td>
  </tr>
  <tr>
    <td><code>node['mysql']['tunable']['back_log']</code></td>
    <td></td>
    <td><code>128</code></td>
  </tr>
  <tr>
    <td><code>node['mysql']['tunable']['table_cache']</code></td>
    <td></td>
    <td><code>128</code></td>
  </tr>
  <tr>
    <td><code>node['mysql']['tunable']['table_open_cache']</code></td>
    <td></td>
    <td><code>128</code></td>
  </tr>
  <tr>
    <td><code>node['mysql']['tunable']['max_heap_table_size']</code></td>
    <td></td>
    <td><code>32M</code></td>
  </tr>
  <tr>
    <td><code>node['mysql']['tunable']['expire_logs_days']</code></td>
    <td></td>
    <td><code>10</code></td>
  </tr>
  <tr>
    <td><code>node['mysql']['tunable']['max_binlog_size']</code></td>
    <td></td>
    <td><code>100M</code></td>
  </tr>
  <tr>
    <td><code>node['mysql']['client']</code></td>
    <td>Hash of MySQL client attributes</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>node['mysql']['client']['version']</code></td>
    <td></td>
    <td><code>6.0.2</code></td>
  </tr>
  <tr>
    <td><code>node['mysql']['client']['arch']</code></td>
    <td></td>
    <td><code>win32</code></td>
  </tr>
  <tr>
    <td><code>node['mysql']['client']['package_file']</code></td>
    <td></td>
    <td><code>mysql-connector-c-6.0.2-win32.msi</code></td>
  </tr>
  <tr>
    <td><code>node['mysql']['client']['url']</code></td>
    <td></td>
    <td><code>http://www.mysql.com/get/Downloads/Connector-C/mysql-connector-c-6.0.2-win32.msi/from/http://mysql.mirrors.pair.com/</code></td>
  </tr>
  <tr>
    <td><code>node['mysql']['client']['package_name']</code></td>
    <td></td>
    <td><code>MySQL Connector C 6.0.2</code></td>
  </tr>
  <tr>
    <td><code>node['mysql']['client']['basedir']</code></td>
    <td></td>
    <td><code>C:\Program Files (x86)\MySQL\Connector C 6.0.2</code></td>
  </tr>
  <tr>
    <td><code>node['mysql']['client']['lib_dir']</code></td>
    <td></td>
    <td><code>C:\Program Files (x86)\MySQL\Connector C 6.0.2\lib\opt</code></td>
  </tr>
  <tr>
    <td><code>node['mysql']['client']['bin_dir']</code></td>
    <td></td>
    <td><code>C:\Program Files (x86)\MySQL\Connector C 6.0.2\bin</code></td>
  </tr>
  <tr>
    <td><code>node['mysql']['client']['ruby_dir']</code></td>
    <td></td>
    <td><code>system ruby</code></td>
  </tr>
</table>

Recipes
-------

### mysql

Includes the client recipe to configure a client

### mysql::client

Installs packages required for mysql clients using run_action magic

### mysql::server

Installs packages required for mysql servers w/o manual intervention

### mysql::server_ec2

Performs EC2-specific mountpoint manipulation


License and Author
------------------

Author: Opscode, Inc. (<cookbooks@opscode.com>)

Copyright: 2013, Opscode, Inc.

License: Apache 2.0
