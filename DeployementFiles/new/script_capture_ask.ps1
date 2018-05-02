net use z: \\sv-w2k12-pedah.pedagogique.lan\deploiement$ techn0cite /user:scripts@pedagogique.lan
diskpart /s diskpart\dp_list_volume.txt
$lecteur = Read-Host "Lettre du lecteur a capturer (ex:e) : "
$nom = Read-Host "Titre de l'image (pas d'espace ex:win10a_CC) : "
dism /Capture-Image /CaptureDir:$lecteur:\ /ImageFile:Z:\images\$nom.wim /Name:$nom /Compress:max
Set-Location Z:\images\
Z:\outils\mktorrent-1.0-win-64bit-build1\mktorrent.exe -a http://tracker.pedagogique.lan/announce.php -o $nom.wim.torrent -p $nom.wim

echo "Veuillez envoyer le fichier torrent sur le tracker"
z:
cd images\

pause
cmd
exit
