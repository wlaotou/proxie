## ----------------------------------------------------------------------------
#
# Upstart script for proxie.
#
## ----------------------------------------------------------------------------

# info
description "proxie - a pluggable and configurable HTTP proxy/server."
author      "Andrew Chilton"

# respawn this task
start on runlevel [2345]
respawn
respawn limit 20 5
stop on shutdown

# allow opening of more than 1024 files
limit nofile 4096 4096

# set some environment variables
env NODE_ENV=production

# the script itself
script

    # quit the script if something goes wrong
    set -e

    # run the proxie server as this user
    exec \
        start-stop-daemon \
            --start \
            --make-pidfile \
            --pidfile /var/run/proxie.pid \
            --chuid __USER__ \
            --exec /usr/bin/authbind -- __NODE__ __PWD__/proxie.js

end script

## ----------------------------------------------------------------------------
