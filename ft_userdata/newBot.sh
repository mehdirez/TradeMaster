#!/bin/bash
# sudo touch MySecretKey.key
# #Copy private key content 
# echo "" | sudo tee MySecretKey.key -a  > /dev/null

# sudo chmod 400 MySecretKey.key
# ssh-agent bash -c 'ssh-add MySecretKey.key'

# # clone the repository
# echo "cloning repository..."
# sudo apt install git -y
# ssh-agent bash -c 'ssh-add MySecretKey.key; git@github.com:mehdirez/TradeMaster.git' -yes

# git clone git@github.com:mehdirez/TradeMaster.git

# installing docker latest
sudo apt update
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable" -y
apt-cache policy docker-ce -y
sudo apt install docker-ce -y
# sudo systemctl status docker
# installing docker compose
# https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-compose-on-ubuntu-20-04
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version
git clone https://github.com/mehdirez/TradeMaster.git
cd TradeMaster/
cd ft_userdata/
sudo docker-compose pull
# remove past trade data
rm user_data/tradesv3.sqlite
# download data for backtesting
sudo docker-compose run --rm freqtrade download-data --exchange binance -t 15m 1h #--timerange=20230101-

# optinal backtesting command
# docker-compose run freqtrade backtesting --datadir user_data/data/binance --export trades  --stake-amount 1000 -s SwingHighToSky -i 15m --timerange=20210728-

# Run Optimization
# sudo docker-compose run --rm freqtrade hyperopt --enable-protections --strategy SwingHighToSky --hyperopt-loss SharpeHyperOptLoss -i 15m -e 5000 --timerange=20230101-

# git add .
# git commit -m "Hyperopt new updatte"
# git pull origin main
# git push origin branch-name #we need ssh key for pushing
# sudo docker-compose up -d
# sudo docker-compose logs -f



# how to copy my private key to ec2 instance from my local machine
# scp -i AmazonKeyPair.pem  .ssh/MySecretKey ubuntu@ec2-3-26-161-56.ap-southeast-2.compute.amazonaws.com:~/


# "ADA/USDT",
#             "MATIC/USDT",
#             "COTI/USDT",
#             "ALGO/USDT",
#             "SOL/USDT",
#             "DOT/USDT",
#             "FIL/USDT"