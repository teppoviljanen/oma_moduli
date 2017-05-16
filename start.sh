sudo apt-get update
sudo apt-get -y install git puppet
git clone https://github.com/teppoviljanen/oma_moduli.git
cd oma_moduli
sudo puppet apply --modulepath puppet/modules/ -e 'class {editor:}'
