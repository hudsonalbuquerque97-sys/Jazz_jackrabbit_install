#!/bin/bash

# Script de instalação do OpenJazz (sem download de dados do jogo)
# Autor: Assistente Claude
# Data: 2025

set -e

echo "=================================="
echo "Instalador do OpenJazz"
echo "=================================="
echo ""

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Função para mensagens
print_status() {
    echo -e "${GREEN}[✓]${NC} $1"
}

print_error() {
    echo -e "${RED}[✗]${NC} $1"
}

print_info() {
    echo -e "${YELLOW}[i]${NC} $1"
}

# Verificar dependências
print_info "Verificando dependências..."
MISSING_DEPS=""

# Verificar ferramentas básicas
for dep in git make g++; do
    if ! command -v $dep &> /dev/null; then
        MISSING_DEPS="$MISSING_DEPS build-essential"
        break
    fi
done

# Verificar bibliotecas SDL (tenta SDL2 primeiro, depois SDL1.2)
SDL_INSTALLED=false
if dpkg -l | grep -q "^ii.*libsdl2-dev"; then
    SDL_INSTALLED=true
    print_status "SDL2 detectado"
elif dpkg -l | grep -q "^ii.*libsdl1.2-dev"; then
    SDL_INSTALLED=true
    print_status "SDL1.2 detectado"
else
    MISSING_DEPS="$MISSING_DEPS libsdl1.2-dev"
fi

# Verificar outras bibliotecas
for lib in libmodplug-dev libvorbis-dev; do
    if ! dpkg -l | grep -q "^ii.*$lib"; then
        MISSING_DEPS="$MISSING_DEPS $lib"
    fi
done

if [ ! -z "$MISSING_DEPS" ]; then
    print_error "Dependências faltando:$MISSING_DEPS"
    print_info "Instalando dependências..."
    sudo apt-get update
    sudo apt-get install -y build-essential libsdl1.2-dev libmodplug-dev libvorbis-dev
fi

print_status "Dependências verificadas"

# Criar diretório de jogos se não existir
GAMES_DIR="$HOME/Games"
if [ ! -d "$GAMES_DIR" ]; then
    mkdir -p "$GAMES_DIR"
    print_status "Diretório $GAMES_DIR criado"
fi

# Clonar repositório
print_info "Clonando repositório do OpenJazz..."
TEMP_DIR="/tmp/openjazz_build"
rm -rf "$TEMP_DIR"
git clone https://github.com/AlisterT/openjazz "$TEMP_DIR"
cd "$TEMP_DIR"
print_status "Repositório clonado"

# Compilar
print_info "Compilando OpenJazz..."
make
print_status "Compilação concluída"

# Mover para diretório de jogos
OPENJAZZ_DIR="$GAMES_DIR/openjazz"
if [ -d "$OPENJAZZ_DIR" ]; then
    print_info "Removendo instalação anterior..."
    rm -rf "$OPENJAZZ_DIR"
fi

mv "$TEMP_DIR" "$OPENJAZZ_DIR"
print_status "OpenJazz instalado em $OPENJAZZ_DIR"

# Baixar ícone
print_info "Baixando ícone..."
cd "$OPENJAZZ_DIR"
wget -O jazz_jackrabbit_icon.png "https://raw.githubusercontent.com/AlisterT/openjazz/master/icons/openjazz.png" 2>/dev/null || \
wget -O jazz_jackrabbit_icon.png "https://www.jazz2online.com/images/jazz1icon.png" 2>/dev/null || \
print_error "Não foi possível baixar o ícone. Você pode adicionar manualmente depois."

if [ -f "jazz_jackrabbit_icon.png" ]; then
    print_status "Ícone baixado"
fi

# Criar script run_jazz.sh com verificação
print_info "Criando scripts de execução..."
cat > "$OPENJAZZ_DIR/run_jazz.sh" << 'EOF'
#!/bin/bash

# Diretórios
OPENJAZZ_DIR="$HOME/Games/openjazz"
JAZZ_DATA="/usr/share/games/jazz-jackrabbit"

# Verificar se os dados do jogo existem
if [ ! -d "$JAZZ_DATA" ] || [ ! -f "$JAZZ_DATA/LEVEL0.000" ]; then
    if command -v zenity &> /dev/null; then
        zenity --error --width=400 --title="Jazz Jackrabbit - Erro" \
        --text="<b>Arquivos do jogo não encontrados!</b>\n\nOs arquivos do Jazz Jackrabbit devem estar em:\n<tt>$JAZZ_DATA</tt>\n\nInstale o pacote jazz-jackrabbit-data ou copie os arquivos manualmente." 2>/dev/null
    else
        echo "ERRO: Arquivos do jogo não encontrados em $JAZZ_DATA"
        echo ""
        echo "Você precisa instalar os dados do jogo:"
        echo "  1. Instale o pacote: sudo apt install jazz-jackrabbit-data"
        echo "  2. Ou copie os arquivos manualmente para: $JAZZ_DATA"
        echo ""
        read -p "Pressione ENTER para fechar..."
    fi
    exit 1
