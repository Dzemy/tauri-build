# Nastaví aktuální adresář na C:\
Set-Location -Path 'C:\'

# Vytvoří složku 'temp', pokud neexistuje
if (!(Test-Path -Path 'temp')) {
    New-Item -ItemType Directory -Path 'temp'
}

# Kopíruje všechny soubory a složky z 'app' do 'temp'
Copy-Item -Path 'app\*' -Destination 'temp' -Recurse

# Přejde do složky 'temp'
Set-Location -Path 'temp'

# Instaluje balíčky pomocí pnpm
pnpm install

# Aktualizuje balíčky pomocí pnpm
pnpm update

# Sestaví projekt pomocí pnpm a Tauri
pnpm tauri build

# Kopíruje build zpátky do app
Copy-Item -Path 'src-tauri\target\*' -Destination 'C:\app\src-tauri\target' -Recurse

# powershell