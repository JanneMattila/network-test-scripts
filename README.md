# Network test scripts

This repo contains network test scripts for validating network connectivity requirements for different Azure services.

You can test network connectivity from Azure VMs running in same VNet as the service you're going to deploy to that network.
You can run the validation script prior to the deployment to see if you have all the required network connectivity in place.

These example scripts are closely related to [JanneMattila/azure-firewall-and-network-testing](https://github.com/JanneMattila/azure-firewall-and-network-testing) which is test bed for validating your firewall configurations to match
the networking requirements of different Azure services.

## Azure Kubernetes Service (AKS)

Test network connectivity requirements for region `westeurope`:

```bash
curl -L https://raw.githubusercontent.com/JanneMattila/network-test-scripts/main/aks.sh | bash -s -- westeurope
```

Additionally you can test custom DNS access e.g., 1.1.1.1 (Cloudflare DNS):

```bash
curl -L https://raw.githubusercontent.com/JanneMattila/network-test-scripts/main/aks.sh | bash -s -- westeurope 1.1.1.1
```

Here is example output:

```text
|-------------------------------------------------------|
|             _    _  ______                            |
|            / \  | |/ / ___|                           |
|           / _ \ | ' /\___ \                           |
|          / ___ \| . \ ___) |                          |
|         /_/   \_\_|\_\____/                           |
| Checking connectivity to required ports and addresses |
|                                                       |
| VERSION: 0.0.1                                        |
|                                                       |
| https://aka.ms/aks-required-ports-and-addresses       |
|-------------------------------------------------------|
Testing region northeurope

Test Basic AKS cluster requirements:

Connection to mcr.microsoft.com 443 port [tcp/https] succeeded!
Connected to mcr.microsoft.com:443

Connection to northeurope.data.mcr.microsoft.com 443 port [tcp/https] succeeded!
Connected to northeurope.data.mcr.microsoft.com:443

Connection to northeurope.monitoring.azure.com 443 port [tcp/https] succeeded!
Connected to northeurope.monitoring.azure.com:443

Connection to management.azure.com 443 port [tcp/https] succeeded!
Connected to management.azure.com:443

Connection to packages.microsoft.com 443 port [tcp/https] succeeded!
Connected to packages.microsoft.com:443

Connection to acs-mirror.azureedge.net 443 port [tcp/https] succeeded!
Connected to acs-mirror.azureedge.net:443

Connection to login.microsoft.com 443 port [tcp/https] succeeded!
Connected to login.microsoft.com:443

Connection to dc.services.visualstudio.com 443 port [tcp/https] succeeded!
Connected to dc.services.visualstudio.com:443

Connection to ntp.ubuntu.com 123 port [udp/ntp] succeeded!
Connected to ntp.ubuntu.com:123

Test OS AKS cluster requirements:

Connection to esm.ubuntu.com 443 port [tcp/https] succeeded!
Connected to esm.ubuntu.com:443

Connection to motd.ubuntu.com 443 port [tcp/https] succeeded!
Connected to motd.ubuntu.com:443

Connection to security.ubuntu.com 80 port [tcp/http] succeeded!
Connected to security.ubuntu.com:80

Connection to azure.archive.ubuntu.com 80 port [tcp/http] succeeded!
Connected to azure.archive.ubuntu.com:80

Connection to changelogs.ubuntu.com 80 port [tcp/http] succeeded!
Connected to changelogs.ubuntu.com:80

Test Cluster extensions AKS cluster requirements:

Connection to northeurope.dp.kubernetesconfiguration.azure.com 443 port [tcp/https] succeeded!
Connected to northeurope.dp.kubernetesconfiguration.azure.com:443

Connection to arcmktplaceprod.azurecr.io 443 port [tcp/https] succeeded!
Connected to arcmktplaceprod.azurecr.io:443

Connection to marketplaceapi.microsoft.com 443 port [tcp/https] succeeded!
Connected to marketplaceapi.microsoft.com:443

Test Azure Policy AKS cluster requirements:

Connection to data.policy.core.windows.net 443 port [tcp/https] succeeded!
Connected to data.policy.core.windows.net:443

Connection to store.policy.core.windows.net 443 port [tcp/https] succeeded!
Connected to store.policy.core.windows.net:443

Test GPU enabled AKS cluster requirements:

Connection to nvidia.github.io 443 port [tcp/https] succeeded!
Connected to nvidia.github.io:443

Connection to us.download.nvidia.com 443 port [tcp/https] succeeded!
Connected to us.download.nvidia.com:443

Connection to download.docker.com 443 port [tcp/https] succeeded!
Connected to download.docker.com:443

Test Windows Server based node pools requirements:

Connection to onegetcdn.azureedge.net 443 port [tcp/https] succeeded!
Connected to onegetcdn.azureedge.net:443

Connection to go.microsoft.com 443 port [tcp/https] succeeded!
Connected to go.microsoft.com:443

Connection to www.msftconnecttest.com 443 port [tcp/https] succeeded!
Connected to www.msftconnecttest.com:443

Connection to ctldl.windowsupdate.com 80 port [tcp/http] succeeded!
Connected to ctldl.windowsupdate.com:80

|-----------------------------------------------------|
|  ____                                               |
| / ___| _   _ _ __ ___  _ __ ___   __ _ _ __ _   _   |
| \___ \| | | | '_ ` _ \| '_ ` _ \ / _` | '__| | | |  |
|  ___) | |_| | | | | | | | | | | | (_| | |  | |_| |  |
| |____/ \__,_|_| |_| |_|_| |_| |_|\__,_|_|   \__, |  |
|                                             |___/   |
|-----------------------------------------------------|

OK - mcr.microsoft.com:443
OK - northeurope.data.mcr.microsoft.com:443
OK - northeurope.monitoring.azure.com:443
OK - management.azure.com:443
OK - packages.microsoft.com:443
OK - acs-mirror.azureedge.net:443
OK - login.microsoft.com:443
OK - dc.services.visualstudio.com:443
OK - ntp.ubuntu.com:123
OK - esm.ubuntu.com:443
OK - motd.ubuntu.com:443
OK - security.ubuntu.com:80
OK - azure.archive.ubuntu.com:80
OK - changelogs.ubuntu.com:80
OK - northeurope.dp.kubernetesconfiguration.azure.com:443
OK - arcmktplaceprod.azurecr.io:443
OK - marketplaceapi.microsoft.com:443
OK - data.policy.core.windows.net:443
OK - store.policy.core.windows.net:443
OK - nvidia.github.io:443
OK - us.download.nvidia.com:443
OK - download.docker.com:443
OK - onegetcdn.azureedge.net:443
OK - go.microsoft.com:443
OK - www.msftconnecttest.com:443
OK - ctldl.windowsupdate.com:80

All 26 connectivity checks passed.

IMPORTANT NOTE: These connectivity checks *DO NOT VALIDATE* all the connectivity requirements for AKS.

Please read the documentation to understand all the connectivity requirements for AKS:

https://aka.ms/aks-required-ports-and-addresses

VERSION: 0.0.1
```