zabbix_server_prerequisites:
  pkg:
    - names: ["apache2", "libapache2-mod-php", "php", "php-pear", "php-cgi",
              "php-common", "libapache2-mod-php", "php-mbstring", "php-net-socket",
              "php-gd", "php-mysql", "php-gettext", "php-bcmath",
              "mariadb-server"]
    - installed
    - require: [zabbix_repo]

zabbix_server_packages:
  pkg:
    - names: ["zabbix-server-mysql", "zabbix-frontend-php", "zabbix-agent",
              "zabbix-get"]
    - installed
    - require: [zabbix_server_prerequisites]

apache_config_1:
  file.managed:
    - name: /etc/php/7.2/apache2/php.ini
    - source: salt://config/php.ini
apache_config_2:
  file.managed:
    - name: /etc/zabbix/apache.conf
    - source: salt://config/apache.conf

zabbix_server_config:
  file.managed:
    - name: /etc/zabbix/zabbix_server.conf
    - source: salt://config/zabbix_server.conf

zabbix_config:
  file.managed:
    - name: /etc/zabbix/web/zabbix.conf.php
    - source: salt://config/zabbix.conf.php

restart_apache_on_config_change:
  service:
    - name: apache2
    - running
    - enable: True
    - watch_any:
      - file: /etc/php/7.2/apache2/php.ini
      - file: /etc/zabbix/apache.conf

create_database:
  cmd.run:
    - name: |
        /usr/bin/mysql -u root -se "create database zabbixdb character set utf8 collate utf8_bin;
            grant all privileges on zabbixdb.* to zabbixuser@localhost identified by 'Password';
            flush privileges;"
        /bin/zcat /usr/share/doc/zabbix-server-mysql/create.sql.gz | /usr/bin/mysql -u zabbixuser -pPassword zabbixdb
    - unless: test -d /var/lib/mysql/zabbixdb/

register_and_start_zabbix:
  service:
    - names:
        - zabbix-server
        - zabbix-agent
    - running
    - enable: True
