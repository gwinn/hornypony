# Horny Pony

Simple init script to manage multiple unicorn instance

## Setup

* Put all files from `/etc` to your `/etc` directory
* Put `unicorn.rb` into your project
* Change user name & application path in *.conf files
* Make sure that you have bundle & unicorn gems installed


## Usage

To control your unicorn instances run:

`/etc/init.d/pony -c <start|stop|restart|upgrade|force-stop> [-i <instance_name>] [-e <development|production|test>]`

`<instance_name>` is a name of one of your configuration files in `/etc/unicorn` directory, if you don't pass it with `-i` parameter, hornypony will execute selected command for all instances.

By default environment parameter is `development`, to change this on start or restart you instance pass `-e` parameter as showed in example above.
