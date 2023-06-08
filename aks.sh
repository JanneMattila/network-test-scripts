#!/usr/bin/env bash

script_version="0.0.3"

echo "|-------------------------------------------------------|"
echo "|             _    _  ______                            |"
echo "|            / \  | |/ / ___|                           |"
echo "|           / _ \ | ' /\___ \                           |"
echo "|          / ___ \| . \ ___) |                          |"
echo "|         /_/   \_\_|\_\____/                           |"
echo "| Checking connectivity to required ports and addresses |"
echo "|                                                       |"
echo "| VERSION: $script_version                                        |"
echo "|                                                       |"
echo "| https://aka.ms/aks-required-ports-and-addresses       |"
echo "|-------------------------------------------------------|"

function show_end()
{
    echo ""
    echo "https://aka.ms/aks-required-ports-and-addresses"
    echo ""
    echo "AZURE REGION TESTED: $region"
    echo ""
    echo "SCRIPT VERSION: $script_version"
    echo "SCRIPT LOCATION: https://raw.githubusercontent.com/JanneMattila/network-test-scripts/main/aks.sh"
    echo ""
}

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
    nc -zv -w 15 $additional_switches $address $port
    nc_exit_code=$?
    if [ "$nc_exit_code" -ne 0 ]; then
        echo "Unable to connect to $address:$port"
        summary="$summary\nERROR - $address:$port"
        failures=$((failures + 1)) 
    else
        echo "Connected to $address:$port"
        summary="$summary\nOK - $address:$port"
    fi
    connectivity_tests=$((connectivity_tests + 1))
}

if [  -z "$1"  ]; then
    show_help
    exit 1
fi

region="$1"
dns_server="$2"
summary=""
failures=0
connectivity_tests=0

echo "Testing region $region"
echo ""
echo "Test Basic AKS cluster requirements:"
test_connection mcr.microsoft.com 443
test_connection $region.data.mcr.microsoft.com 443
test_connection $region.monitoring.azure.com 443
test_connection management.azure.com 443
test_connection packages.microsoft.com 443
test_connection acs-mirror.azureedge.net 443
test_connection login.microsoft.com 443
# test_connection vault.azure.net 443
test_connection dc.services.visualstudio.com 443
test_connection ntp.ubuntu.com 123 -u

if [ ! -z "$dns_server" ]; then
    test_connection $dns_server 53 -u
fi

echo ""
echo "Test OS AKS cluster requirements:"
test_connection esm.ubuntu.com 443
test_connection motd.ubuntu.com 443
test_connection security.ubuntu.com 80
test_connection azure.archive.ubuntu.com 80
test_connection changelogs.ubuntu.com 80
echo ""
echo "Test Cluster extensions AKS cluster requirements:"
test_connection $region.dp.kubernetesconfiguration.azure.com 443
test_connection arcmktplaceprod.azurecr.io 443
test_connection marketplaceapi.microsoft.com 443
echo ""
echo "Test Azure Policy AKS cluster requirements:"
test_connection data.policy.core.windows.net 443
test_connection store.policy.core.windows.net 443
echo ""
echo "Test GPU enabled AKS cluster requirements:"
test_connection nvidia.github.io 443
test_connection us.download.nvidia.com 443
test_connection download.docker.com 443
echo ""
echo "Test Windows Server based node pools requirements:"
test_connection onegetcdn.azureedge.net 443
test_connection go.microsoft.com 443
test_connection www.msftconnecttest.com 443
test_connection ctldl.windowsupdate.com 80
# test_connection $region.mp.microsoft.com 443

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
    echo "$failures out of $connectivity_tests connectivity checks failed."
    echo ""
    echo "IMPORTANT NOTE: These connectivity checks *DO NOT VALIDATE* all the connectivity requirements for AKS."
    echo ""
    echo "Please validate the failed connections and see if you need to open the ports and addresses documented here:"
    show_end
    exit 1
fi

echo "All $connectivity_tests connectivity checks passed."
echo ""
echo "IMPORTANT NOTE: These connectivity checks *DO NOT VALIDATE* all the connectivity requirements for AKS."
echo ""
echo "Please read the documentation to understand all the connectivity requirements for AKS:"
show_end
exit 0