fi

# Executar o jogo
cd "$OPENJAZZ_DIR"
./OpenJazz "$JAZZ_DATA"
EOF

chmod +x "$OPENJAZZ_DIR/run_jazz.sh"
print_status "Script run_jazz.sh criado"

# Criar script run_jazz_hh95.sh com verificação
cat > "$OPENJAZZ_DIR/run_jazz_hh95.sh" << 'EOF'
#!/bin/bash

# Diretórios
OPENJAZZ_DIR="$HOME/Games/openjazz"
HH95_DATA="/usr/share/games/jazz-jackrabbit-hh95"

# Verificar se os dados do jogo existem
if [ ! -d "$HH95_DATA" ] || [ ! -f "$HH95_DATA/LEVEL0.050" ]; then
    if command -v zenity &> /dev/null; then
        zenity --error --width=400 --title="Jazz Jackrabbit HH95 - Erro" \
        --text="<b>Arquivos do jogo não encontrados!</b>\n\nOs arquivos do Holiday Hare 95 devem estar em:\n<tt>$HH95_DATA</tt>\n\nInstale o pacote jazz-jackrabbit-hh95-data ou copie os arquivos manualmente." 2>/dev/null
    else
        echo "ERRO: Arquivos do jogo não encontrados em $HH95_DATA"
        echo ""
        echo "Você precisa instalar os dados do jogo:"
        echo "  1. Instale o pacote: sudo apt install jazz-jackrabbit-hh95-data"
        echo "  2. Ou copie os arquivos manualmente para: $HH95_DATA"
        echo ""
        read -p "Pressione ENTER para fechar..."
    fi
    exit 1
fi

# Executar o jogo
cd "$OPENJAZZ_DIR"
./OpenJazz "$HH95_DATA"
EOF

chmod +x "$OPENJAZZ_DIR/run_jazz_hh95.sh"
print_status "Script run_jazz_hh95.sh criado"

# Criar diretório de aplicações se não existir
APPS_DIR="$HOME/.local/share/applications"
mkdir -p "$APPS_DIR"

# Criar atalho Jazz Jackrabbit
print_info "Criando atalhos..."
cat > "$APPS_DIR/jazz-jackrabbit.desktop" << EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=Jazz Jackrabbit
Comment=Jazz Jackrabbit - OpenJazz
Icon=$HOME/Games/openjazz/jazz_jackrabbit_icon.png
Exec=$HOME/Games/openjazz/run_jazz.sh
Path=$HOME/Games/openjazz
Terminal=false
Categories=Games;ActionGame;
Keywords=game;sidescrolling;jazz;
EOF

chmod +x "$APPS_DIR/jazz-jackrabbit.desktop"
print_status "Atalho Jazz Jackrabbit criado"

# Criar atalho Jazz Jackrabbit HH95
cat > "$APPS_DIR/jazz-jackrabbit-hh95.desktop" << EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=Jazz Jackrabbit Holiday Hare 95
Comment=Jazz Jackrabbit Holiday Hare 95 - OpenJazz
Icon=$HOME/Games/openjazz/jazz_jackrabbit_icon.png
Exec=$HOME/Games/openjazz/run_jazz_hh95.sh
Path=$HOME/Games/openjazz
Terminal=false
Categories=Games;ActionGame;
Keywords=game;sidescrolling;jazz;christmas;
EOF

chmod +x "$APPS_DIR/jazz-jackrabbit-hh95.desktop"
print_status "Atalho Jazz Jackrabbit HH95 criado"

# Atualizar banco de dados de aplicações
if command -v update-desktop-database &> /dev/null; then
    update-desktop-database "$APPS_DIR"
fi

echo ""
echo "=================================="
print_status "Instalação concluída com sucesso!"
echo "=================================="
echo ""
print_info "IMPORTANTE: Você precisa instalar os dados do jogo:"
echo ""
echo "Opção 1 - Se voçê possui os pacotes DEB do game data package do jogo:"
echo "  sudo apt install jazz-jackrabbit-data_65_all.deb jazz-jackrabbit-hh95-data_65_all.deb"
echo ""
echo "Opção 2 - Se voce possuir os arquivos do jogo copier manualmente:"
echo "  sudo mkdir -p /usr/share/games/jazz-jackrabbit"
echo "  sudo mkdir -p /usr/share/games/jazz-jackrabbit-hh95"
echo "  sudo cp -r /caminho/dos/arquivos/* /usr/share/games/jazz-jackrabbit/"
echo ""
print_info "Os atalhos foram criados no menu de aplicações."
echo "Após instalar os dados do jogo, procure por 'Jazz Jackrabbit' no menu."
echo ""
