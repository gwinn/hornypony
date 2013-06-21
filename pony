#!/bin/sh
### BEGIN INIT INFO
# Provides:          unicorn
# Required-Start:    $remote_fs $syslog
# Required-Stop:     $remote_fs $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Manage unicorn servers
# Description:       Start, stop, restart unicorn servers for a ruby application.
### END INIT INFO

set -e

while getopts jtc:i:e option
do
  case "${option}"
  in
    c) COMMAND=${OPTARG};;
    i) INSTANCE=${OPTARG};;
    e) ENVIRONMENT=${OPTARG};;
    j) JOBS=1;;
    t) CRON=1;;
  esac
done

if [ -z $ENVIRONMENT ]; then
  ENVIRONMENT="development"
fi

sig () {
  test -s "$PID" && kill -$1 `cat $PID`
}

run_task() {
  unset app_root

  . /etc/unicorn/$1.conf

  PID=$app_root/tmp/pids/unicorn.pid
  CMD="cd $app_root; bundle exec unicorn -D -c $app_root/config/unicorn.rb -E $ENVIRONMENT"

  run () {
    if [ "$(id -un)" == "$user" ]; then
      eval $1
    else
      su -c "$1" - $user
    fi
  }

  run_subtask() {
    if [ ! -z $JOBS ]; then
      if [ -f /etc/unicorn/jobs/$1.conf ]; then
        . /etc/unicorn/jobs/$1.conf
        run "cd $app_root; RAILS_ENV=$ENVIRONMENT $jobs_exec ${2} >/dev/null 2>&1"
        echo -e "\tjobs ${2}ed OK"
      else
        echo -e "\tno jobs for ${1}"
      fi
    else
      echo -e "\tno jobs for ${1}"
    fi

    if [ ! -z $CRON ]; then
      if [ -f /etc/unicorn/cron/$1.conf ]; then
        . /etc/unicorn/cron/$1.conf
        run "cd $app_root; RAILS_ENV=$ENVIRONMENT $cron_exec ${2} >/dev/null 2>&1"
        echo -e "\tcron ${2}ed OK"
      else
        echo -e "\tno cron for ${1}"
      fi
    else
      echo -e "\tno cron for ${1}"
    fi
  }

  case "$COMMAND" in
  start)
    sig 0 && echo >&2 "${1} already running" && return 0
    echo "${1} starting in ${ENVIRONMENT} environment"
    run "$CMD"
    echo -e "\tapp started  OK"
    run_subtask $1 "start"
    return 0
    ;;
  stop)
    sig QUIT && echo "${1} is stoping" && echo -e "\tapp stoped  OK" && run_subtask $1 "stop" && return 0
    echo >&2 "${1} not running"
    ;;
  restart)
    sig TERM && echo "restarting ${1}" && run "$CMD" && echo -e "\tapp restarted  OK" && run_subtask $1 "restart"&& return 0
    echo >&2 "${1} not running" && return 0
    ;;
  *)
    echo >&2 "Usage: $(basename "$0") -c <start|stop|restart> [-e <environment_name>][-i <instance_name>][-t][-j]"
    exit 1
    ;;
  esac


}

if [ -z $INSTANCE ]; then
  for f in /etc/unicorn/*.conf
  do
    if test -f "$f"; then
      run_task $(basename "${f%%.*}")
    fi
  done
  exit 0
else
  run_task $INSTANCE
  exit 0
fi



