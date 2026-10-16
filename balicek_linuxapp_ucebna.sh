#!/bin/bash

# ==============================================================================
# Instalační skript pro výukové Linux aplikace na ChromeOS / ChromeOS Flex
# ==============================================================================

# Potlačení grafických dotazů při instalaci
export DEBIAN_FRONTEND=noninteractive

echo "=================================================="
echo " Zahajuji instalaci výukových aplikací..."
echo "=================================================="

# 1. Aktualizace seznamu balíčků
echo "[1/3] Aktualizuji repozitáře APT..."
sudo apt-get update -y

# 2. Instalace aplikací
echo "[2/3] Instaluji aplikace a české lokalizace..."
sudo apt-get install -y \
  gimp \
  gimp-l10n \
  inkscape \
  vlc \
  libreoffice \
  libreoffice-l10n-cs \
  libreoffice-style-yaru-icon-theme \
  basic256 || \
sudo apt-get install -y \
  gimp \
  gimp-l10n \
  inkscape \
  vlc \
  libreoffice \
  libreoffice-l10n-cs \
  basic256

# 3. Úklid dočasných souborů
echo "[3/3] Provádím úklid balíčkovacího systému..."
sudo apt-get autoremove -y
sudo apt-get clean

echo "=================================================="
echo " INSTALACE DOKONČENA!"
echo " Aplikace najdete v nabídce ChromeOS -> Aplikace Linuxu."
echo "=================================================="
