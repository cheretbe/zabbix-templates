pip:
  pkg:
    # We use Python3 PIP only, but 'pip.installed' fails if Python2 PIP is
    # not present
    - names: ["python-pip", "python3-pip"]
    - installed

zabbix_python_api:
  pip.installed:
    - name: zabbix-api
    - bin_env: /usr/bin/pip3
    - require:
      - pkg: pip