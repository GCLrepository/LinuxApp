#!/bin/bash

# ==============================================================================
# Instalační skript pro výukové Linux aplikace na ChromeOS / ChromeOS Flex
# Aplikace: GIMP, Inkscape, VLC, LibreOffice (CZ + Yaru), BASIC256
# ==============================================================================

set -e

# Upozornění na začátku
echo "=================================================="
echo " Zahajuji instalaci výukových aplikací..."
echo "=================================================="

# 1. Aktualizace seznamu balíčků
echo "[1/3] Aktualizuji repozitáře APT..."
sudo apt update -y

# 2. Instalace balíčků
echo "[2/3] Instaluji aplikace a české lokalizace..."
sudo apt install -y \
  gimp \
  gimp-l10n \
  inkscape \
  vlc \
  libreoffice \
  libreoffice-l10n-cs \
  libreoffice-style-yaru \
  basic256

# 3. Úklid dočasných souborů
echo "[3/3] Provádím úklid balíčkovacího systému..."
sudo apt autoremove -y
sudo apt clean

echo "=================================================="
echo " INSTALACE DOKONČENA!"
echo " Aplikace najdete v nabídce ChromeOS -> Aplikace Linuxu."
echo "=================================================="
