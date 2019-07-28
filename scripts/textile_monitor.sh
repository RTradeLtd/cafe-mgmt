#! /bin/bash

COMMANDS="peer-count | daemon-status"

case "$1" in

    peer-count)
        COUNT=$(textile ipfs swarm peers | grep -c addr)
        echo "$COUNT"
        ;;
    daemon-status)
        # neat trick avoiding the `| grep -v | expr`
        # https://unix.stackexchange.com/questions/74185/how-can-i-prevent-grep-from-showing-up-in-ps-results
        COUNT=$(ps aux | grep -c "[t]extile daemon")
        echo "$COUNT"
        ;;
    *)
        echo "[ERROR] invalid invocation"
        echo "invocation: textile_monitor.sh [ $COMMANDS ]"
        exit 1
        ;;
esac