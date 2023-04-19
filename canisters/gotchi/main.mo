import Nat "mo:base/Nat";
import Nat8 "mo:base/Nat8";
import Nat16 "mo:base/Nat16";
import Nat32 "mo:base/Nat32";
import Nat64 "mo:base/Nat64";
import List "mo:base/List";
import Array "mo:base/Array";
import Option "mo:base/Option";
import Bool "mo:base/Bool";
import Principal "mo:base/Principal";
import Types "./types";
import Debug "mo:base/Debug";
import Iter "mo:base/Iter";
import Text "mo:base/Text";
import Int "mo:base/Int";
import Time "mo:base/Time";
import Random "mo:base/Random";
import Blob "mo:base/Blob";
import Char "mo:base/Char";

shared actor class ICPGotchi(custodian : Principal, init : Types.NFTContractMetadata) = Self {
  stable var counter = 0;

   public query func get() : async Nat {
    return counter;
  };

  public func inc() : async () {
    counter += 1;
  };

  public func hello() : async Text {
    return "Hello";
  };


  stable var transactionId : Types.TransactionId = 0; // Transaction counter
  stable var nfts = List.nil<Types.Nft>(); // List where nfts are stored
  stable var custodians = List.make<Principal>(custodian); // List where the custodians of the contract are stored
  stable var spect : Text = init.spect;
  stable var name : Text = init.name;
  stable var symbol : Text = init.symbol;
  stable var icon : Text = "data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/4gIoSUNDX1BST0ZJTEUAAQEAAAIYAAAAAAQwAABtbnRyUkdCIFhZWiAAAAAAAAAAAAAAAABhY3NwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAA9tYAAQAAAADTLQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAlkZXNjAAAA8AAAAHRyWFlaAAABZAAAABRnWFlaAAABeAAAABRiWFlaAAABjAAAABRyVFJDAAABoAAAAChnVFJDAAABoAAAAChiVFJDAAABoAAAACh3dHB0AAAByAAAABRjcHJ0AAAB3AAAADxtbHVjAAAAAAAAAAEAAAAMZW5VUwAAAFgAAAAcAHMAUgBHAEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFhZWiAAAAAAAABvogAAOPUAAAOQWFlaIAAAAAAAAGKZAAC3hQAAGNpYWVogAAAAAAAAJKAAAA+EAAC2z3BhcmEAAAAAAAQAAAACZmYAAPKnAAANWQAAE9AAAApbAAAAAAAAAABYWVogAAAAAAAA9tYAAQAAAADTLW1sdWMAAAAAAAAAAQAAAAxlblVTAAAAIAAAABwARwBvAG8AZwBsAGUAIABJAG4AYwAuACAAMgAwADEANv/bAEMAAwICAgICAwICAgMDAwMEBgQEBAQECAYGBQYJCAoKCQgJCQoMDwwKCw4LCQkNEQ0ODxAQERAKDBITEhATDxAQEP/bAEMBAwMDBAMECAQECBALCQsQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEP/AABEIAGAAYAMBIgACEQEDEQH/xAAcAAEAAgIDAQAAAAAAAAAAAAAABQcGCAEDCQT/xAA1EAABAwQBAwEGBAUFAQAAAAABAgMEAAUGEQcSITFBCBMUIlFhMnGBkRUXUmKhFiMzQ8Hw/8QAGwEAAgMBAQEAAAAAAAAAAAAAAAUEBgcBAwL/xAAyEQABAwMCBQIEBAcAAAAAAAABAgMRAAQhBTEGEkFRcWGBEyIykQcUFfAjUnKCobHB/9oADAMBAAIRAxEAPwD1TpSlFFKUpRRSutl9iQkrjvNupSooJQoKAUDojt6isT5YzQYFglyvzawJfu/cQgRvqkL7I7euvxa+gNYFwJEueE3268e3mc5Ickw499aLh2Q45tD4+/zpH7b9aWPaklq9RaBMzuf5ZnlH90H9mmDVgXLRdyTEbDvEc32kVdtKUpnS+lKoPlrkDIkZe1Pxu4KaseEzogu5QsgPvPLCVIOuyghKgCD6qP0q+0qC0haTsKGxUC01Bu7dcaQPoO/fcSPSQR7VNubJdq024o/V07bGD7EH3rmlKVPqFSlKUUUpSlFFUFmq5fJ/NcTF0dRsOFlEub/Q5KVpSUn6nwPyC/vU9kalWHk7GMxcAahIYk26c7vy2tPUjt5+VYB/Imo/G7rasTyrPv4w6W5D9+U6lISStxtTSVI19tKqJ5FyeHmFqjQLc1IjOxZrUpLqyB8qSQpOh9UkiqLcXlvb2rrq3B8dS+aPVCvlT6CBHTc96uVvaXD9w02ls/BCOWf6k/Mr1Mmeuwq/4kyJPjolwpLb7Lg2lbagpJ/UVE5vk8XDcTumTS+6YMdTiE/1uHshA+5UUj9aonH8qu2LzfiLTJX7nq2plf4HE/cfX7isi5BzS1Z3Fxy0LDjEH+IomXhCkkgNtDqS32/EFK0O3gVKZ4rZurVeyHYgAnEnAIPYHJ7CvB7hh62uUxK2pkwMwMkEdzsPWvibwWb/ACRu1ulAuXi9R3bpMUfK5KiHAP0CUp/SrA4NypeXcY2afIc65MZr4KQSe5W18uz9ykJP619lvutsuzPvLdMafQB3CT3H5jyKxn2dILUPGL47DGoMjIJqoYHj3IUEp19u1T2GUW17b/l1SgtlJzM8pBB9ckz5qA86u4tHg+IUFhXaOYEEfYCPFWvSlKsNI6UpSiilRd/yWz41F+LusoNhW+hA7rWfoBUmd6OvNVlduLchyS5uXO9ZCwFLPyoQ2pQbT6JG9dhS3U7i7Yaiyb51nxA9TkfamGnMWrzk3jnIgfc+gwarbLbpHyHKpuQxGHI7ctDaFMqUFbUga6/HYkaGvsKi6o/njmXPOOc3u+I4vaLa5Ftz6oyJsttaluKT2UQkKCU/NvQO+2qh8y9oPJrZxhi+RWWNEcu10ccZnhxpSkNraGlgBKhrZKSO/g1k11aXbrqnHACtRM5G+SdsCt0tuH7pq2ZU0j+GsDlO+IkT7dDmtiKVr7xP7QdzzSBcccuEOFGyctOu2tCG3Ex5Sko37skqJCux9dGsbs/tg5CmS2i8YQw9HKgHDHeWlwD6gEEH9ajIsLxSuRTeRvkQPuRPkCvsaNdqWpCUyRW19uVcPjGmbW48mS+r3LYaVpSirtoVsDx/jicSw214+GEsqiMdK0hXVtZJKiT6kkkn71qNJ5exqx4zZs6L8xES6OtpjKZb6nW1lKld0g7HSUEHW9GtusCvk3JMStl7nMlCpsZt9C+w982tIUhzXptJBIOiDvsKuPBgSl5wLB5ox2iRPgyB5j0rPuNLS5Zt23VIhBURJwSoTj1iT4NZBSlK0Os5pSlKKKVgvK3NOAcNWhF0zW7Fpx8K+FhsJ95IkkeiEft3JAHqazaRIjxGHJMp9tllpJWtxxQSlKR5JJ8CtK+dsAez2Fb+ZrnJVcn8qyq32ixMJUS1BswLhQUjwVuqR1k+AHNeSaXapeKsrZTrYkgE+w3NWjhTR7TVr5KdQWUtSBjdROyQdhgEk9gYyRWG+2NnfH2JwbXyXmca42sZZMbadjwobcqQylMcuKAQtSG1LPQlHUo6BXvuBqtGONebL9yHn9r4+nwYMS03u5e6jLZjKU7Gdc2hpagFpSRsoC9BOwN+gFei3tTcBxefeNUY00lpNytcpM63KcWUJKwlSFNlQ8BSVH9QK1r9nb2Icvxjka25Dl2Pos1utElEtS1y233ZKm1dSEJ6FK0kqCdk67b9ayjhTX9IueH7i81S5Sm4BcUQojnJOU/DSdxsABgGZxTa74l13Trpq2sFOcg5QkAnkAGPmM4gd8xsayPBscg8fu5VceQLK9Av/HrRmyHoi1qYkRXG1qZktpUdjqCVp6STpaCN1rhm3NzfH9+Yx24ce29Fw6G5E1h951RgpdAUhle+6nEoKSvsBs6A7br1KveFYrkbVyavVkjSk3iK3Bn9ae8hhClKQ2ojykFazr+415z+2t7O17/m7dswECYiHf3RJjzmWC60pRSAptevCwQfUEjXmon4e6uxxLqa7W6MLKeYAmASAkEJz1JWqOgAjY011vjnW9NZS/8AHVH0lQyYyRzYOBt5J71shwxFxjmGxIsViy6yzo2Mv9UpyzlS46g/tbZa94lCkkp7KSpIKV9Y76BPoXYoEG1WS32y2JKYcOK0xHSTvTSEBKRv8gK86vYA4IvvEeF3q/5E3JYkZK8yphh9v3awy2FaWUeU9RUdA99DfqK9D8ZdLuP29ZPcMJT+w1/5Vl4Uv0DifUdNZWFtpAKYgxH1AEb/ADKjc7VWtf1i81mxt3rpROSdoknMkYyd/fpUpSlK06qjXBIAJPgVSPIfEvJ/Mlz+Il8oTsOxtslMS2WlJ9+8nf8AyvubHzK8hA2EjXk7q76V5PMpfHKvbzH+qYadqb+lO/Hto5+hICo8BQIn1iR0qicf9kLBLeU/6py7McraBBVEud3X8Ksj+ptHSVD7KUQfUVzy5l+P3mbjfDXHTcO535u7wpTkeGApq0RIrgWtxwp+VHyp6Anyeo9vG5H2g43JGYOWLijja6rs7mQfESLxd0lQMOA0W0qCSnR6lqdAABBPSRsAkjKOI+F8I4ZsJs+JwNyH9Km3B75pEtY9Vq9B9EjsPzJJXO2iXgu0aTyoIhR65Gw9jv0q0nU1BhvVNUuC69kttDYZI51xAAkYSBKoyQKwyLCkzZKYcZordUdBP/3ipiRbMVs8lFtveSsJuLhbQiMHEt9bi99DYWvt1q0dA6J7fWszFhh2y5y5zCdGT82tdkepA+xPeqR5a4kyHLL5dmhaU3ixX1UeQSzLSxKgSWkJSFoKux/Akgg/Ufnk/C34d6fZOLTrSQ4uTGTygAwDAiSoZycbRM0ovtYdcj8uYH+f2KtRGIY4uAbj8ZNDaQepPbrSoHRT0631b7a+tRbFpxO4SxaId+9zc+tTaoq1pdU24lPUW1lHyhYHcp2an4dpmM48zb1XBwz0xUIVKWApRfS2Eh1Q8E7AP07VT/GHEmU4nkFsjiM5FtVqmP3GVPmTUvzLlKcSoFZ6fGyvZJPfxoVaU8I8MPtrDlolMdiZPjIqD+o3qSCHDWVXW0zbPKMWY3o+UqH4Vj6g1bOPxlRLJBjuDSkMI6h9CRsj/NR821sXtyKmakkMuhwEJ8j1T+R7VkHio/A/B6OH9RurtlRLSgEoneN1A+DAB616ajqBu2UIUPmG/wDylKUrTaT0pSlFFdJiMGYJ3R/vBos9X9pIOv3Fd1KUV0knenmoiVbHg6pTCQUE7A34qXpRXKghb5Z/6/8AIr6YtsUFhbxGh6CpSlciiuPFc0pXaKUpSiiv/9k=";

  //Burrito's designs
  stable var burrito1 : Text = "https://cloudflare-ipfs.com/ipfs/QmbMS3P3gn2yivKDFvHSxYjVZEZrBdxyZtnnnJ62tVuSVk";
  stable var burrito2 : Text = "https://cloudflare-ipfs.com/ipfs/QmQcTRnmdFhWa1j47JZAxr5CT1Cdr5AfqdhnrGpSdr28t6";
  stable var burrito3 : Text = "https://cloudflare-ipfs.com/ipfs/QmULzZNvTGrRxEMvFVYPf1qaBc4tQtz6c3MVGgRNx36gAq";
  stable var burrito4 : Text = "https://cloudflare-ipfs.com/ipfs/QmZEK32JEbJH3rQtXL9BqQJa2omXfpjuXGjbFXLiV2Ge9D";


  // Get NFT Contract Metadata
  public query func getNFTContractMetadata() : async Types.NFTContractMetadata {
    let meta : Types.NFTContractMetadata = {
      spect : Text = spect;
      name : Text = name;
      icon : Text = icon;
      symbol : Text = symbol
    };

    return meta
  };

  // Get last transaction number
  public query func getTransactionId() : async Types.TransactionId {
    return transactionId
  };

  // Get gotchis Number
  public query func totalSupplyGotchis() : async Nat64 {
    return Nat64.fromNat(
      List.size(nfts)
    )
  };

  // Get One Gotchi
  public query func getMetadataGotchi(token_id : Types.TokenId) : async Types.MetadataResult {
    let item = List.find(nfts, func(token : Types.Nft) : Bool { token.id == token_id }); // Find NFT by Id
    switch (item) {
      case null {
        return #Err(#InvalidTokenId)
      };
      case (?token) {
        return #Ok(token.metadata)
      }
    }
  };

  // Get All Gotchis From User
  public query func getGotchisFromUser(user : Text) : async [Types.Nft] {
    let items = List.filter(
      nfts,
      func(token : Types.Nft) : Bool {
        return token.owner == Principal.fromText(user); // Filter NFT's by user
      },
    );

    return List.toArray(items);
  };

  // Get All Gotchis
  public query func getAll() : async [Types.Nft] {
    let items = List.filter(nfts, func(token : Types.Nft) : Bool { true });
    return List.toArray(items);
  };

  // Mint
  public shared ({ caller }) func mintGotchi(to : Text, metadata : Types.TokenMetadataParameters) : async Types.MintReceipt {
    // if (not List.some(custodians, func (custodian : Principal) : Bool { custodian == caller })) { // Only custodians can mint
    //   return #Err(#Unauthorized);
    // };

    let timestamp = Time.now();
    let n = timestamp / 1000;
    let burritoImg : Text = if (n % 2 == 0) {
      burrito1
    } else {
      burrito2
    };

    let newId = Nat64.fromNat(List.size(nfts));

    let properties : Types.Properties = {
      health = 10;
      hunger = 0;
      sleep = 0;
      happiness = 10;
      lastMeal = Time.now()
    };

    let meta : Types.TokenMetadata = {
      name : Text = metadata.name;
      description : Text = metadata.description;
      image : Text = burritoImg;
      external_url : Text = "";
      properties : Types.Properties = properties
    };

    let nft : Types.Nft = {
      owner = Principal.fromText(to);
      id = newId;
      metadata = meta
    };

    nfts := List.push(nft, nfts);

    transactionId += 1;

    return #Ok({
      token_id = newId;
      id = transactionId;
      message = "Gotchi Minted successfully"
    })
  };

  // +-happiness | +sleep | -health
  public shared ({ caller }) func play(token_id : Types.TokenId) : async Types.MintReceipt {
    let item = List.find(nfts, func(token : Types.Nft) : Bool { token.id == token_id });
    let actualDate = Time.now();
    switch (item) {
      case null {
        return #Err(#InvalidTokenId)
      };
      case (?token) {
        // 3 days:  259200000000000
        // 2 days:  172800000000000
        // 1 day:   86400000000000
        // 1 hour:   3600000000000
        // 3 minutes: 180000000000
        // 2 minutes: 120000000000
        // 1 minute:   60000000000
        //Debug.print("Message to print");

        // 1 day without eating
        if (actualDate >= (token.metadata.properties.lastMeal +60000000000) and actualDate < (token.metadata.properties.lastMeal +120000000000)) {
          transactionId += 1;
          nfts := List.map(
            nfts,
            func(item : Types.Nft) : Types.Nft {
              if (item.id == token.id) {
                let new_happiness = token.metadata.properties.happiness -1;
                let happiness = if (new_happiness < 0) { 0 } else {
                  new_happiness
                };
                let properties : Types.Properties = {
                  health = token.metadata.properties.health;
                  hunger = if (token.metadata.properties.hunger > 1) {
                    token.metadata.properties.hunger
                  } else { 1 };
                  sleep = token.metadata.properties.sleep;
                  happiness = happiness;
                  lastMeal = token.metadata.properties.lastMeal
                };
                let new_meta : Types.TokenMetadata = {
                  name : Text = token.metadata.name;
                  description : Text = token.metadata.description;
                  image : Text = token.metadata.image;
                  external_url : Text = token.metadata.external_url;
                  properties : Types.Properties = properties
                };
                let update : Types.Nft = {
                  owner = item.owner;
                  id = item.id;
                  metadata = new_meta
                };
                return update
              } else {
                return item
              }
            },
          );
          return #Ok({
            token_id = token.id;
            id = transactionId;
            message = "Your Gotchi hasn't eaten for 1 day"
          })
        };
        // 2 days without eating
        if (actualDate >= (token.metadata.properties.lastMeal +120000000000) and actualDate < (token.metadata.properties.lastMeal +180000000000)) {
          transactionId += 1;
          nfts := List.map(
            nfts,
            func(item : Types.Nft) : Types.Nft {
              if (item.id == token.id) {
                let new_happiness = token.metadata.properties.happiness -1;
                let happiness = if (new_happiness < 0) { 0 } else {
                  new_happiness
                };
                let properties : Types.Properties = {
                  health = token.metadata.properties.health;
                  hunger = 2;
                  sleep = token.metadata.properties.sleep;
                  happiness = happiness;
                  lastMeal = token.metadata.properties.lastMeal
                };
                let new_meta : Types.TokenMetadata = {
                  name : Text = token.metadata.name;
                  description : Text = token.metadata.description;
                  image : Text = token.metadata.image;
                  external_url : Text = token.metadata.external_url;
                  properties : Types.Properties = properties
                };
                let update : Types.Nft = {
                  owner = item.owner;
                  id = item.id;
                  metadata = new_meta
                };
                return update
              } else {
                return item
              }
            },
          );
          return #Ok({
            token_id = token.id;
            id = transactionId;
            message = "Your Gotchi hasn't eaten for 2 days"
          })
        };
        // 3 days without eating
        if (actualDate >= (token.metadata.properties.lastMeal +180000000000)) {
          transactionId += 1;
          nfts := List.map(
            nfts,
            func(item : Types.Nft) : Types.Nft {
              if (item.id == token.id) {
                let new_happiness = token.metadata.properties.happiness -1;
                let happiness = if (new_happiness < 0) { 0 } else {
                  new_happiness
                };
                let properties : Types.Properties = {
                  health = token.metadata.properties.health;
                  hunger = 3;
                  sleep = token.metadata.properties.sleep;
                  happiness = happiness;
                  lastMeal = token.metadata.properties.lastMeal
                };
                let new_meta : Types.TokenMetadata = {
                  name : Text = token.metadata.name;
                  description : Text = token.metadata.description;
                  image : Text = token.metadata.image;
                  external_url : Text = token.metadata.external_url;
                  properties : Types.Properties = properties
                };
                let update : Types.Nft = {
                  owner = item.owner;
                  id = item.id;
                  metadata = new_meta
                };
                return update
              } else {
                return item
              }
            },
          );
          return #Ok({
            token_id = token.id;
            id = transactionId;
            message = "Your Gotchi hasn't eaten for 3 days"
          })
        };

        // Modify statistics
        nfts := List.map(
          nfts,
          func(item : Types.Nft) : Types.Nft {
            if (item.id == token.id) {

              let new_happiness = token.metadata.properties.happiness +1;
              let happiness = if (new_happiness > 10) { 10 } else {
                new_happiness
              };

              let timestamp = Time.now();
              let n = timestamp / 1000;
              let gaveSleep : Bool = if (n % 2 == 0) {
                true
              } else {
                false
              };

              let new_sleep = if (gaveSleep) {
                token.metadata.properties.sleep +1
              } else { token.metadata.properties.sleep };
              let sleep = if (new_sleep > 10) { 10 } else { new_sleep };

              let properties : Types.Properties = {
                health = token.metadata.properties.health;
                hunger = token.metadata.properties.hunger;
                sleep = sleep;
                happiness = happiness;
                lastMeal = token.metadata.properties.lastMeal
              };

              let new_meta : Types.TokenMetadata = {
                name : Text = token.metadata.name;
                description : Text = token.metadata.description;
                image : Text = token.metadata.image;
                external_url : Text = token.metadata.external_url;
                properties : Types.Properties = properties
              };
              let update : Types.Nft = {
                owner = item.owner;
                id = item.id;
                metadata = new_meta
              };
              return update
            } else {
              return item
            }
          },
        );
        transactionId += 1;
        return #Ok({
          token_id = token.id;
          id = transactionId;
          message = "Your Gotchi has played"
        })
      }
    }
  };

  // -sleep
  public shared ({ caller }) func sleep(token_id : Types.TokenId) : async Types.MintReceipt {
    let item = List.find(nfts, func(token : Types.Nft) : Bool { token.id == token_id });
    switch (item) {
      case null {
        return #Err(#InvalidTokenId)
      };
      case (?token) {
        nfts := List.map(
          nfts,
          func(item : Types.Nft) : Types.Nft {
            if (item.id == token.id) {
              let new_health = if (token.metadata.properties.sleep == 0) {
                token.metadata.properties.health -1
              } else { token.metadata.properties.health };
              let health = if (new_health < 0) { 0 } else { new_health };
              let new_sleep = token.metadata.properties.sleep -1;
              let sleep = if (new_sleep < 0) { 0 } else { new_sleep };
              let properties : Types.Properties = {
                health = health;
                hunger = token.metadata.properties.hunger;
                sleep = sleep;
                happiness = token.metadata.properties.happiness;
                lastMeal = token.metadata.properties.lastMeal
              };

              let new_meta : Types.TokenMetadata = {
                name : Text = token.metadata.name;
                description : Text = token.metadata.description;
                image : Text = token.metadata.image;
                external_url : Text = token.metadata.external_url;
                properties : Types.Properties = properties
              };
              let update : Types.Nft = {
                owner = item.owner;
                id = item.id;
                metadata = new_meta
              };
              return update
            } else {
              return item
            }
          },
        );
        transactionId += 1;
        return #Ok({
          token_id = token.id;
          id = transactionId;
          message = "Your Gotchi has rested"
        })
      }
    }
  };

  // -hunger
  public shared ({ caller }) func feed(token_id : Types.TokenId) : async Types.MintReceipt {
    let item = List.find(nfts, func(token : Types.Nft) : Bool { token.id == token_id });
    switch (item) {
      case null {
        return #Err(#InvalidTokenId)
      };
      case (?token) {
        // Modificar estadísticas
        nfts := List.map(
          nfts,
          func(item : Types.Nft) : Types.Nft {
            if (item.id == token.id) {
              let new_hunger = token.metadata.properties.hunger -1;
              let hunger = if (new_hunger < 0) { 0 } else { new_hunger };

              let properties : Types.Properties = {
                health = token.metadata.properties.health;
                hunger = hunger;
                sleep = token.metadata.properties.sleep;
                happiness = token.metadata.properties.happiness;
                lastMeal = Time.now()
              };

              let new_meta : Types.TokenMetadata = {
                name : Text = token.metadata.name;
                description : Text = token.metadata.description;
                image : Text = token.metadata.image;
                external_url : Text = token.metadata.external_url;
                properties : Types.Properties = properties
              };
              let update : Types.Nft = {
                owner = item.owner;
                id = item.id;
                metadata = new_meta
              };
              return update
            } else {
              return item
            }
          },
        );
        transactionId += 1;
        return #Ok({
          token_id = token.id;
          id = transactionId;
          message = "Your Gotchi has eaten"
        })
      }
    }
  }
}
