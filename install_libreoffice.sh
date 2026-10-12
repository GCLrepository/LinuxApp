#!/bin/bash

# Ukončení při jakékoliv chybě
set -e

echo "=================================================="
echo " Automatická instalace LibreOffice z Debian repozitářů "
echo "=================================================="

# 1. Aktualizace seznamu balíčků a přidání non-free repozitářů pro MS fonty
echo "[1/3] Připravuji repozitáře a instaluji MS fonty..."
sudo apt-get update -y

sudo apt-get install -y software-properties-common
sudo add-apt-repository contrib non-free -y || true
sudo apt-get update -y

# Automatické schválení licence pro ttf-mscorefonts-installer (Calibri, Arial, Times New Roman...)
echo "ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true" | sudo debconf-set-selections

# 2. Instalace LibreOffice, češtiny, slovníků a systémových závislostí
echo "[2/3] Instaluji LibreOffice v češtině a potřebné knihovny..."
sudo apt-get install -y \
    curl \
    wget \
    fontconfig \
    ttf-mscorefonts-installer \
    libreoffice \
    libreoffice-l10n-cs \
    libreoffice-help-cs \
    hunspell-cs \
    hyphen-cs \
    mythes-cs

# 3. Doinstalování fontu Aptos
echo "[3/3] Stahuji a instaluji font Aptos..."
FONT_DIR="/usr/local/share/fonts/aptos"
sudo mkdir -p "$FONT_DIR"

sudo wget -q -O "$FONT_DIR/Aptos.ttf" "https://raw.githubusercontent.com/kkzzoll/aptos-font/main/Aptos.ttf" || true
sudo wget -q -O "$FONT_DIR/Aptos-Bold.ttf" "https://raw.githubusercontent.com/kkzzoll/aptos-font/main/Aptos-Bold.ttf" || true

# Obnovení keše fontů pro celý systém
sudo fc-cache -f -v > /dev/null 2>&1

# Úklid
sudo apt-get clean

echo "=================================================="
echo " HOTOVO! LibreOffice (CZ) byl úspěšně nainstalován."
echo "=================================================="