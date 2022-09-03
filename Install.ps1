
Remove-Item "$($env:USERPROFILE)\downloads\vscrocodium_install\" -Filter * -Recurse -ErrorAction Ignore # Si le dossier d'installation temporaire existe deja, on l'efface
New-Item -ItemType directory -Path "$($env:USERPROFILE)\downloads\vscrocodium_install\" | Out-Null # Creation du dossier d'installation temporaire
Invoke-WebRequest -Uri https://github.com/VSCodium/vscodium/releases/download/1.71.0.22245/VSCodium-win32-x64-1.71.0.22245.zip -OutFile "$($env:USERPROFILE)\downloads\vscrocodium_install\vscodium.zip" # Telechargement de VSCodium
Expand-Archive "$($env:USERPROFILE)\downloads\vscrocodium_install\vscodium.zip" "$($env:USERPROFILE)\VSCrocodium" # Extraction de l'archive VSCodium
New-Item -ItemType directory -Path "$($env:USERPROFILE)\VSCrocodium\data" | Out-Null # Création du repertoire data pour activer le mode portable
New-Item -ItemType directory -Path "$($env:USERPROFILE)\VSCrocodium\data\apps" | Out-Null # Création du repertoire apps où seront stockés les programmes tiers
Invoke-WebRequest -Uri https://github.com/mborik/z80-macroasm-vscode/releases/download/v0.7.8/z80-macroasm-0.7.8.vsix -OutFile "$($env:USERPROFILE)\downloads\vscrocodium_install\z80-macroasm.vsix" # Telechargement de l'extension Z80-macroasm
Invoke-WebRequest -Uri https://github.com/theNestruo/z80-asm-meter-vscode/releases/download/3.1.0/z80-asm-meter-3.1.0.vsix -OutFile "$($env:USERPROFILE)\downloads\vscrocodium_install\z80-asm-meter.vsix" # Telechargement de l'extension Z80-asm-meter
Start-Process -FilePath "$($env:USERPROFILE)\VSCrocodium\bin\codium.cmd" -ArgumentList "--install-extension `"$($env:USERPROFILE)\downloads\vscrocodium_install\z80-macroasm.vsix`"" # Installation de l'extension Z80-macroasm
Start-Process -FilePath "$($env:USERPROFILE)\VSCrocodium\bin\codium.cmd" -ArgumentList "--install-extension `"$($env:USERPROFILE)\downloads\vscrocodium_install\z80-asm-meter.vsix`"" # Installation de l'extension Z80-asm-meter
Invoke-WebRequest -Uri https://github.com/EdouardBERGE/rasm/releases/download/v1.7/rasm_18a_x64.exe -OutFile "$($env:USERPROFILE)\VSCrocodium\data\apps\rasm.exe" # Telechargement du compilateur RASM
Remove-Item "$($env:USERPROFILE)\downloads\vscrocodium_install\" -Filter * -Recurse -ErrorAction Ignore # Effacer le repertoire d'installation temporaire