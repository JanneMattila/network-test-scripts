# Network test scripts

Network test scripts

## AKS

Test basic network connectivity:

```bash
curl -L https://raw.githubusercontent.com/JanneMattila/network-test-scripts/main/aks.sh | bash -s -- northeurope
```

To test access to custom DNS:

```bash
curl -L https://raw.githubusercontent.com/JanneMattila/network-test-scripts/main/aks.sh | bash -s -- northeurope 1.1.1.1
```
