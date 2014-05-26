#!/bin/bash
# Criar/Testar um arquivo .desktop
DADOS=$(yad --form --field='Nome':TEXT '' --field='Dica':TEXT '' \
--field='Icone':FL '/usr/share/icons/' --field='Arquivo executável':FL '/usr/bin/' \
--field='Executa em terminal':CB "SIM!NÃO")
NOME=$(echo "$DADOS" | cut -d'|' -f1)
DICA=$(echo "$DADOS" | cut -d'|' -f2)
ICONE=$(echo "$DADOS" | cut -d'|' -f3)
COMANDO=$(echo "$DADOS" | cut -d'|' -f4)
TERMINAL=$(echo "$DADOS" | cut -d'|' -f5)
if [ -z "$NOME" -o -z "$COMANDO" -o ! -x "$COMANDO" ]; then
yad --title='Aviso' --text='Nome ou Arquivo executável não preenchidos corretamente!' --timeout=3 --no-buttons
exit
fi
[ "$TERMINAL" == 'SIM' ] && TERMINAL='true' || TERMINAL='false'
echo '[Desktop Entry]' > "${NOME// /_}".desktop
echo "Name=${NOME-:null}" >> "${NOME// /_}".desktop
echo "Comment=${DICA-:null}" >> "${NOME// /_}".desktop
echo "Icon=${ICONE-:null}" >> "${NOME// /_}".desktop
echo "Exec=${COMANDO-:null}" >> "${NOME// /_}".desktop
echo "Terminal=${TERMINAL-:false}" >> "${NOME// /_}".desktop
echo "Type=Application" >> "${NOME// /_}".desktop
echo "${NOME-:null}" > /tmp/teste.desktop
echo "${DICA-:null}" >> /tmp/teste.desktop
echo "${ICONE-:null}" >> /tmp/teste.desktop
echo "${COMANDO-:null}" >> /tmp/teste.desktop
echo "${TERMINAL-:null}" >> /tmp/teste.desktop
cat /tmp/teste.desktop | yad --icons --stdin
chmod +x "${NOME// /_}".desktop
