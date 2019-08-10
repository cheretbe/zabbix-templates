#!/usr/bin/env python3

import zabbix_api
import json

# import_rules = "rules": {
#     "applications": {
#         "createMissing": True,
#         "deleteMissing": False
#     },
#     "valueMaps": {
#         "createMissing": True,
#         "updateExisting": False
#     },
#     "hosts": {
#         "createMissing": True,
#         "updateExisting": True
#     },
#     "items": {
#         "createMissing": True,
#         "updateExisting": True,
#         "deleteMissing": True
#     }
# }
# print(import_rules)


file_name = "/zabbix-templates/custom_templates.json"
print("Importing templates from '{}'".format(file_name))

with open("/zabbix-templates/custom_templates.json", "r") as f:
    json_text = f.read()


z_api = zabbix_api.ZabbixAPI(server="http://localhost/zabbix")
z_api.login("Admin", "zabbix")


z_api.configuration.import_(
    {"format": "json",
     "source": json_text,
     "rules": {
        "applications": {
            "createMissing": True,
            "deleteMissing": False
        },
        "templates": {
            "createMissing": True,
            "updateExisting": True
        },
        "items": {
            "createMissing": True,
            "updateExisting": True,
            "deleteMissing": True
        },
        "triggers": {
            "createMissing": True,
            "updateExisting": True,
            "deleteMissing": True
        },
        "valueMaps": {
            "createMissing": True,
            "updateExisting": False
        }
    }
})

# print(json_text)


# for template in z_api.template.get({"search":{"name": "custom_template__"}, "output": ["templateid", "name"]}):
#     print(" ", template["name"])
#     template_ids += [template["templateid"]]


z_api.logout()