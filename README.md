## Burrito Battle - ICP 🐴

Burrito Battle is a full ecosystem of adventures for Burritos, A decentralized game living on Blockchain.
We started at NEAR and now we are looking for more ways to expand the Burrito culture.

Internet Computer Protocol is a blockchain network that aims to bring greater efficiency, speed and decentralization to computation and data storage.

BurritoBattle-ICP is an initiative to develop a gaming platform based on blockchain technology and the ICP protocol. The platform will allow users to create, collect and care for their own Tamagotchis (virtual pets) in a secure and decentralized environment.

## Install dependencies 📦

    [Node.js] ≥ 12.22.5 
    npm install
    npm install vite --save

### Register, build, and deploy the application 🚀

Run DFX instance
    
    dfx start --clean

Local

    dfx deploy --argument "(
      principal\"$(dfx identity get-principal)\", 
      record {
        spect = \"nft-1.0.0\";
        name = \"BurritoBattle Tamagotchi\";
        icon = \"icon\";
        symbol = \"BBT\";
      }
    )" --no-wallet

Mainnet

  dfx deploy --network ic --argument "(
    principal\"$(dfx identity get-principal)\", 
    record {
      spect = \"nft-1.0.0\";
      name = \"BurritoBattle Tamagotchi\";
      icon = \"icon\";
      symbol = \"BBT\";
    }
  )"

### Mint

 dfx canister call gotchi_backend mintGotchi \
  "(
    \"$(dfx identity get-principal)\", 
    record {
      name = \"Gotchi 1\";
      description = \"This is description for Gotchi 1\";
    }
  )"

### Interact with the virtual pet

Play

  dfx canister call gotchi_backend play "(0)"

Feed

  dfx canister call gotchi_backend feed "(0)"

Sleep

  dfx canister call gotchi_backend sleep "(0)"