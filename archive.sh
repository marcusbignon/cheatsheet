#!/bin/bash

fdate=$(date +%Y%m%d)

case "$1" in
    create)
        echo "Creating archive..."
        fname="${fdate}-archive-${2}"
        echo "Compressing in zip format: ${fname}.zip ..."
        zip -r "${fname}.zip" "${2}"
        echo "Encripting to file ${fname}.zip.enc ..."
        openssl enc -aes-256-cbc -e -in "${fname}.zip" > "${fname}.zip.enc"
        echo "create done."
        ;;
    push)
        echo "Pushing archive ${2} to ${3} in cloud drive..."
        mega-put ${2} "/archive/${3}/."
        echo "push done."
        ;;
    pull)
        echo "Pulling archive ${2} from cloud..."
        mega-get ${2} .
        echo "pull done."
        ;;
    extract)
        echo "Extracting archive ${2} ..."
        openssl enc -aes-256-cbc -d -in $2 > "${2}.zip"
        unzip "${2}.zip"
        echo "extract done."
        ;;
    *)
        echo "Usage: archive [create|push|pull|extract] <filename>" ;;
esac

