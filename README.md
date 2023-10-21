# Introduction
I share my docker stack for developing Bitcoin stuff. This is a quick and dirty stack, things could be done in a better way, but this way is convienent for me. I hope it could be useful for other plebs. Coments and PRs are very welcome. Please don't use it on mainnet, there are better solutions for this. I create this stuff during the awesome [Bitshala's](https://www.bitshala.org/) cohort  [Learning Bitcoin from the Command Line](https://github.com/BlockchainCommons/Learning-Bitcoin-from-the-Command-Line). Please, checkout [Bitshala](https://www.bitshala.org/) site, this folks are making really great things for bitcoin plebs.


# Docker stack

This are the docker stack containers:
* bitcoind
* fulcrum
* mempool.space (web, api, db)

# Explanation

The key component is the [my_entry_point.sh](my_entry_point.sh) script. This bash scripts start a bitcoind node, also creates some wallets, mine some blocks and finally creates some TX and sleeps for long time. No data is persistent, every time that you stop & start the docker stack a new shinny bitcoin devel environment is ready for build new crazy stuff.

# Usage

Clone this repo:
```
git clone https://github.com/lazysatoshi/docker-btc-regtest-stack
```

Start the docker stack:

```
cd docker-btc-regtest-stack
docker compose up
```

Wait some minutes, after downloading container images and bulding the stack. Then, you should connect to your [mempool.space](https://localhost:1080) bitcoin regtest explorer at localhost port 1080 and enjoy it!
