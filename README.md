# Horny Pony

Simple init script for multiply unicorn instance

## Setup

* Put all files in `/etc`
* Change user name & application path in *.conf files
* Make sure that you have bundle gem installed


## Usage

To control you unicorn instances run:

`/etc/init.d/pony command instance environment`

Where command is:
`<start|stop|restart|upgrade|force-stop|reopen-logs>`

instance is a name of one of your configuration files in `/etc/unicorn` directory

and environment is an your application environment:
`production` or `development`
