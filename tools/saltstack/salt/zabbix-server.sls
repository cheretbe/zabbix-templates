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

restart_apache_on_config_change:
  service:
    - name: apache2
    - running
    - enable: True
    - watch_any:
      - file: /etc/php/7.2/apache2/php.ini
      - file: /etc/zabbix/apache.conf