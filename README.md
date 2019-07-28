# cafe-mgmt

Tooling to management and monitor textile cafes in production

# Contents

This repository is broken into a few different directories, namely scripts and configs. In the future automatic tooling will be included in appropriately named directories

## Configs (systemd)

`textile.service` is a basic systemd service to start a textile node

## Configs (zabbix)

`textile_template.xml` is a zabbix template and does the following:

* Retrieves peer count
* Retrieves daemon status (trigger fires when daemon is offline)
* Retrieves thread count

`userparameter_textile.conf` is a zabbix agent.d config file

## Scripts

`textile_install.sh` is a script used to install a textile cafe

* Installs zabbix
* Installs `go-textile` and initializes a cafe

`textile_management.sh` is used to manage a textile node

* start daemon
* set display name
* set avatar image
* add/delete contacts
* create thread invites
* create/delete client token
* get profile

`textile_monitor.sh` is a monitoring script for use with zabbix

* Retrieve peer count
* Retrieve daemon status
* Retrieve thread count