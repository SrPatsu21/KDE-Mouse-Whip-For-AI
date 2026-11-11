
#!/usr/bin/env bash

set -e

PROJECT="Whip"

echo "Criando estrutura do projeto ${PROJECT}..."

mkdir -p "$PROJECT"/cursor-theme/{cursors,assets/{source,png/32x32,animations/click},configs,build}

mkdir -p "$PROJECT"/click-effect/{src,assets/sprites,config,build}

mkdir -p "$PROJECT"/scripts

mkdir -p "$PROJECT"/docs

# Arquivo principal do tema
cat > "$PROJECT/cursor-theme/index.theme" <<'EOF'
[Icon Theme]
Name=Whip
Comment=Minimalist Pixel Art Whip Cursor Theme
Inherits=breeze_cursors
EOF

# Créditos dos assets
cat > "$PROJECT/docs/ASSET-CREDITS.md" <<'EOF'
# Asset Credits

Document all third-party assets used in this project.

For each asset, record:
- Original author
- Original source URL
- License
- Modifications made
EOF

# Git ignore
cat > "$PROJECT/.gitignore" <<'EOF'
# Build output
**/build/*

# Temporary files
*.tmp
*.bak
*.log

# Editor files
.vscode/
.idea/
EOF

# README inicial
cat > "$PROJECT/README.md" <<'EOF'
# Whip

Minimalist Pixel Art cursor theme for KDE Plasma 6.

## Features

- 32x32 pixel art assets
- Animated whip cursor
- Fast and aggressive click animation
- KDE Plasma 6 compatibility

## Components

- cursor-theme: XCursor theme
- click-effect: Click animation component

## Status

Work in progress.
EOF

echo ""
echo "Estrutura criada com sucesso!"
echo "Projeto: $PROJECT"
echo ""
tree "$PROJECT" 2>/dev/null || find "$PROJECT" -print
