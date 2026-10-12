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
