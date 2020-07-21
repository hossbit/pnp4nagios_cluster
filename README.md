# pnp4nagios_cluster

If you want install many pnp4nagios, you can use this code to split nagios logs to many pnp4nagios.

## Getting Started

This codes help you to use many pnp4nagios server at one time. Becuase pnp4nagios service get huge resources for 1000 server and more.

### Prerequisites

1.Install Nagios server.
2.Install pnp4nagios servers.
3.Install one server to manage all pnp4nagios server.
4. Send service-perfdata and host-perfdata files to pnp4nagios manager server and delete from nagios.

```
Give examples
```

### Installing

Nagios server:

1. Edit file /usr/local/nagios/etc/nagios.cfg and this pnp tag to end of the line.

service_perfdata_file_template=DATATYPE::********$\tPNPIP::$_HOSTPNPSERVER$

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

For example this script must move files to this path /log/perfdata/

```
Give the example
```

And repeat

```
until finished
```

End with an example of getting some data out of the system or using it for a little demo

## Running the tests

Explain how to run the automated tests for this system

### Break down into end to end tests

Explain what these tests test and why

```
Give an example
```

### And coding style tests

Explain what these tests test and why

```
Give an example
```

## Deployment

Add additional notes about how to deploy this on a live system

## Built With

* [Dropwizard](http://www.dropwizard.io/1.0.2/docs/) - The web framework used
* [Maven](https://maven.apache.org/) - Dependency Management
* [ROME](https://rometools.github.io/rome/) - Used to generate RSS Feeds

## Owners and Guardians

Red Team - Owner
Green Team - Guardian

## Contributing

Please read [CONTRIBUTING.md](https://gist.github.com/PurpleBooth/b24679402957c63ec426) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/your/project/tags). 

## Authors

* **Billie Thompson** - *Initial work* - [PurpleBooth](https://github.com/PurpleBooth)

See also the list of [contributors](https://github.com/your/project/contributors) who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Hat tip to anyone whose code was used
* Inspiration
* etc
