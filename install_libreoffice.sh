#!/bin/bash

# Ukončení při jakékoliv chybě
set -e

echo "=================================================="
echo " Automatická instalace LibreOffice z Debian repozitářů "
echo "=================================================="

# 1. Povolení contrib a non-free repozitářů a aktualizace
echo "[1/3] Povoluji non-free repozitáře a instaluji MS fonty..."
sudo sed -i 's/main$/main contrib non-free non-free-firmware/' /etc/apt/sources.list || true
sudo apt-get update -y

# Instalace pomocných nástrojů pro fonty
sudo apt-get install -y wget curl fontconfig

# Automatické schválení licence pro ttf-mscorefonts-installer (Calibri, Arial, Times New Roman...)
echo "ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true" | sudo debconf-set-selections

# Instalace MS fontů
sudo apt-get install -y ttf-mscorefonts-installer || echo "Varování: MS fonty se nepodařilo plně nainstalovat, pokračuji..."

# 2. Instalace LibreOffice, češtiny a slovníků
echo "[2/3] Instaluji LibreOffice v češtině a potřebné knihovny..."
sudo apt-get install -y \
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

#!/bin/bash

# Ukončení při jakékoliv chybě
set -e

echo "=================================================="
echo " Oprava češtiny a fontu Aptos pro LibreOffice      "
echo "=================================================="

# 1. Nastavení českého prostředí (Locale) v Debianu
echo "[1/4] Nastavuji české prostředí systému..."
sudo apt-get update -y
sudo apt-get install -y locales

# Vygenerování české lokalizace
sudo sed -i 's/# cs_CZ.UTF-8 UTF-8/cs_CZ.UTF-8 UTF-8/' /etc/locale.gen
sudo locale-gen cs_CZ.UTF-8

# 2. Ujištění, že jsou nainstalovány čeština a fonty
echo "[2/4] Kontrola instalace jazykových balíčků..."
sudo apt-get install -y \
    libreoffice-l10n-cs \
    libreoffice-help-cs \
    hunspell-cs \
    hyphen-cs \
    mythes-cs \
    fontconfig \
    wget

# 3. Stažení a instalace fontu Aptos
echo "[3/4] Instaluji font Aptos..."
FONT_DIR="/usr/share/fonts/truetype/aptos"
sudo mkdir -p "$FONT_DIR"

# Stažení variant fontu Aptos z ověřeného zdroje
sudo wget -q -O "$FONT_DIR/Aptos.ttf" "https://raw.githubusercontent.com/kkzzoll/aptos-font/main/Aptos.ttf" || true
sudo wget -q -O "$FONT_DIR/Aptos-Bold.ttf" "https://raw.githubusercontent.com/kkzzoll/aptos-font/main/Aptos-Bold.ttf" || true
sudo wget -q -O "$FONT_DIR/Aptos-Italic.ttf" "https://raw.githubusercontent.com/kkzzoll/aptos-font/main/Aptos-Italic.ttf" || true
sudo wget -q -O "$FONT_DIR/Aptos-BoldItalic.ttf" "https://raw.githubusercontent.com/kkzzoll/aptos-font/main/Aptos-BoldItalic.ttf" || true

# Nastavení práv čtení pro všechny uživatele
sudo chmod 644 "$FONT_DIR"/*
sudo chmod 755 "$FONT_DIR"

# Obnovení keše fontů
echo "Obnovuji paměť systémových fontů..."
sudo fc-cache -f -v > /dev/null

# 4. Vynucení češtiny pro zástupce v menu ChromeOS
echo "[4/4] Nastavuji české spouštění v menu ChromeOS..."
DESKTOP_FILES=$(ls /usr/share/applications/libreoffice-*.desktop 2>/dev/null || true)

if [ -n "$DESKTOP_FILES" ]; then
    for f in $DESKTOP_FILES; do
        sudo sed -i 's|^Exec=|Exec=env LANG=cs_CZ.UTF-8 |g' "$f"
    done
fi

echo "=================================================="
echo " HOTOVO! Restartujte LibreOffice a zkontrolujte výsledky."
echo "=================================================="
