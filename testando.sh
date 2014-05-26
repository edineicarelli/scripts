#!/bin/bash


echo -n > "$LISTA"
find -L "$HOME"/Music "$HOME"/Musicas "$HOME"/Músicas -iname /Arquivos/Musicas "*${VALOR}*.mp3" -exec echo "{}" >> "$LISTA" \; 2>/dev/null
mv "$LISTA" "&HOME"/scripts/lista.txt
echo -n > "$LISTA"
