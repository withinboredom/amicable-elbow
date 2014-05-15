#!/bin/bash
# Sample App       Init script for running sample app daemon
#
# chkconfig: - 98 02
#
# description: Sample Application Upstart, using Forever


APPHOME=/home/azureuser/deploy
APPSCRIPT=hook.js

PATH=/usr/bin:/sbin:/bin:/usr/sbin
export PATH

# Source function library.

start() {
    echo -n $"Starting sample-app agent: "
    cd "$APPHOME"
    sudo -u azureuser /usr/bin/forever start "$APPSCRIPT"
    echo
}

stop() {
    echo -n $"Stopping sample-app agent: "
    cd "$APPHOME"
    sudo -u azureuser /usr/bin/forever stop "$APPSCRIPT"
    echo
}

reload() {
    echo -n $"Restarting sample-app agent: "
    stop
    start
    echo
}

status() {
    cd "$APPHOME"
    sudo -u azureuser /usr/bin/forever list
}

restart() {
    reload
}

case "$1" in
    start)
        start
    ;;
    stop)
        stop
    ;;
    restart|reload|force-reload)
        reload
    ;;
    status)
        status
    ;;
    *)
        echo $"Usage: $0 {start|stop|status|restart|reload|force-reload"
        exit 1
esac

exit $RETVAL