# Horny Pony

Simple init script for multiply unicorn instance

## Setup

* Put all files in `/etc`
* Change user name & application path in *.conf files
* Make sure that you have bundle gem installed


## Usage

To control you unicorn instances run:

`/etc/init.d/pony -i <instance_name> -c <start|stop|restart|upgrade|force-stop|reopen-logs> [-e
<development|production|test>]`

instance_name is a name of one of your configuration files in `/etc/unicorn` directory

