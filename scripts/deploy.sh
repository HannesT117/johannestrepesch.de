#!/usr/bin/env bash
set -e

deploy_assets_to_server () {
  dist_folder=$1

  echo "Start deploying assets to remote."

  export SSHPASS=$deploy_password
  sshpass -e ssh -o stricthostkeychecking=no $deploy_user@$deploy_host "find $deploy_path -type f \( \! -name $deploy_preserve \) -exec rm {} \;" 
  sshpass -e scp -o stricthostkeychecking=no -r $dist_folder $deploy_user@$deploy_host:$deploy_path
  export SSHPASS=
}

echo "Starting deployment."

if [ ! -d "$build_dir" ]; then
  echo "ERROR: The build directory does not exist."
  exit 1
fi

deploy_assets_to_server $build_dir