#! /bin/bash

# provides a watcher script so that in the rare case of an unexpected node crash, we restart it
  
while true; do
        ACTIVE=$(sudo systemctl is-active textile)
        if [[ "$ACTIVE" == "inactive" ]]; then
                echo "textile node is offline, restarting"
                sudo systemctl restart textile
        fi
done
