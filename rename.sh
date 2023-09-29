#!/bin/bash
export LC_CTYPE=C
export LANG=C

# How to run:
# 1. Ensure you've checked your files into a git repo (`git init .`, `git add -A`, `git commit -m 'first'`)
# 2. Modify these two values to your new app name
NEW_NAME="YourAppName"
NEW_CAMEL_NAME="your_app_name"
# 3. Execute the script in terminal: `sh rename.sh`

set -e

if ! command -v ack &> /dev/null
then
    echo "\`ack\` could not be found. Please install it before continuing (Mac: brew install ack)."
    exit 1
fi

CURRENT_NAME="ApplicationName"
CURRENT_CAMEL_NAME="application_name"

ack -l $CURRENT_NAME --ignore-file=is:rename.sh | xargs sed -i '' -e "s/$CURRENT_NAME/$NEW_NAME/g"
ack -l $CURRENT_CAMEL_NAME --ignore-file=is:rename.sh | xargs sed -i '' -e "s/$CURRENT_CAMEL_NAME/$NEW_CAMEL_NAME/g"
