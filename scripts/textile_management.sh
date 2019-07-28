#! /bin/bash

# go-textile management script for common administrative tasks

COMMANDS="daemon | set-display-name | set-avatar-image | account-sync | add-contact-address | delete-contact | thread-invite | create-client-token | get-profile"

case "$1" in

    daemon)
        # starts textile daemon serving the docs
        textile daemon --serve-docs
        ;;
    set-display-name)
        # set peer display name
        echo "enter display name"
        read -r NAME
        textile profile set --name="$NAME"
        ;;
    set-avatar-image)
        # sets peer avatar
        echo "enter path to image"
        read -r PATH
        textile profile set --avatar="$PATH"
        ;;
    account-sync)
        # triggers an account sync
        textile account sync
        ;;
    add-contact-address)
        # adds a contact by address
        echo "enter contact address"
        read -r ADDRESS
        textile contacts add --address="$ADDRESS"
        ;;
    delete-contact)
        # deletes a contact by address
        echo "enter contact address"
        read -r ADDRESS
        textile contacts delete "$ADDRESS"
        ;;
    thread-invite)
        # generate an invite to a thread for an address
        echo "enter thread-id"
        read -r ID
        echo "enter contact address to invite"
        read -r ADDRESS
        textile invite create "$ID"--address="$ADDRESS"
        ;;
    create-client-token)
        # creates a client cafe token
        textile tokens create
        ;;
    get-profile)
        # gets profile
        textile profile get
        ;;
    *)
        echo "[ERROR] invalid invocation"
        echo "invocation: management.sh [ $COMMANDS ]"
        exit 1
        ;;

esac