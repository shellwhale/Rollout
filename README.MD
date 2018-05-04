# Rollout

Génération d'images WinPE

### Fonctionnement

* Une image WinPE est générée via Windows ADK à la racine du disque C: 
* Elle est ensuite montée via Dism
* Les fichiers Startnet.cmd et Start.ps1 situés dans DeployementFiles y sont copiés
* Les packages .cab y sont installés
* L'image est ensuite disponible dans le dossier Winbox (par défaut) qui contient le fichier winboot 

### Dépendances 

* Windows ADK for Windows 10, version 1703 (10.1.16299.15) ou plus 
* Powershell 5.1.16299.251 ou plus

### Startnet.cmd et Start.ps1

Configurer préparer les scripts Startnet.cmd et Start.ps1 dans DeployementFiles.
Par défaut, Startnet.cmd ne fait qu'appel à Start.ps1 après avoir désactiver le firewall.
Libre à vous de modifier Starnet.cmd ou Start.ps1 pour exécuter des scripts au démarrage de WinPE.

```
powershell .\rollout.ps1 -Arch <amd64/x86> -Path <directory>
```

