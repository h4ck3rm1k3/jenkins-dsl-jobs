#!/bin/sh
echo '<<<<<<<<<<<<<< Prepare Build Env <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<'
# Don't call 'salt-call' at the same time
sleep $(($RANDOM % 6))

# Wait for a running salt-call state.sls
if [ "$(pgrep -f 'salt-call state.sls')" != "" ]; then
    printf "%s" "Waiting on running salt-call to finish "
    while [ "$(pgrep -f 'salt-call state.sls')" != "" ]; do
        sleep 1
        printf "%s" "."
    done
    printf "%s\n\n" "Done!"
fi

if [ "${VIRTUALENV_NAME}" != "" ]; then
    salt-call state.sls ${VIRTUALENV_SETUP_STATE_NAME} pillar="{virtualenv_name: ${VIRTUALENV_NAME}, system_site_packages: ${SYSTEM_SITE_PACKAGES:-false}}"
else
    salt-call state.sls ${VIRTUALENV_SETUP_STATE_NAME}
echo '<<<<<<<<<<<<<< Prepare Build Env <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<'
