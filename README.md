## ICP Gotchi

Correr instancia DFX

dfx start --clean

Desplegar contrato

  dfx deploy --argument "(
    principal\"$(dfx identity get-principal)\", 
    record {
      spect = \"nft-1.0.0\";
      name = \"BurritoBattle Tamagotchi\";
      icon = \"icon\";
      symbol = \"BBT\";
    }
  )" --no-wallet

  dfx deploy --network ic --argument "(
    principal\"$(dfx identity get-principal)\", 
    record {
      spect = \"nft-1.0.0\";
      name = \"BurritoBattle Tamagotchi\";
      icon = \"icon\";
      symbol = \"BBT\";
    }
  )"

Minar token

  dfx canister call gotchi_backend mintGotchi \
  "(
    \"$(dfx identity get-principal)\", 
    record {
      name = \"Gotchi 1\";
      description = \"This is description for Gotchi 1\";
    }
  )"

Consultar token

  dfx canister call gotchi_backend getMetadataGotchi "(1)"

Consultar transactionId

  dfx canister call gotchi_backend getTransactionId

Jugar

  dfx canister call gotchi_backend play "(0)"

Alimentar

  dfx canister call gotchi_backend feed "(0)"

Dormir

  dfx canister call gotchi_backend sleep "(0)"