#!/bin/bash

# ==============================================================================
# Instalační skript pro výukové Linux aplikace na ChromeOS / ChromeOS Flex
# Aplikace: GIMP, Inkscape, VLC, BASIC256, LibreOffice (CZ)
# ==============================================================================

export DEBIAN_FRONTEND=noninteractive

echo "=================================================="
echo " 1. Aktualizace repozitářů APT"
echo "=================================================="
sudo apt-get update -y

echo "=================================================="
echo " 2. Instalace aplikací"
echo "=================================================="

echo "--> Instalace GIMP..."
sudo apt-get install -y gimp

echo "--> Instalace Inkscape..."
sudo apt-get install -y inkscape

echo "--> Instalace VLC..."
sudo apt-get install -y vlc

echo "--> Instalace BASIC256..."
sudo apt-get install -y basic256

echo "--> Instalace LibreOffice a české lokalizace..."
sudo apt-get install -y libreoffice libreoffice-l10n-cs

echo "=================================================="
echo " 3. Úklid dočasných souborů"
echo "=================================================="
sudo apt-get autoremove -y
sudo apt-get clean

echo "=================================================="
echo " VŠECHNY APLIKACE BYLY ÚSPĚŠNĚ NAINSTALOVÁNY!"
echo " Najdete je v nabídce ChromeOS -> Aplikace Linuxu."
echo "=================================================="
