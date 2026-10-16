#!/bin/bash

# ==============================================================================
# Instalační skript pro výukové Linux aplikace na ChromeOS / ChromeOS Flex
# ==============================================================================

export DEBIAN_FRONTEND=noninteractive

echo "=================================================="
echo " 1. Aktualizace repozitářů APT"
echo "=================================================="
sudo apt-get update -y

echo "=================================================="
echo " 2. Instalace aplikací"
echo "=================================================="

echo "--> Instalace GIMP (vč. češtiny)..."
sudo apt-get install -y gimp gimp-l10n || echo "Chyba při instalaci GIMP"

echo "--> Instalace Inkscape..."
sudo apt-get install -y inkscape || echo "Chyba při instalaci Inkscape"

echo "--> Instalace VLC..."
sudo apt-get install -y vlc || echo "Chyba při instalaci VLC"

echo "--> Instalace BASIC256..."
sudo apt-get install -y basic256 || echo "Chyba při instalaci BASIC256"

echo "--> Instalace LibreOffice a češtiny..."
sudo apt-get install -y libreoffice libreoffice-l10n-cs || echo "Chyba při instalaci LibreOffice"

echo "--> Pokus o instalaci ikonek Yaru pro LibreOffice..."
sudo apt-get install -y libreoffice-style-yaru || \
sudo apt-get install -y libreoffice-style-colibre || \
echo "Ikonková sada Yaru není v repozitáři k dispozici, použije se výchozí vzhled."

echo "=================================================="
echo " 3. Úklid dočasných souborů"
echo "=================================================="
sudo apt-get autoremove -y
sudo apt-get clean

echo "=================================================="
echo " HOTOVO! Zkontrolujte výpis výše."
echo "=================================================="
