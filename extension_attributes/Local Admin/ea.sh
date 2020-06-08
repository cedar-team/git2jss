#!/bin/bash
list=()
for username in $(dscl . list /Users UniqueID | awk '$2 > 499 { print $1 }'); do
if [[ $(dsmemberutil checkmembership -U "${username}" -G admin) != not ]]; then
list+=("${username}")
fi
done
echo "<result>${list[@]}</result>"