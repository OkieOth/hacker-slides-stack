# This is the first example

---

# WTF
* Hacker-slides creates HTML presentations from Markdown files
* Original Source: https://github.com/msoedov/hacker-slides

---

# Source code highlighting

```bash
#!/bin/bash

scriptPos=${0%/*}

source $scriptPos/stackConf.sh

if [ -z "$REMOTE_SSH_SERVER" ]; then
    read -r "SSH server to use, empty for localhost: " REMOTE_SSH_SERVER
fi

if [ -z "$REMOTE_SSH_SERVER" ]; then
    # if no REMOTE_SSH_SERVER given, local machine is used
    if ! netstat -nat | grep ":22" > /dev/null; then
        echo "it seems no local ssh server started"
        exit 1
    fi

    for address in $( ip address | grep inet | grep "/24" | awk '{print $2}' | sed -e 's-\(.*\)/24-\1-' ); do
        if [ -z "$REMOTE_SSH_SERVER" ]; then
            REMOTE_SSH_SERVER="$address"
            echo "address: $address"
            break
        fi
    done
fi

if [ -z "$REMOTE_SSH_PORT" ]; then
    REMOTE_SSH_PORT=22
fi

if [ -z "$REMOTE_SSH_USER" ]; then
    read -r -p "SSH user to use: " REMOTE_SSH_USER
fi

echo "Used wetty param:"
echo "   REMOTE_SSH_SERVER=$REMOTE_SSH_SERVER"
echo "   REMOTE_SSH_PORT=$REMOTE_SSH_PORT"
echo "   REMOTE_SSH_USER=$REMOTE_SSH_USER"

export REMOTE_SSH_SERVER
export REMOTE_SSH_PORT
export REMOTE_SSH_USER

composeFile="$STACK_NAME.yml"

pushd "$scriptPos/../docker" > /dev/null

docker-compose -p "$STACK_NAME" -f $composeFile up -d
```