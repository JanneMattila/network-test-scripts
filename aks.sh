#!/usr/bin/env bash

echo "|-------------------------------------------------------|"
echo "|             _    _  ______                            |"
echo "|            / \  | |/ / ___|                           |"
echo "|           / _ \ | ' /\___ \                           |"
echo "|          / ___ \| . \ ___) |                          |"
echo "|         /_/   \_\_|\_\____/                           |"
echo "| Checking connectivity to required ports and addresses |"
echo "|                                                       |"
echo "| https://aka.ms/aks-required-ports-and-addresses       |"
echo "|-------------------------------------------------------|"


function show_help()
{
    echo ""
    echo "Usage: $0 [region]"
    echo ""
    echo "Arguments:"
    echo "  region: The region to test connectivity to e.g, northeurope."
    echo ""
}

function test_connection()
{
    local address="$1"
    local port="$2"
    local additional_switches="$3"

    echo ""
    nc -zv -w 3 $additional_switches $address $port
    nc_exit_code=$?
    if [ "$nc_exit_code" -ne 0 ]; then
        echo "Unable to connect to $address:$port"
        summary="$summary\nERROR - $address:$port"
        failures=$((failures + 1)) 
    else
        echo "Connected to $address:$port"
        summary="$summary\nOK    - $address:$port"
    fi
}

if [  -z "$1"  ]; then
    show_help
    exit 1
fi

region="$1"
summary=""
failures=0

echo "Testing region $region"

test_connection mcr.microsoft.com 443
test_connection $region.data.mcr.microsoft.com 443
test_connection management.azure.com 443
test_connection packages.microsoft.com 443
test_connection esm.ubuntu.com 443
test_connection security.ubuntu.com 80
test_connection azure.archive.ubuntu.com 80
test_connection changelogs.ubuntu.com 80
test_connection login.microsoft.com 443
test_connection ntp.ubuntu.com 123 -u
test_connection 1.1.1.1 53 -u

echo ""
echo "|-----------------------------------------------------|"
echo "|  ____                                               |"
echo "| / ___| _   _ _ __ ___  _ __ ___   __ _ _ __ _   _   |"
echo "| \\___ \\| | | | '_ \` _ \\| '_ \` _ \\ / _\` | '__| | | |  |"
echo "|  ___) | |_| | | | | | | | | | | | (_| | |  | |_| |  |"
echo "| |____/ \__,_|_| |_| |_|_| |_| |_|\__,_|_|   \__, |  |"
echo "|                                             |___/   |"
echo "|-----------------------------------------------------|"
echo -e $summary
echo ""

if [ "$failures" -ne 0 ]; then
    echo ""
    echo "$failures connectivity checks failed."
    echo ""
    echo "You *NEED* to open the ports and addresses documented here:"
    echo ""
    echo "https://aka.ms/aks-required-ports-and-addresses"
    echo ""
    exit 1
fi

echo "All connectivity checks passed."
echo ""
exit 0
