#!/bin/bash
#Rafael da Silva Lima - rafael.liverpool@gmail.com
#Configuração ambiente de desenvolvimento - KMEE

echo "Este script irá instalar os pacotes auxiliares para configuração do ambiente de desenvolvimento - OpenERP - KMEE"


#Variáveis de Configuração

#Diretório do OpenERP
APP_PATH='7.0-rs-ocb'
ROOT_PATH='/opt/openerp'
FULL_PATH='$ROOT_PATH/$APP_PATH'

#Caminhos Addons
ADDONS_PATH='../web/addons,../addons,../account-payment/,../l10n_br_account_payment_extension/,	
				../l10n_br_core/,../openerp-fiscal-rules/,../server-env-tools/,../web-addons/,
				../webkit-utils/,../sale-reports/,../openerp-product-attributes/,../openerp-product-variant/,
				../openerp.pt-br-localiz/,../nfe/,../kmee_addons/,../kmee_nfe/,../kmee_reports/,
				../brazilian-localization-data/,../banking-addons/,../aeroo/,../web/,../account-invoicing/,
				../account-financial-report/'


#Pacotes Auxiliares
sudo apt-get install gcc python-dev mc bzr python-setuptools python-babel \
python-feedparser python-reportlab-accel python-zsi python-openssl \
python-egenix-mxdatetime python-jinja2 python-unittest2 python-mock \
python-docutils lptools make python-psutil python-paramiko poppler-utils \
python-pdftools antiword git python-software-properties 

#Instalando java
sudo add-apt-repository ppa:webupd8team/java -y
sudo apt-get update && sudo apt-get install oracle-jdk7-installer -y


#PostgreSQL

sudo add-apt-repository -y ppa:pitti/postgresql 
sudo apt-get update
sudo apt-get -y install postgresql-9.2 postgresql-client-9.2 postgresql-contrib-9.2 postgresql-server-dev-9.2 libpq-dev
 

#Após logar com o usuário postgres , necessita inserir uma senha que deverá ser pré-determinada
#E também sair do usuário postgres para processeguir o script
#Pode ser solucionado com: http://www.cyberciti.biz/tips/howto-write-shell-script-to-add-user.html

sudo su - postgres -c "createuser --createdb --username postgres --no-createrole --no-superuser --pwprompt openerp"
echo "Nome de usuário do banco de dados criado como openerp"
sudo apt-get install pgadmin3

#Pacores necessarios para rodar o openerp
sudo apt-get install graphviz ghostscript postgresql-client \
python-dateutil python-feedparser python-matplotlib \
python-ldap python-libxslt1 python-lxml python-mako \
python-openid python-psycopg2 python-pybabel python-pychart \
python-pydot python-pyparsing python-reportlab python-simplejson \
python-tz python-vatnumber python-vobject python-webdav \
python-werkzeug python-xlwt python-yaml python-imaging python-pip

cd /tmp && wget https://gdata-python-client.googlecode.com/files/gdata-2.0.18.tar.gz
tar zxvf gdata-2.0.18.tar.gz
cd gdata-2.0.18/ && sudo python setup.py install
sudo pip install BeautifulSoup
sudo pip install unidecode

#LibreOffice
sudo add-apt-repository ppa:libreoffice/ppa -y
sudo apt-get update
sudo apt-get install libreoffice libreoffice-gnome
wget http://pypi.python.org/packages/source/u/ulif.openoffice/ulif.openoffice-0.4.tar.gz && tar -xvzf ulif.openoffice-0.4.tar.gz
cd ulif.openoffice-0.4 && python setup.py install

#Aerolibs
sudo mkdir /opt/lib/
sudo chown $USER.$USER /opt/lib/
cd /opt/lib/ && bzr branch lp:aeroolib
cd aeroolib/aeroolib && sudo python setup.py install 

#Bin
cd $ROOT_PATH && mkdir $APP_PATH
cd $APP_PATH && bzr branch lp:~ocb/ocb-addons/rs-ocb-70 addons
bzr branch lp:~ocb/ocb-server/rs-ocb-70 server
bzr branch lp:ocb-web web
git clone https://github.com/openerpbrasil-fiscal/l10n_br_core.git

#Links simbólicos
cd $FULL_PATH/addons/
ln -s ../account-payment/* .
ln -s ../br_data/* .
ln -s ../l10n_br_account_payment_extension/* .
ln -s ../l10n_br_core/* .
ln -s ../openerp-fiscal-rules/* .
ln -s ../server-env-tools/* .
ln -s ../variant/* .
ln -s ../webaddons/* .


#Criando arquivo de configuração do servidor
serverConfig=$'[options]
addons_path =$ADDONS_PATH
admin_passwd = admin
csv_internal_sep =
db_host = localhost
db_maxconn = 64
db_name = False
db_password = banes
db_port = 5432
db_template = template1
db_user = openerp
dbfilter = .*
debug_mode = False
demo = {}
email_from = False
import_partial =
workers = 5
limit_memory_soft = 671088640
limit_memory_hard = 805306368
limit_time_cpu = 300
limit_time_real = 120
limit_request = 8192
list_db = True
log_handler = ['[\'[\\\'["[\\\\\\\':INFO\\\\\\\']"]\\\']\']']
log_level = info
logfile = False
login_message = False
logrotate = True
max_cron_threads = 2
netrpc = False
netrpc_interface =
netrpc_port = 9070
osv_memory_age_limit = 1.0
osv_memory_count_limit = False
pg_path = None
pidfile = False
proxy_mode = False
reportgz = False
secure_cert_file = server.cert
secure_pkey_file = server.pkey
server_wide_modules = None
smtp_password = False
smtp_port = 25
smtp_server = localhost
smtp_ssl = False
smtp_user = False
static_http_document_root = None
static_http_enable = False
static_http_url_prefix = None
syslog = False
test_commit = False
test_enable = False
test_file = False
test_report_directory = False
timezone = False
translate_modules = ['all']
unaccent = False
without_demo = False
workers = 0
xmlrpc = True
xmlrpc_interface =
xmlrpc_port = 9069
xmlrpcs = True
xmlrpcs_interface =
xmlrpcs_port = 9071'

touch $FULL_PATH/server/openerp-server.conf

echo "$serverConfig" > $FULL_PATH/server/openerp-server.conf


sudo su - openerp -s /bin/bash 
echo "Fim da instalação , para executar o servidor: Execute: cd $FULL_PATH/server    
./openerp-server -c openerp-server.conf "
exit
