# 🐰 Instalador do OpenJazz

---

## ⚠️ Aviso Legal
Este script **NÃO distribui** o jogo **Jazz Jackrabbit** (1994) e **Jazz Jackrabbit: Holiday Hare 95**.
Você precisa possuir uma cópia legal do jogo (Steam, GOG ou CD original).
O script apenas instala e compila o **OpenJazz**, e cria atalhos no menu de aplicativos 

## ✅ Por que este script é legal?
- **OpenJazz**: GPL (código aberto)
- Não distribui arquivos proprietários
- Requer posse legal do jogo original

---

## 📋 O que este script faz?

Este script automatiza a instalação completa do **OpenJazz** no seu sistema Linux, realizando as seguintes tarefas:

1. ✅ Verifica e instala todas as dependências necessárias
2. ✅ Clona o repositório oficial do OpenJazz do GitHub
3. ✅ Compila o código-fonte
4. ✅ Instala o OpenJazz em `~/Games/openjazz`
5. ✅ Baixa o ícone do jogo
6. ✅ Cria scripts de execução para ambas as versões do jogo
7. ✅ Cria atalhos no menu de aplicações do sistema

---

## 🎮 O que é OpenJazz?

**OpenJazz** é um motor de jogo (game engine) livre e de código aberto que permite jogar o clássico **Jazz Jackrabbit** (1994) e **Jazz Jackrabbit: Holiday Hare 95** em sistemas operacionais modernos, incluindo Linux.

O OpenJazz é apenas o **motor do jogo** - ele **NÃO inclui** os arquivos originais do jogo (níveis, gráficos, músicas, etc).

---

## ⚠️ IMPORTANTE: Você precisa dos arquivos do jogo original!

### 📁 Onde os arquivos devem ficar?

Para que os atalhos funcionem corretamente, os arquivos do jogo **DEVEM** estar localizados em:

- **Jazz Jackrabbit**: `/usr/share/games/jazz-jackrabbit/`
- **Jazz Jackrabbit Holiday Hare 95**: `/usr/share/games/jazz-jackrabbit-hh95/`

### 🚨 Se os arquivos não estiverem nas pastas corretas, os atalhos NÃO funcionarão!

---

## 📦 Como obter os arquivos do jogo?

### **Opção 1: Usando arquivos DEB (Recomendado)**

Se você já tem os pacotes `.deb` criados com `game-data-packager`, basta instalá-los:

```bash
sudo dpkg -i jazz-jackrabbit-data_*.deb
sudo dpkg -i jazz-jackrabbit-hh95-data_*.deb
```

Os arquivos serão automaticamente instalados nos diretórios corretos:
- `/usr/share/games/jazz-jackrabbit/`
- `/usr/share/games/jazz-jackrabbit-hh95/`

---

### **Opção 2: Criar pacotes DEB com game-data-packager**

Se você tem os arquivos originais do jogo (`.exe`, CD-ROM, ou arquivos extraídos), pode criar pacotes DEB:

#### 1. Instalar o game-data-packager:
```bash
sudo apt install game-data-packager
```

#### 2. Criar o pacote DEB:

**Para Jazz Jackrabbit:**
```bash
game-data-packager jazz-jackrabbit --package jazzjackrabbit.exe
```

**Para Jazz Jackrabbit Holiday Hare 95:**
```bash
game-data-packager jazz-jackrabbit-hh95 --package hh95.exe
```

Ou, se você tem os arquivos já extraídos em uma pasta:
```bash
game-data-packager jazz-jackrabbit -d /caminho/para/pasta/do/jogo
```

#### 3. Instalar os pacotes criados:
```bash
sudo dpkg -i jazz-jackrabbit-data_*.deb
sudo dpkg -i jazz-jackrabbit-hh95-data_*.deb
```

---

### **Opção 3: Copiar manualmente os arquivos**

Se você já tem os arquivos do jogo, pode copiá-los manualmente:

