# Horny Pony

Simple init script to manage multiple unicorn instance

## Setup

* Put `pony` script to any place you like
* Put all files from `unicorn` to your system `/etc/unicorn` directory
* Put `unicorn.rb` into your project `config` directory
* Change user name & application path in *.conf files
* Make sure that you have bundle & unicorn gems installed


## Usage

To control your unicorn instances run:

`sh /path/to/pony [-t] [-j] -c <start|stop|restart> [-i <instance>] [-e <development|production|test>]`

`<instance>` is a name of one of your configuration files in `/etc/unicorn` directory. 
If you don't pass it with `-i` parameter, hornypony will execute selected command for all instances.

By default environment parameter is `development`. 
To change it on start or restart pass `-e` parameter as showed in example above.

Optional parameters `-t` and `-j` tells `pony` that it must to start, stop or restart additional scripts like an `delayed_job` or `clockworkd`. 
Configuration files for that scripts can be placed in `/etc/unicorn/cron` or `/etc/unicorn/jobs/`. 
These files should be named identical to the name of the instance.
