# zabbix-templates

* https://bencane.com/2016/03/22/self-managing-servers-with-masterless-saltstack-minions/
* https://www.linode.com/docs/applications/media-servers/install-plex-media-server-with-salt/
* https://github.com/saltstack-formulas/zabbix-formula/issues/104
* https://stackoverflow.com/questions/19822927/salt-stack-replace-add-minion-name-to-file-in-managed-file-formula

```SaltStack
monitor_file_test:
  file.managed:
    - name: /path/to/template_file.xml
    - source: salt://templates/template_file.xml
  cmd.script:
    - name: my_script.py
    - source: salt://scripts/my_script.py
    - onchanges:
      - file: /path/to/template_file.xml
```
