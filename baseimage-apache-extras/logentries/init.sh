#!/bin/bash
le init --account-key=$LOGENTRIES_KEY --host-key=$LOGENTRIES_HOST

# itterate through follow log list, follow any not being followed.
while IFS= read -r opt; do
    #somestuff $opt
    OUTPUT="$(le followed $opt)"

    # if the first 3 chars are NOT, its not followed,  follow it
    if [ ${OUTPUT:0:3} = 'NOT' ]; then
        echo "Following $opt"
        le follow $opt
    fi
done </app/.docker/logentries/followlist.txt