#### 1. Criar os diretórios:
```bash
sudo mkdir -p /usr/share/games/jazz-jackrabbit
sudo mkdir -p /usr/share/games/jazz-jackrabbit-hh95
```

#### 2. Copiar os arquivos:
```bash
# Para Jazz Jackrabbit
sudo cp -r /caminho/dos/arquivos/originais/* /usr/share/games/jazz-jackrabbit/

# Para Holiday Hare 95
sudo cp -r /caminho/dos/arquivos/hh95/* /usr/share/games/jazz-jackrabbit-hh95/
```

#### 3. Ajustar permissões:
```bash
sudo chmod -R 755 /usr/share/games/jazz-jackrabbit
sudo chmod -R 755 /usr/share/games/jazz-jackrabbit-hh95
```

---

## 🚀 Como usar o instalador

### 1. Baixe o script:
```bash
wget https://seu-link/install_openjazz.sh
# ou copie o conteúdo do script para um arquivo
```

### 2. Dê permissão de execução:
```bash
chmod +x install_openjazz.sh
```

### 3. Execute o instalador:
```bash
./install_openjazz.sh
```

### 4. Aguarde a instalação completar

O script irá:
- Instalar dependências (solicitará sua senha para sudo)
- Clonar e compilar o OpenJazz
- Configurar tudo automaticamente

---

## 🎯 Depois da instalação

### ✅ Se você JÁ tem os arquivos do jogo instalados corretamente:

Os atalhos aparecerão no menu de jogos:
- **Jazz Jackrabbit**
- **Jazz Jackrabbit Holiday Hare 95**

### ⚠️ Se você ainda NÃO tem os arquivos do jogo:

1. Obtenha os arquivos do jogo original (você deve possuir uma cópia legítima)
2. Use uma das opções acima para instalar os arquivos em:
   - `/usr/share/games/jazz-jackrabbit/`
   - `/usr/share/games/jazz-jackrabbit-hh95/`
3. Os atalhos começarão a funcionar automaticamente

---

## 📝 Arquivos necessários do jogo

### Jazz Jackrabbit precisa de:
- `LEVEL0.000` até `LEVEL6.000`
- `BLOCKS.000`
- `SOUNDS.000`
- `PANEL.000`
- E outros arquivos `.000`

### Jazz Jackrabbit Holiday Hare 95 precisa de:
- Arquivos similares, mas da versão HH95

---

## 🔧 Resolução de problemas

### Os atalhos não aparecem no menu?
```bash
update-desktop-database ~/.local/share/applications
```

### O jogo não inicia?
Verifique se os arquivos estão nos diretórios corretos:
```bash
ls -la /usr/share/games/jazz-jackrabbit/
ls -la /usr/share/games/jazz-jackrabbit-hh95/
```

### Erro de permissão?
```bash
sudo chmod -R 755 /usr/share/games/jazz-jackrabbit
sudo chmod -R 755 /usr/share/games/jazz-jackrabbit-hh95
```

---

## 📚 Links úteis

- **OpenJazz GitHub**: https://github.com/AlisterT/openjazz
- **Game Data Packager**: https://wiki.debian.org/Games/GameDataPackager
- **Jazz Jackrabbit (Wikipedia)**: https://pt.wikipedia.org/wiki/Jazz_Jackrabbit

---

## ⚖️ Nota Legal

Este script instala apenas o motor de jogo OpenJazz (software livre). Os arquivos do jogo original Jazz Jackrabbit são propriedade da Epic Games. Você deve possuir uma cópia legítima do jogo para usar seus arquivos.

---

## 🐧 Compatibilidade

Testado em:
- Ubuntu 20.04+
- Debian 11+
- Linux Mint 20+
- Pop!_OS 20.04+

Outras distribuições baseadas em Debian/Ubuntu devem funcionar normalmente.

---

**Divirta-se jogando Jazz Jackrabbit! 🐰🎮**
