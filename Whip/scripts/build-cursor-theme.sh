
#!/usr/bin/env bash

set -euo pipefail

# Diretórios
ROOT="$(pwd)"
THEME="$ROOT/Whip/cursor-theme"
BUILD="$THEME/build/Whip"
ARCHIVE="$THEME/build/Whip.tar.gz"

# Verificar se estamos na raiz do projeto
if [ ! -d "$THEME" ]; then
    echo "Erro: execute este script na raiz do projeto."
    exit 1
fi

# Verificar dependência
if ! command -v xcursorgen >/dev/null 2>&1; then
    echo "Erro: xcursorgen não encontrado."
    echo "Instale com: sudo pacman -S xorg-xcursorgen"
    exit 1
fi

# Verificar dependência de compactação
if ! command -v tar >/dev/null 2>&1; then
    echo "Erro: tar não encontrado."
    exit 1
fi

echo "==> Preparando diretórios..."

rm -rf "$BUILD"
mkdir -p "$BUILD/cursors"

echo "==> Copiando cursores Breeze..."

cp -a "$THEME/assets/source/Breeze/cursors/." "$BUILD/cursors/"

echo "==> Copiando index.theme do projeto..."

cp "$THEME/index.theme" "$BUILD/index.theme"

echo "==> Compilando cursores personalizados..."

cd "$THEME/configs"

xcursorgen default.cfg "$BUILD/cursors/default"
xcursorgen click.cfg "$BUILD/cursors/click"

echo "==> Configurando aliases do cursor principal..."

ln -sfn default "$BUILD/cursors/arrow"
ln -sfn default "$BUILD/cursors/left_ptr"

echo "==> Verificando arquivos gerados..."

file "$BUILD/cursors/default"
file "$BUILD/cursors/click"

echo "==> Compactando tema..."

tar -czf "$ARCHIVE" \
    -C "$THEME/build" \
    Whip

echo "==> Verificando arquivo compactado..."

ls -lh "$ARCHIVE"

echo "==> Compilação concluída!"
echo "Tema gerado em: $BUILD"
echo "Arquivo compactado em: $ARCHIVE"
