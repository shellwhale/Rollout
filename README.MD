# Rollout

Génération d'images WinPE pour déploiement via IPXE 

### Fonctionnement

* Une image WinPE est générée via Windows ADK à la racine du disque C: 
* Elle est ensuite montée via Dism
* Les fichiers Startnet.cmd et Start.ps1 situés dans DeployementFiles y sont copiés
* Les packages .cab y sont installés
* L'image est ensuite disponible dans le dossier Winbox (par défaut) qui contient le fichier winboot 

```powershell
powershell \rollout.ps1 -Arch <amd64/x86> -Path <directory>
```

