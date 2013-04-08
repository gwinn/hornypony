# Horny Pony

Simple init script for multiply unicorn instance

## Setup

* Put all files from `/etc` to your `/etc` directory
* Put `unicorn.rb` into your project
* Change user name & application path in *.conf files
* Make sure that you have bundle & unicorn gems installed


## Usage

To control you unicorn instances run:

`/etc/init.d/pony -i <instance_name> -c <start|stop|restart|upgrade|force-stop> [-e
<development|production|test>]`

instance_name is a name of one of your configuration files in `/etc/unicorn` directory

environment parameter is required when you start or restart you instance
