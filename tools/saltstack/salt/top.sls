#fileserver_backend:
#  - roots
#  - git
#gitfs_remotes:
#  - https://github.com/saltstack-formulas/tmux-formula.git
base:
  '*':
    - utils
    - zabbix-repo
    - zabbix-server
    - development

    # - zabbix.agent.repo
    # - zabbix.agent.conf

    # - zabbix.server
    # - zabbix.agent