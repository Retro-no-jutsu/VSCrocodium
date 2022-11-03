Clear-Host

# Variables générales
$vscrocodiumversion = "1.0"
$rasmversion = "1.8b"
$vscodiumversion = "1.72.2.22289"
$z80macroasmversion = "0.7.8"
$z80asmmeterversion = "3.1.0"

$vscodiumlink = "https://github.com/VSCodium/vscodium/releases/download/1.72.2.22289/VSCodium-win32-x64-1.72.2.22289.zip"
$z80macroasmlink = "https://github.com/mborik/z80-macroasm-vscode/releases/download/v0.7.8/z80-macroasm-0.7.8.vsix"
$z80asmmeterlink = "https://github.com/theNestruo/z80-asm-meter-vscode/releases/download/3.1.0/z80-asm-meter-3.1.0.vsix"
$rasmlink = "https://github.com/EdouardBERGE/rasm/releases/download/build25092022/rasm.exe"

# Entête de présentation
Write-Host "Bienvenue dans le script d'installation de " -NoNewline
Write-Host "VSCrocodium " -ForegroundColor Green -NoNewline
Write-host "version " -NoNewline
Write-host "$vscrocodiumversion" -ForegroundColor Red
Write-host ""
Write-host "Ce script Powershell installe une chaine de compilation Assembleur Amstrad CPC pour Windows comprenant :"
Write-host ""
Write-Host " - " -NoNewline
Write-host "le compilateur assembleur " -NoNewline
Write-host "RASM " -ForegroundColor Green -NoNewline
Write-host "version " -NoNewline
Write-host "$rasmversion" -ForegroundColor Red
Write-Host " - " -NoNewline
Write-host "l'editeur de code " -NoNewline
Write-host "VSCodium " -ForegroundColor Green -NoNewline
Write-host "version " -NoNewline
Write-host "$vscodiumversion" -ForegroundColor Red
Write-Host " - l'extension " -NoNewline
Write-host "Z80 Macro assemblers " -ForegroundColor Green -NoNewline
Write-host "version " -NoNewline
Write-host "$z80macroasmversion" -ForegroundColor Red
Write-Host " - l'extension " -NoNewline
Write-host "Z80 Assembly meter " -ForegroundColor Green -NoNewline
Write-host "version " -NoNewline
Write-host "$z80asmmeterversion" -ForegroundColor Red
Write-host ""
Write-host "Ce script installe un dossier VSCrocodium sur votre bureau"
Write-host ""
$continue = read-host "Continuer l'installation ? (o/n)"
if ($continue -ne "o")
{
exit
}

