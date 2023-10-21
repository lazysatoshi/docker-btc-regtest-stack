COLOR='\033[35m'
NO_COLOR='\033[0m'

# Create a bitcoind config file and start the bitcoin node.
start_node() {
  echo -e "${COLOR}Starting bitcoin node...${NO_COLOR}"

  mkdir /tmp/lazysatoshi_datadir

  cat <<EOF >/tmp/lazysatoshi_datadir/bitcoin.conf
    regtest=1
    fallbackfee=0.00001
    server=1
    txindex=1
    mempoolfullrbf=1
    listenonion=0

    [regtest]
    rpcuser=test
    rpcpassword=test321
    rpcbind=0.0.0.0
    rpcallowip=0.0.0.0/0
    zmqpubrawblock=tcp://0.0.0.0:28332
    zmqpubrawtx=tcp://0.0.0.0:28332
    zmqpubhashtx=tcp://0.0.0.0:28332
    zmqpubhashblock=tcp://0.0.0.0:28332
EOF

  bitcoind -datadir=/tmp/lazysatoshi_datadir -printtoconsole -debug=1 -debugexclude=http -debugexclude=rpc > /proc/1/fd/1 2>&1 &
  sleep 2
}

# Create wallets: Miner and Alice.
create_wallets() {
  echo -e "${COLOR}Creating Wallets...${NO_COLOR}"
  # Legacy wallets created in order to use command dumpprivkey
  bitcoin-cli -datadir=/tmp/lazysatoshi_datadir -named createwallet wallet_name=Miner descriptors=false
  ADDR_MINING=$(bitcoin-cli -datadir=/tmp/lazysatoshi_datadir -rpcwallet=Miner getnewaddress "Mining Reward")
  ADDR_MINER=$(bitcoin-cli -datadir=/tmp/lazysatoshi_datadir -rpcwallet=Miner getnewaddress "Miner receive Alice payment" legacy)
  PUBKEY_ADDR_MINER=$(bitcoin-cli -regtest -datadir=/tmp/lazysatoshi_datadir -rpcwallet=Miner -named getaddressinfo address=$ADDR_MINER | jq -r '.pubkey')
}

# Mining some blocks to be able to spend mined coins
mining_blocks() {
  echo -e "${COLOR}Mining 103 blocks...${NO_COLOR}"

  bitcoin-cli -datadir=/tmp/lazysatoshi_datadir -rpcwallet=Miner generatetoaddress 103 $ADDR_MINING >/dev/null
}

# Funding wallets and generate required addresses for the exercise
funding_wallets() {
  echo -e "${COLOR}Funding Alice wallet...${NO_COLOR}"

  ADDR_ALICE=$(bitcoin-cli -datadir=/tmp/lazysatoshi_datadir -rpcwallet=Alice getnewaddress "Funding wallet")
  ADDR_SPENT=$(bitcoin-cli -datadir=/tmp/lazysatoshi_datadir -rpcwallet=Alice getnewaddress "Receiving spended CSV")
  bitcoin-cli -datadir=/tmp/lazysatoshi_datadir -rpcwallet=Miner sendtoaddress $ADDR_ALICE 80
  bitcoin-cli -datadir=/tmp/lazysatoshi_datadir -rpcwallet=Miner generatetoaddress 1 $ADDR_MINING >/dev/null
}

# Clean working directory
clean_up() {
  echo -e "${COLOR}Clean Up${NO_COLOR}"
  bitcoin-cli -datadir=/tmp/lazysatoshi_datadir stop
  rm -rf /tmp/lazysatoshi_datadir
}


# Main program
disclaimer_message 
start_node
create_wallets
mining_blocks
funding_wallets
# Sleep for a long time
sleep 10000000
clean_up
