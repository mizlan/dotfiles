import subprocess
import sys
import shlex
import time
from pathlib import Path

config_file = "~/scripts/zoom_helper/zoom_links"

with Path(config_file).expanduser().open() as f:
    config = dict(entry.split(None, 1) for entry in f.readlines())


def needs_delay(choice):
    return choice.strip()[-1] == "*"


key_str = "\n".join(config.keys())
proc = subprocess.run(
    ["choose", "-f", "Roboto Mono", "-b", "abc8d6", "-c", "0f4661"],
    input=key_str.encode("utf-8"),
    capture_output=True,
)
if proc.returncode != 0:
    sys.stderr.write("error\n")
    sys.exit(proc.stderr)

choice = proc.stdout.decode("utf-8").strip()
try:
    link = config[choice].strip()
except KeyError:
    sys.exit(f'Did not find the choice: "{choice}"')

if needs_delay(choice):
    subprocess.run(shlex.split("open -a zoom.us"))
    time.sleep(3)

subprocess.run(["open", "-a", "zoom.us", link])
