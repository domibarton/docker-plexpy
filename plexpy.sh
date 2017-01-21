#!/bin/bash
set -e

#
# Display settings on standard out.
#

USER="plexpy"

echo "PlexPy settings"
echo "==============="
echo
echo "  User:       ${USER}"
echo "  UID:        ${PLEXPY_UID:=666}"
echo "  GID:        ${PLEXPY_GID:=666}"
echo
echo "  Config:     ${CONFIG:=/datadir/config.ini}"
echo

#
# Change UID / GID of PlexPy user.
#

printf "Updating UID / GID... "
[[ $(id -u ${USER}) == ${PLEXPY_UID} ]] || usermod  -o -u ${PLEXPY_UID} ${USER}
[[ $(id -g ${USER}) == ${PLEXPY_GID} ]] || groupmod -o -g ${PLEXPY_GID} ${USER}
echo "[DONE]"

#
# Set directory permissions.
#

printf "Set permissions... "
touch ${CONFIG}
chown -R ${USER}: /plexpy
chown ${USER}: /datadir $(dirname ${CONFIG}) ${CONFIG}
echo "[DONE]"

#
# Finally, start PlexPy.
#

echo "Starting PlexPy..."
exec su -pc "./PlexPy.py --nolaunch --datadir=$(dirname ${CONFIG}) --config=${CONFIG}" ${USER}
