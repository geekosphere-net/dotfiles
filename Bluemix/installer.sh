# install the CLI

BX_DIR=$(mktemp -d)
cd $BX_DIR
wget -qO bx.tar.gz https://clis.ng.bluemix.net/download/bluemix-cli/latest/linux64
tar -xvf bx.tar.gz
sudo sh -c */install_bluemix_cli
cd
rm -rf $BX_DIR
unset BX_DIR

bx plugin install container-registry -r Bluemix
bx plugin install container-service -r Bluemix