Write-host ""
Write-host "Suppression dossier temporaire d'installation VSCrocodium " -NoNewline
Remove-Item "$($env:USERPROFILE)\downloads\vscrocodium_install\" -Filter * -Recurse -ErrorAction Ignore
Write-Host "OK" -ForegroundColor Green
Write-host "Ancienne installation VSCrocodium " -NoNewline
$testinstall = Test-Path -Path "$($env:USERPROFILE)\Desktop\VSCrocodium"
if ($testinstall -eq $True)
{
    Write-Host "Oui" -ForegroundColor Red
    Write-host "Attention une installation de VSCrocodium existe deja sur votre bureau" -ForegroundColor Red
    Write-host "Sa suppression est obligatoire pour permettre la nouvelle installation" -ForegroundColor Red
    Write-Host ""
    $continue2 = read-host "Continuer ? (o/n)"
    if ($continue2 -eq "o")
    {
        Remove-Item "$($env:USERPROFILE)\Desktop\VSCrocodium\" -Filter * -Recurse -ErrorAction Ignore
    }
    else 
    {
        exit
    }
}
else 
{
    Write-Host "Non" -ForegroundColor Green
}
Write-Host "Lancement de l'installation " -NoNewline
New-Item -ItemType directory -Path "$($env:USERPROFILE)\downloads\vscrocodium_install\" | Out-Null # Creation du dossier d'installation temporaire
Write-Host "." -NoNewline
$ProgressPreference = 'SilentlyContinue'
Invoke-WebRequest -Uri $vscodiumlink -OutFile "$($env:USERPROFILE)\downloads\vscrocodium_install\vscodium.zip" # Telechargement de VSCodium
Write-Host "." -NoNewline
Expand-Archive "$($env:USERPROFILE)\downloads\vscrocodium_install\vscodium.zip" "$($env:USERPROFILE)\Desktop\VSCrocodium" # Extraction de l'archive VSCodium
Write-Host "." -NoNewline
New-Item -ItemType directory -Path "$($env:USERPROFILE)\Desktop\VSCrocodium\data" | Out-Null # Création du repertoire data pour activer le mode portable
Write-Host "." -NoNewline
New-Item -ItemType directory -Path "$($env:USERPROFILE)\Desktop\VSCrocodium\data\apps" | Out-Null # Création du repertoire apps où seront stockés les programmes tiers
Write-Host "." -NoNewline
Invoke-WebRequest -Uri $z80macroasmlink -OutFile "$($env:USERPROFILE)\downloads\vscrocodium_install\z80-macroasm.vsix" # Telechargement de l'extension Z80-macroasm
Write-Host "." -NoNewline
Invoke-WebRequest -Uri $z80asmmeterlink -OutFile "$($env:USERPROFILE)\downloads\vscrocodium_install\z80-asm-meter.vsix" # Telechargement de l'extension Z80-asm-meter
Write-Host "." -NoNewline
Start-Process -WindowStyle hidden -FilePath "$($env:USERPROFILE)\Desktop\VSCrocodium\bin\codium.cmd" -wait -ArgumentList "--install-extension `"$($env:USERPROFILE)\downloads\vscrocodium_install\z80-macroasm.vsix`""# Installation de l'extension Z80-macroasm
Start-Process -WindowStyle hidden -FilePath "$($env:USERPROFILE)\Desktop\VSCrocodium\bin\codium.cmd" -wait -ArgumentList "--install-extension `"$($env:USERPROFILE)\downloads\vscrocodium_install\z80-asm-meter.vsix`"" # Installation de l'extension Z80-asm-meter
Start-Process -WindowStyle hidden -FilePath "$($env:USERPROFILE)\Desktop\VSCrocodium\bin\codium.cmd" -wait -ArgumentList "--install-extension MS-CEINTL.vscode-language-pack-fr" # Installation de l'extension language FR
Write-Host "." -NoNewline
Invoke-WebRequest -Uri https://raw.githubusercontent.com/Retro-no-jutsu/VSCrocodium/main/tasks.json -OutFile "$($env:USERPROFILE)\Desktop\VSCrocodium\data\user-data\User\tasks.json" # Telechargement de fichier task.json (config de build)
Invoke-WebRequest -Uri $rasmlink -OutFile "$($env:USERPROFILE)\Desktop\VSCrocodium\data\apps\rasm.exe" # Telechargement du compilateur RASM
Invoke-WebRequest -Uri http://cngsoft.no-ip.org/cpcec-20220806.zip -OutFile "$($env:USERPROFILE)\downloads\vscrocodium_install\cpcec.zip" # Telechargement de l'émulateur CPCEC
Write-Host ". " -NoNewline
Expand-Archive "$($env:USERPROFILE)\downloads\vscrocodium_install\cpcec.zip" "$($env:USERPROFILE)\Desktop\VSCrocodium\data\apps\cpcec\" # Extraction de l'archive CPCEC
Invoke-WebRequest -Uri https://raw.githubusercontent.com/Retro-no-jutsu/VSCrocodium/main/settings.json -OutFile "$($env:USERPROFILE)\Desktop\VSCrocodium\data\user-data\User\settings.json" # Telechargement du fichier de configuration VSCodium
Invoke-WebRequest -Uri https://raw.githubusercontent.com/Retro-no-jutsu/VSCrocodium/main/croco-icon.svg -OutFile "$($env:USERPROFILE)\Desktop\VSCrocodium\resources\app\out\vs\workbench\browser\media\code-icon.svg" # Telechargement du logo Croco Amstrad (petite icone fenetre de VSCodium)
Invoke-WebRequest -Uri https://raw.githubusercontent.com/Retro-no-jutsu/VSCrocodium/main/croco-icon.svg -OutFile "$($env:USERPROFILE)\Desktop\VSCrocodium\resources\app\out\vs\workbench\browser\parts\editor\media\letterpress-dark.svg" # Telechargement du logo Croco Amstrad (grande icone fenetre principale)
Write-Host "OK" -ForegroundColor Green

Invoke-WebRequest -Uri https://raw.githubusercontent.com/Retro-no-jutsu/VSCrocodium/main/deletelist.txt -OutFile "$($env:USERPROFILE)\downloads\vscrocodium_install\deletelist.txt" # Telechargement de la liste des fichiers/repertoires à nettoyer
$files = Get-Content "$($env:USERPROFILE)\downloads\vscrocodium_install\deletelist.txt" # Affectation du fichier de nettoyage à une variable
Get-ChildItem -Recurse "$($env:USERPROFILE)\Desktop\VSCrocodium\resources\app\extensions\" -Directory | %{If($_.Name -in $files ){ Remove-Item -LiteralPath $_.FullName -Force -Recurse; }} # Nettoyage dans le repertoire d'extensions de VSCodium
Start-Sleep -Seconds 2
Remove-Item "$($env:USERPROFILE)\downloads\vscrocodium_install\" -Filter * -Recurse -ErrorAction Ignore # Effacer le repertoire d'installation temporaire
Write-Host "L'installation est terminée !"
