#!/usr/bin/env python3

import subprocess
import json

output = subprocess.check_output([
    'nmcli',
    '--terse',
    'connection',
    'show',
    '--active'
]).decode()

vpn_connections = []

for l in output.split('\n'):
    parts = l.split(':')

    if len(parts) < 4:
        continue

    if parts[2] == 'wireguard':
        vpn_connections.append(parts[3])

if vpn_connections:
    result = {
        'text': 'vpn',
        'tooltip': ', '.join(vpn_connections)
    }
else:
    result = {
        'text': ''
    }

print(json.dumps(result))
