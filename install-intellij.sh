#!/bin/bash

# Definir a versão
LATEST_VERSION="${1:-2024.3.2.2}"

# URL do download
BASE_URL="https://download-cdn.jetbrains.com/idea/"
DOWNLOAD_URL="${BASE_URL}ideaIU-${LATEST_VERSION}.tar.gz"

# Criar diretório temporário e baixar o IntelliJ IDEA
TMP_DIR="/tmp/intellij_install"
mkdir -p "$TMP_DIR"
cd "$TMP_DIR" || exit 1
curl -L -o "ideaIU.tar.gz" "$DOWNLOAD_URL" || exit 1

# Extrair e mover para /opt
tar -xvzf "ideaIU.tar.gz"
mv idea-IU-* /opt/intellij-idea

# Criar link simbólico
ln -sf /opt/intellij-idea/bin/idea.sh /usr/local/bin/idea
chmod +x /usr/local/bin/idea

# Criar atalho no menu
cat > /usr/share/applications/intellij-idea.desktop <<EOF
[Desktop Entry]
Name=IntelliJ IDEA
Comment=Edição Comunitária do IntelliJ IDEA
Exec=/opt/intellij-idea/bin/idea.sh %f
Icon=/opt/intellij-idea/bin/idea.png
Terminal=false
Type=Application
Categories=Desenvolvimento;IDE;
StartupWMClass=jetbrains-idea
EOF

# Atualizar banco de dados do menu
update-desktop-database

# Limpar arquivos temporários
rm -rf "$TMP_DIR"
