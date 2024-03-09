#!/bin/bash
# sudo touch MySecretKey.key
# #Copy private key content 
# echo "-----BEGIN OPENSSH PRIVATE KEY-----
# b3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAABFwAAAAdzc2gtcn
# NhAAAAAwEAAQAAAQEAngPCRCS4p9lBjD8a832AAdzVCf2sVZis7krWdknzO95qfOR7P6uG
# bm8PHUPIxon9vZvKULDfhV0idvHSt8V71WMk7qtodfdOXdW7EjBDOiY58tVlvprnhxCAMj
# JRrwBhwBAnVIGiG+TE2TgZhw/TO4Ne/WVW1HS/Xp/LmqLlHsCwMahSjN609NaY7+LfIdMh
# XGVIqfjAOvbTulEEMZCRsneMkYwunwoVrsdNp2Gy5c6jkmx3uik3O9n8BQMCI1e4hrtnMJ
# tbZVvPh+b0ui4iPkbA0cWx18AUhvDnwfibrwL5BWYetQR4e0YhnBXGeLhsVyPUjzW/yBXa
# WKorN1wUbQAAA8jY1YCG2NWAhgAAAAdzc2gtcnNhAAABAQCeA8JEJLin2UGMPxrzfYAB3N
# UJ/axVmKzuStZ2SfM73mp85Hs/q4Zubw8dQ8jGif29m8pQsN+FXSJ28dK3xXvVYyTuq2h1
# 905d1bsSMEM6Jjny1WW+mueHEIAyMlGvAGHAECdUgaIb5MTZOBmHD9M7g179ZVbUdL9en8
# uaouUewLAxqFKM3rT01pjv4t8h0yFcZUip+MA69tO6UQQxkJGyd4yRjC6fChWux02nYbLl
# zqOSbHe6KTc72fwFAwIjV7iGu2cwm1tlW8+H5vS6LiI+RsDRxbHXwBSG8OfB+JuvAvkFZh
# 61BHh7RiGcFcZ4uGxXI9SPNb/IFdpYqis3XBRtAAAAAwEAAQAAAQA51QJa0l3LANber5H7
# n+kjxWErYO6b/V79b+KCNJqTRNoQj8cUDIENFhSgD1kCYSq/JK+tTK7iLq4YfnUy0VJ7TO
# gNeiqnUjYaXckz5PoV5Du9RqEQW711T3K77HK87BTaqI7cfP2J2/a30bJ2HjKfS3uOnnJj
# G7+WsEFifVACKsx1EmwpKsej/PiZkycaLxle8xyR/daRbI2Qsq4jbg0/7wLG5hDU2GHJkn
# Jqhlgc3aZF6hlL5JlcqxWhfHUf+03DTNmnflEZizxVFHhOjDkrXPf0Q86lqBYpd+AO2/bX
# 1w0257a92aEnX6t2mD3DQFQh6SvNa9saqyn8oA7iokC5AAAAgQC8+JVJJmA6Pwd82XJGif
# 3kioGSPNB8opUQZ71VlUb8S5/WhBmsVFHfieXw9TkCh2QEHSPl5I0veT2ehkYzPx6PkAm9
# P+FPTENJ4ujYpjXtYsc0tjHB3HqWpnUYSiBrf/SZ2zFNRHQs69wL2ganRBhwVS66XBWsBa
# ZQ4KHy8Gvv/gAAAIEA0gxokvxMiWQKLwP+ucMh3OIGOQK4EJwwxBkhTlqNaBl8woVRimbV
# zMO0QcWn3359Ptfhi130bN340mOeVnV2gH4VLi1N3NJwnK229r0HcCOjt4UmaDDLMZLcqe
# /3VB13sYQhbXe+Bvz1E7ohU3nQzphP+HBrH2PYcA+JD00sPzcAAACBAMCVPa+aOwcvKAYJ
# 5/A0Yglkca4G+/JVaudsE0+96F3ETw4I+btZQYMxV5v0lmKOjdUj5shZlPCa1p1XAJLe6A
# 1g4uCS2nodNunYqdGvfVHnK7MHH3Wb3surgMS9PD1jgJhc/e9RSyZo2vXdpWxc00JGs3BL
# 4KDgfaiz9unk7HN7AAAAEXJlemFlQE1laGRpTGFwdG9wAQ==
# -----END OPENSSH PRIVATE KEY-----" | sudo tee MySecretKey.key -a  > /dev/null

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
sudo docker-compose run --rm freqtrade download-data --exchange binance -t 15m #--timerange=20230101-

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


