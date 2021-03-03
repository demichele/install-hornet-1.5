# Install Chrysalis Hornet 

You can use this one line command to get a routine that will perform the installation of Hornet for IOTA 1.5 testnet. 
Login to your VPS and run the command bellow. **This shell script has been tested in Ubuntu 20.04.** 


## Install Golang and Hornet

The following commands will download and run an install.sh script with all steps needed to install Hornet according to the guide by Svenger87 (https://github.com/svenger87/hornet-alphanet-tutorial). 

```
wget https://raw.githubusercontent.com/demichele/install-hornet-1.5/main/install.sh && chmod 0777 install.sh && ./install.sh
```

## Config Hornet

After the installation is done, you will need to generate a hash and salt for the Dashboard password. 
This is done with Hornet tools. Head to the /opt/hornet-testnet directory and run

```
./hornet tool pwdhash
```

The program will ask for a password (this will be your Dashboard password) and return both Salt and Hash. 

Next, edit the **config_chrysalis_testnet.json** file to add your hash and salt to the Dashboard section. 
**IMPORTANT:** if you are running the node on a VPS you might need to change references to **localhost** to **0.0.0.0** in the dashboard section. 
See following block.


```
  "dashboard": {
    "bindAddress": "0.0.0.0:8081",
    "dev": false,
    "auth": {
      "sessionTimeout": "72h",
      "username": "admin",
      "passwordHash": "YOUR_HASH",
      "passwordSalt": "YOUR_SALT"
    }
  },
```

Once you add your salt and hash to the config file, restart the node and access it at the port 8081 

Restart
```
systemctl start hornet-testnet
```

Your Dashboard
```
http://YOUR_VPS_IP:8081
```

## Add Neighbors

You can add new neighbors from the Dashboard visiting https://nodesharing.wisewolf.de/ or asking guys at the chrysalis-testnet Discord channel.
Keep in mind that neighbors are handled following this structure.

```
# IF the neighbor is reachable through a domain:
/dns/NEIGHBOR_DOMAIN/tcp/15600/p2p/12D3KooWS7nyRgFjzgkethzi6SDdjmuAGooxDmnoLzyex7Lu4hKo

# IF the neighbor is reachable through an IP:
/ip4/NEIGHBOR_IP/tcp/15600/p2p/12D3KooWS7nyRgFjzgkethzi6SDdjmuAGooxDmnoLzyex7Lu4hKo
```

## Update Hornet

```
systemctl stop hornet-testnet && cd /opt/hornet && git pull && scripts/build_hornet.sh && cp hornet /opt/hornet-testnet && systemctl start hornet-testnet
```

If the version contains breaking changes:

```
systemctl stop hornet-testnet && cd /opt/hornet-testnet && rm -rf testnetdb && rm -rf snapshots && cd /opt/hornet && git pull && scripts/build_hornet.sh && cp hornet /opt/hornet-testnet && systemctl start hornet-testnet
```


