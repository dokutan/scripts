#!/usr/bin/env python3

import os
import sys
import uuid
from pathlib import Path

if len(sys.argv) < 3:
    print("flatten a directory using symlinks")
    print(f"usage: {sys.argv[0]} path target")
    sys.exit(1)

# get list of files under path
path = Path(sys.argv[1])
files = [f for f in path.glob("**/*") if f.is_file()]

# prepare taget directory
target = Path(sys.argv[2])

if target.exists() and not target.is_dir():
    print(f"{target} exists and is not a directory")
    sys.exit(1)
elif not target.exists():
    target.mkdir()

if len(list(target.iterdir())) > 0:
    print(f"{target} was not empty")

# create symlinks
max_length = os.statvfs(target).f_namemax
for f in files:
    link_suffixes = "".join(f.suffixes)
    link_name = uuid.uuid4().hex + "-" + f.name
    link_name = link_name[0:max_length - len(link_suffixes)]
    Path(target).joinpath(link_name + link_suffixes).symlink_to(f)
