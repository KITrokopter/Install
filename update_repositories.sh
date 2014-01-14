#!/bin/bash

set -eu

base=~/ros_ws/src
cd $base

# Update repository paths.
[ -d Quadcopter-Application ] && mv Quadcopter-Application quadcopter_application
[ -d Camera-Application ]     && mv Camera-Application camera_application
[ -d API-Application ]        && mv API-Application api_application
[ -d Control-Application ]    && mv Control-Application control_application

# Update repositories.
for repo in quadcopter_application camera_application api_application control_application; do
  cd $base/$repo
  git fetch
  # Only update when on master.
  if [ $(git rev-parse --abbrev-ref HEAD) = master ]; then
    git merge --ff-only origin/master
  fi
done
