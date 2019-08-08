#!/usr/bin/env python3

import zabbix_api
import json

z_api = zabbix_api.ZabbixAPI(server="http://localhost/zabbix")
z_api.login("Admin", "zabbix")


template_ids = []

print("Exporting templates:")
for template in z_api.template.get({"search":{"name": "custom_template__"}, "output": ["templateid", "name"]}):
    print(" ", template["name"])
    template_ids += [template["templateid"]]

with open("/zabbix-templates/custom_templates.json", "w") as f:
    # 'configuration.export' returns non-indented non-human-readable text
    # We use intermediate JSON object to prettify it
    json_text = z_api.configuration.export({"format": "json", "options": {"templates": template_ids}})
    json_obj = json.loads(json_text)
    f.write(json.dumps(json_obj, indent=2))

z_api.logout()