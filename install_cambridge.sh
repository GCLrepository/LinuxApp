#!/bin/bash

# Ukončení při jakékoliv chybě
set -e

echo "=================================================="
echo " Automatická instalace Cambridge One pro ChromeOS  "
echo "=================================================="

# 1. Instalace potřebných systémových knihoven
echo "[1/4] Instaluji systémové závislosti (libfuse2)..."
sudo apt-get update -y
sudo apt-get install -y libfuse2 libgl1-mesa-dri curl wget

# 2. Vytvoření instalační složky a stažení AppImage
INSTALL_DIR="/opt/cambridge-one"
sudo mkdir -p $INSTALL_DIR

# Přímý odkaz na stažení Cambridge One AppImage
# (Pokud máte vlastní úložiště/Google Drive direct link, nahraďte URL níže)
URL="http://nas01:5000/sharing/5M7YGCsO2"

echo "[2/4] Stahuji aplikaci Cambridge One..."
sudo wget -q --show-progress -O "$INSTALL_DIR/cambridge-one.AppImage" "$URL" || {
    echo "CHYBA: Nepodařilo se stáhnout aplikaci z adresy: $URL"
    exit 1
}

# Nastavení spouštěcích práv pro stažený soubor
sudo chmod +x "$INSTALL_DIR/cambridge-one.AppImage"

# 3. Vytvoření spouštěcího zástupce (.desktop) pro ChromeOS menu
echo "[3/4] Vytvářím zástupce v menu ChromeOS..."

DESKTOP_FILE="/usr/share/applications/cambridge-one.desktop"

sudo bash -c "cat <<EOF > $DESKTOP_FILE
[Desktop Entry]
Name=Cambridge One
Comment=Cambridge One Desktop Application
Exec=env LANG=cs_CZ.UTF-8 $INSTALL_DIR/cambridge-one.AppImage --no-sandbox
Icon=application-x-executable
Terminal=false
Type=Application
Categories=Education;
EOF"

sudo chmod +x $DESKTOP_FILE

# 4. Úklid
echo "[4/4] Dokončování..."
sudo apt-get clean

echo "=================================================="
echo " HOTOVO! Aplikace Cambridge One byla nainstalována."
echo "=================================================="

