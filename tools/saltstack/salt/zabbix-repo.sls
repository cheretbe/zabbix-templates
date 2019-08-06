zabbix_repo:
  pkgrepo.managed:
    - file: /etc/apt/sources.list.d/zabbix.list
    - names:
      - deb http://repo.zabbix.com/zabbix/4.0/ubuntu bionic main
      - deb-src http://repo.zabbix.com/zabbix/4.0/ubuntu bionic main
    - keyid: 082AB56BA14FE591
    - keyserver: keyserver.ubuntu.com
    - key_url: http://repo.zabbix.com/zabbix-official-repo.key
