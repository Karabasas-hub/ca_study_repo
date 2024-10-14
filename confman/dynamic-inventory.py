#!/usr/bin/env python3

import json
import sys

inventory = {
	"all": {
		"hosts": ["localhost"],
		"vars": {
			"ansible_connection": "local",
			"ansible_python_interpreter": "/usr/bin/python3"
		}
	},
	"_meta": {
		"hostvars": {
			"localhost": {
				"custom_var": "value"
				}
			}
		}
	}

print(json.dumps(inventory))
