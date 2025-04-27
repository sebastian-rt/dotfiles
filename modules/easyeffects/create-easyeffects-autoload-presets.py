import sys
import re
import json
from pathlib import Path
import fnmatch

# ./create-easyeffects-autoload-presets.py <DEVICE_PRESET_MAP>

DEFAULT_PRESET="None"
EXCLUDE_DEVICES = ["easyeffects_sink"]
DEVICE_PRESET_MAP = {}

if len(sys.argv) > 1:
    mappings = sys.argv[1].split(",")
    for mapping in mappings:
        device, preset = mapping.split("=")
        DEVICE_PRESET_MAP[device] = preset

config_path = Path.home() / '.config/easyeffects'

def find_matching_preset(device_name):
    for device_pattern, preset in DEVICE_PRESET_MAP.items():
        if fnmatch.fnmatch(device_name, device_pattern):
            return preset
    return DEFAULT_PRESET

# Read from stdin
pactl_input = sys.stdin.read()

# Split into sections per Sink
sinks = pactl_input.split('Sink #')[1:]  # skip anything before the first sink

for sink in sinks:
    sink_id = sink.splitlines()[0].strip()

    name_match = re.search(r'\s*Name:\s*(.+)', sink)
    desc_match = re.search(r'\s*Description:\s*(.+)', sink)
    port_match = re.search(r'\s*Active Port:\s*(.+)', sink)

    name = name_match.group(1) if name_match else "N/A"
    desc = desc_match.group(1) if desc_match else "N/A"
    port = port_match.group(1) if port_match else "N/A"

    if name not in EXCLUDE_DEVICES:
        autoload = {
            "device": name,
            "device-description": desc,
            "device-profile": port,
            "preset-name": find_matching_preset(name)
        }

        with open(f"{config_path}/autoload/output/{name}:{port}.json", "w") as f:
            f.write(json.dumps(autoload, indent=4))
