#!/bin/bash
# Rafael da Silva Lima 
#Script de busca de músicas

function barra() {
   tail -f $0 | yad --progress --title='Procurando...' --progress-text="buscando... $VALOR" --no-buttons --auto-close --undecorated
}
    
function _buscar() {
   VALOR=$( \
      yad --entry --title='Buscar músicas' --on-top --center \
         --entry-label="Buscar músicas sobre:" --entry-text="Digite aqui"  \
         --ricon="gtk-clear" --ricon-action="echo " \
         --button='Cancelar':1 --button='Buscar':0
      )
 
   [ -z "$VALOR" ] && _main
    
   echo -n > "$LISTA"
   barra & find -L "$HOME"/Music "$HOME"/Musicas "$HOME"/Músicas -iname /Arquivos/Musicas "*${VALOR}*.mp3" -exec echo "{}" >> "$LISTA" \; 2>/dev/null
    
   mv "$LISTA" "/Arquivos/Musicas/Variadas/lista.txt"
   echo -n > "$LISTA"
    
   while read MUSICA
   do
      echo "$MUSICA : \"${MUSICA##/*/}\"" >> "$LISTA"
   done < "/Arquivos/Musicas/Variadas/lista.txt"
 
   killall tail
   _main
}
 
function _tocar() {
   MUSICA=$(cat "$LISTA" | grep "$1" | cut -d: -f1)
   mplayer $MUSICA
}
 
function _main() {
   if [ ! -f "$LISTA" ]; then
      export LISTA='/tmp/lista_musicas.list'
      _buscar
   fi
 
   if yad --form --title='Player Musicas Shell Yad' --columns=3 --center \
   --field='Musica':CB "$(cat $LISTA | cut -d':' -f2 | tr '\n' '!' )" \
   --field='Tocar':BTN "./music_play.sh tocar %1" --field='Parar':BTN "killall -9 mplayer" --button='Fechar':1 --button='Buscar outro':0
   then
      _buscar
   fi
   killall mplayer
   exit
}
 
case "$1" in
'buscar') shift; _buscar $* ;;
'tocar') shift; _tocar $* ;;
*) _main ;;
esac
