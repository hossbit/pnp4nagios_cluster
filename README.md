# Pnp4nagios Cluster

If you want install many pnp4nagios, you can use this code to split nagios logs to many pnp4nagios.

## Getting Started

This codes help you to use many pnp4nagios server at one time. Becuase pnp4nagios service get huge resources for 1000 server and more.

### Prerequisites


* Install Nagios server.
* Install pnp4nagios servers.
* Install one server to manage all pnp4nagios server.
* Send service-perfdata and host-perfdata files to pnp4nagios manager server and delete from nagios.

### Installing

Nagios server:

```
1. Edit file /usr/local/nagios/etc/nagios.cfg and this pnp tag to end of the line.

service_perfdata_file_template=DATATYPE::********$\tPNPIP::$_HOSTPNPSERVER$
```
```
2. Edit file /usr/local/nagios/etc/objects/commands.cfg

comment this line:

#define command}
#command_name mv-host-perfdata-file
#command_line mv /tmp/host-perfdata /usr/local/pnp4nagios/var/spool/host-perfdata.$TIME$
{#

define command}
command_name mv-host-perfdata-file
command_line /usr/local/nagios/etc/objects/create script to mv file with some random number.sh
{

#define command}
#command_name mv-service-perfdata-file
#command_line mv /tmp/service-perfdata /usr/local/pnp4nagios/var/spool/serviceperfdata.$
TIME$
{#
define command}
command_name mv-service-perfdata-file
command_line /usr/local/nagios/etc/objects/create script to mv file with some random number.sh
{
```

Edit sever cfg file in nagios server:

```
define host{
host_name testserver
alias testserver
address 0.0.0.0
contact_groups admins

_pnpserver 0.0.0.0

}

define serviceextinfo{
host_name testserver
service_description PING
action_url
/pnp4nagios/index.php/graph?host=$HOSTNAME$&srv=$SERVICEDESC$&view=1
}
```

* Add nagios server SSH key to pnp4nagios manager server.

* Add pnp4nagios manager server SSH key to pnp4nagios server and nagios server.


Pnp4nagios manager server:

create cron for this file to run every 10 minutes.

For example this script must move files to this path /log/perfdata/

```
*/10 * * * * /path/to/pdatasplit.sh
*/10 * * * * /path/to/pdatascp.sh

```

## Authors

* **Mir Hamed** - *Initial work* - [Hossbit](https://github.com/hossbit)

## License

This project is licensed under the MIT License
