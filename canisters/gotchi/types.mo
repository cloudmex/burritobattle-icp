import Nat "mo:base/Nat";
import Nat8 "mo:base/Nat8";
import Nat16 "mo:base/Nat16";
import Nat32 "mo:base/Nat32";
import Nat64 "mo:base/Nat64";
import Blob "mo:base/Blob";
import Principal "mo:base/Principal";

module {
  public type NFTContractMetadata = {
    spect: Text;
    name: Text;
    icon: Text;
    symbol: Text;
  };

  public type Nft = {
    owner: Principal;
    id: TokenId;
    metadata: TokenMetadata;
  };

  public type TokenMetadataParameters = {
    name: Text;
    description: Text;
  };

  public type TokenMetadata = {
    name: Text;
    description: Text;
    image: Text;
    external_url: Text;
    properties: Properties;
  };

  public type Properties = {
      health    : Int;
      hunger    : Int;
      sleep     : Int;
      happiness : Int;
      lastMeal  : Int;
  };

  public type TokenId = Nat64;
  public type TransactionId = Nat;

  public type GenericValue = {
    #TextContent : Text;
    #BlobContent : Blob;
    #NatContent : Nat;
    #Nat8Content: Nat8;
    #Nat16Content: Nat16;
    #Nat32Content: Nat32;
    #Nat64Content: Nat64;
    #BoolContent: Bool;
  };

  public type MetadataResult = Result<TokenMetadata, ApiError>;

  public type ApiError = {
    #Unauthorized;
    #InvalidTokenId;
    #ZeroAddress;
    #Other;
  };

  public type MintReceipt = Result<MintReceiptPart, ApiError>;

  public type MintReceiptPart = {
    token_id: TokenId;
    id: Nat;
    message: Text;
  };

  public type Result<S, E> = {
    #Ok : S;
    #Err : E;
  };

};