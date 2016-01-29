{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Data.DBXOpenSSL;

interface

uses
  Data.DBXPlatform,
  Data.DBXTransport,
  System.SysUtils,
  IPPeerAPI
;

const
  RSA_KEY_LENGTH = 1024;
  RSA_KEY_EXPONENT = 3;

type
  TKeyUsagePolicy = (kupUseGlobalKey, kupUseLocalKey);

  TRSACypher = class sealed
    strict private
      class var GLOBAL_RSA_KEY: PRSAPeer;
      class var OPEN_SSL_LOADED: Boolean;
      class var OPEN_SSL_LOAD_STATUS: Boolean;
      class var ERR_LOAD: string;
      class var KEY_MONITOR: TObject;
      class var FIPPeerProcs: IIPPeerProcs;
      class var FIPImplementationID: string;

      FLocalKey: PRSAPeer;
      FConfederatedKey: PRSAPeer;

      FKeyUsagePolicy: TKeyUsagePolicy;

    private
      class procedure Init;
      class procedure Clear;
      class function IPPeerProcs: IIPPeerProcs;
      class procedure GenerateRSAKey(keyLength: Integer; Exponent: Integer;
                                     Monitor: TObject; var Key: PRSAPeer);
      function GetPrivateKey: PRSAPeer;
      function GetSynchMonitor: TObject;
    protected
      class function SSLErrorMessage: string;
      class procedure ClearKey(var AKey: PRSAPeer);

    public
      ///  <summary>Allows user to specify non-default IP Implementation for SSL operation implementations</summary>
      ///  <remarks>If the SSL has already been loaded, this will raise an exception</remarks>
      ///  <param name="AIPImplementationID">name of IP implementation ID to use instead of default</param>
      procedure InitSSLIPImplementationID(const AIPImplementationID: string);

      ///  <summary>Lazy loading of Open SSL library</summary>
      ///  <returns>true if the SSL library was successfully loaded and all
      ///    cyphers are available. Returns false if an error occurs</returns>
      class function LoadSSL: Boolean; overload;
      ///  <summary>Lazy loading of Open SSL library and creates the global RSA key</summary>
      ///  <remarks>If the key generation fails a TDBXError exception is thrown</remarks>
      ///  <param name="keyLength">key length, default RSA_KEY_LENGTH</param>
      ///  <param name="exponent">key exponent, needs to be a prime number, default RSA_KEY_EXPONENT</param>
      class function LoadSSLAndCreateKey(keyLength: Integer = RSA_KEY_LENGTH; Exponent: int64 = RSA_KEY_EXPONENT): Boolean; overload;
      ///  <summary>Returns the load error message</summary>
      ///  <returns>String: the error message</returns>
      class function ErrorLoad: string;
      ///  <summary>Generates the global RSA key pair</summary>
      ///  <remarks>If the key generation fails a TDBXError exception is thrown</remarks>
      ///  <param name="keyLength">key length, default RSA_KEY_LENGTH</param>
      ///  <param name="exponent">key exponent, needs to be a prime number, default RSA_KEY_EXPONENT</param>
      class procedure GenerateGlobalKey(keyLength: Integer = RSA_KEY_LENGTH; Exponent: int64 = RSA_KEY_EXPONENT);

      constructor Create; overload;
      constructor Create(KeyUsagePolicy: TKeyUsagePolicy); overload;
      destructor Destroy; override;

      ///  <summary>Generates the global RSA key pair</summary>
      ///  <remarks>If the key generation fails a TDBXError exception is thrown</remarks>
      ///  <param name="keyLength">key length, default RSA_KEY_LENGTH</param>
      ///  <param name="exponent">key exponent, needs to be a prime number, default RSA_KEY_EXPONENT</param>
      procedure GenerateKey(keyLength: Integer = RSA_KEY_LENGTH; Exponent: int64 = RSA_KEY_EXPONENT);
      ///  <summary>Returns the public key of the used key. If the policy is local
      ///    then the local key is used, otherwise the global key is used</summary>
      ///  <remarks>If the Open SSL library is not loaded it throws a TDBXError</remarks>
      ///  <returns>Array of byte data with the public key</returns>
      function GetPublicKey: TArray<Byte>;
      ///  <summary>Sets the public key so encryption is possible</summary>
      ///  <remarks>The public key was obtained through a reciprocal call of GetPublicKey</remarks>
      ///  <param name="publicKey">Array of byte with the confederated public key</param>
      procedure SetConfederatePublicKey(publicKey: TArray<Byte>);
      ///  <summary>Decrypts data using the private key</summary>
      ///  <remarks>Decryption is done with the key set according to the policy.
      ///    For reason of speed noo checks are made about the instance being properly setup</remarks>
      ///  <param name="data">Encrypted data to be decrypted</param>
      function PrivateDecrypt(Data: TArray<Byte>): TArray<Byte>;
      ///  <summary>Encrypts the clear data using the public key</summary>
      ///  <remarks>The instance is expected to be properly setup (confederated key, policy).
      ///    The data size is expected to be less then the key size - 11.</remarks>
      ///  <param name="data">Data bytes to be encrypted</param>
      function PublicEncrypt(Data: TArray<Byte>): TArray<Byte>;
  end;

const
  USE_GLOBAL = 'UseGlobalKey';
  PUBLIC_KEY = 'PublicKey';
  KEY_LENGTH = 'KeyLength';
  KEY_EXPONENT = 'KeyExponent';

type
  TRSAFilter = class(TTransportFilter)
  private
    FUseGlobalKey: Boolean;
    FRSACypher: TRSACypher;
    FKeyLength: Integer;
    FKeyExponent: Int64;
  private
    procedure InitRSA;
  protected
    function GetParameters: TDBXStringArray; override;
    function GetUserParameters: TDBXStringArray; override;
  public
    constructor Create; override;
    destructor Destroy; override;
    function ProcessInput(const Data: TArray<Byte>): TArray<Byte>; override;
    function ProcessOutput(const Data: TArray<Byte>): TArray<Byte>; override;
    function Id: string; override;
    function SetConfederateParameter(const ParamName: string; const ParamValue: string): Boolean; override;
    function GetParameterValue(const ParamName: string): string; override;
    function SetParameterValue(const ParamName: string; const ParamValue: string): Boolean; override;
    function IsPublicKeyCryptograph: Boolean; override;
  end;

implementation

uses Data.DBXCommon, Data.DBXOpenSSLRes, System.Math;

{ TRSACypher }

class procedure TRSACypher.Clear;
begin
  ClearKey(GLOBAL_RSA_KEY);
  KEY_MONITOR.Free;
end;

class procedure TRSACypher.ClearKey(var AKey: PRSAPeer);
begin
  if AKey <> nil then
    IPPeerProcs._RSA_free(AKey);
  AKey := nil;
end;

constructor TRSACypher.Create;
begin
  FKeyUsagePolicy := kupUseGlobalKey;
  FLocalKey := nil;
  FConfederatedKey := nil;
end;

constructor TRSACypher.Create(KeyUsagePolicy: TKeyUsagePolicy);
begin
  FKeyUsagePolicy := KeyUsagePolicy;
end;

destructor TRSACypher.Destroy;
begin
  ClearKey(FLocalKey);
  ClearKey(FConfederatedKey);
  inherited;
end;

class function TRSACypher.ErrorLoad: string;
begin
  Result := ERR_LOAD;
end;

class procedure TRSACypher.GenerateGlobalKey(keyLength: Integer; Exponent: int64);
begin
  GenerateRSAKey(keyLength, Exponent, KEY_MONITOR, GLOBAL_RSA_KEY);
end;

procedure TRSACypher.GenerateKey(keyLength: Integer; Exponent: int64);
begin
  if FKeyUsagePolicy = kupUseGlobalKey then
    GenerateGlobalKey(keyLength, Exponent)
  else
    GenerateRSAKey(keyLength, Exponent, self, FLocalKey);
end;

class procedure TRSACypher.GenerateRSAKey(keyLength, Exponent: Integer; Monitor: TObject; var Key: PRSAPeer);
var
  err: string;
begin
  if OPEN_SSL_LOAD_STATUS then
  begin
    TMonitor.Enter(Monitor);
    try
      ClearKey(Key);

      //make exponent valid. Must be an odd number
      if Exponent < 3 then
        Exponent := 3
      else if not Odd(Exponent) then
      begin
        Inc(Exponent);
      end;

      Key := IPPeerProcs._RSA_generate_key(keyLength, Exponent);
      if Key = nil then
      begin
        err := SSLErrorMessage;
        if err = EmptyStr then
          err := SKeyCannotBeGenerated;
        raise TDBXError.Create(0, err);
      end;
    finally
      TMonitor.Exit(Monitor);
    end;
  end
  else
    raise TDBXError.Create(0, SOpenSSLNotLoaded);
end;

function TRSACypher.GetPrivateKey: PRSAPeer;
begin
  if FKeyUsagePolicy = kupUseGlobalKey then
    Result := GLOBAL_RSA_KEY
  else
    Result := FLocalKey;
end;

function TRSACypher.GetPublicKey: TArray<Byte>;
var
  Length: Integer;
  bufAddr: PByte;
  Key: PRSAPeer;
  Monitor: TObject;
begin
  if OPEN_SSL_LOADED then
  begin
    if FKeyUsagePolicy = kupUseGlobalKey then
    begin
      Monitor := KEY_MONITOR;
      Key := GLOBAL_RSA_KEY;
    end
    else
    begin
      Monitor := self;
      Key := FLocalKey;
    end;

    TMonitor.Enter(Monitor);
    try
      Length := IPPeerProcs._i2d_RSAPublicKey(Key, nil);
      SetLength(Result, Length);
      bufAddr := Addr(Result[0]);
      IPPeerProcs._i2d_RSAPublicKey(Key, @bufAddr);
    finally
      TMonitor.Exit(Monitor);
    end;
  end
  else
    raise TDBXError.Create(0, SOpenSSLNotLoaded);
end;

function TRSACypher.GetSynchMonitor: TObject;
begin
  if FKeyUsagePolicy = kupUseGlobalKey then
    Result := KEY_MONITOR
  else
    Result := self;
end;

class procedure TRSACypher.Init;
begin
  OPEN_SSL_LOADED := false;
  OPEN_SSL_LOAD_STATUS := false;
  GLOBAL_RSA_KEY := nil;
  FIPPeerProcs := nil;
  FIPImplementationID := '';
  KEY_MONITOR := TObject.Create;
end;

procedure TRSACypher.InitSSLIPImplementationID(
  const AIPImplementationID: string);
begin
  if FIPPeerProcs <> nil then
    raise TDBXError.Create(0, sSSLAlreadyLoaded);
  FIPImplementationID := AIPImplementationID;
end;

class function TRSACypher.IPPeerProcs: IIPPeerProcs;
begin
  if FIPPeerProcs = nil then
    FIPPeerProcs := IPProcs(FIPImplementationID);
  Result := FIPPeerProcs;
end;

class function TRSACypher.LoadSSLAndCreateKey(keyLength: Integer; Exponent: int64): Boolean;
begin
  if OPEN_SSL_LOADED then
    exit(OPEN_SSL_LOAD_STATUS)
  else if LoadSSL then
  begin
    GenerateGlobalKey(keyLength, Exponent);
    exit(true);
  end;
  exit(false);
end;

class function TRSACypher.LoadSSL: Boolean;
begin
  if OPEN_SSL_LOADED then
    exit(OPEN_SSL_LOAD_STATUS);
  // try to load it
  OPEN_SSL_LOADED := true;
  try
    if IPPeerProcs._SSLLoad() then
    begin
      IPPeerProcs._ERR_load_crypto_strings();
      IPPeerProcs._OpenSSL_add_all_ciphers();
      OPEN_SSL_LOAD_STATUS := true;
      exit(true);
    end
    else
    begin
      OPEN_SSL_LOAD_STATUS := false;
      ERR_LOAD := SOpenSSLLoadError;
      exit(false);
    end;
  except
    on ex: Exception do
    begin
      OPEN_SSL_LOAD_STATUS := false;
      ERR_LOAD := ex.Message;
      exit(false);
    end;
  end;
end;

function TRSACypher.PrivateDecrypt(Data: TArray<Byte>): TArray<Byte>;
var
  Key: PRSAPeer;
  Monitor: TObject;
  dataIdx, dataLength, keyLength, resultIdx: Integer;
begin
  Key := GetPrivateKey;
  Monitor := GetSynchMonitor;
  keyLength := IPPeerProcs._RSA_size(Key);
  dataIdx := 0;
  resultIdx := 0;

  while dataIdx < Length(Data) do
  begin
    SetLength(Result, resultIdx + keyLength);
    keyLength := Min(keyLength, Length(Data) - dataIdx);

    TMonitor.Enter(Monitor);
    try
      dataLength := IPPeerProcs._RSA_private_decrypt(keyLength, Pointer(IntPtr(Pointer(Data)) + dataIdx),
                                     Pointer(IntPtr(Pointer(Result)) + resultIdx),
                                     Key, IPPeerProcs.RSA_PKCS1_PADDING);
      if dataLength = -1 then
        raise TDBXError.Create(0, SSLErrorMessage);

      if dataLength <> keyLength then
        SetLength(Result, resultIdx + dataLength);

      Inc(resultIdx, dataLength);
      Inc(dataIdx, keyLength);
    finally
      TMonitor.Exit(Monitor);
    end;
  end;
end;

function TRSACypher.PublicEncrypt(Data: TArray<Byte>): TArray<Byte>;
var
  dataIdx, keyLength, maxLen, resultIdx: Integer;
begin
  keyLength := IPPeerProcs._RSA_size(FConfederatedKey);
  maxLen := keyLength - 11;
  dataIdx := 0;
  resultIdx := 0;

  while dataIdx < Length(Data) do
  begin
    SetLength(Result, resultIdx + keyLength);
    maxLen := Min(maxLen, Length(Data) - dataIdx);

    TMonitor.Enter(self);
    try
      keyLength := IPPeerProcs._RSA_public_encrypt(maxLen, Pointer(IntPtr(Pointer(Data)) + dataIdx),
                                     Pointer(IntPtr(Pointer(Result)) + resultIdx),
                                     FConfederatedKey, IPPeerProcs.RSA_PKCS1_PADDING);
      if keyLength = -1 then
        raise TDBXError.Create(0, SSLErrorMessage);
    finally
      TMonitor.Exit(self);
    end;

    Inc(dataIdx, maxLen);
    Inc(resultIdx, keyLength);
  end;
end;

procedure TRSACypher.SetConfederatePublicKey(publicKey: TArray<Byte>);
var
  bufAddr: PByte;
begin
  bufAddr := Addr(publicKey[0]);
  TMonitor.Enter(self);
  try
    ClearKey(FConfederatedKey);
    FConfederatedKey := IPPeerProcs._d2i_RSAPublicKey( nil, @bufAddr, Length(publicKey));
    if FConfederatedKey = nil then
      raise TDBXError.Create(0, SSLErrorMessage);
  finally
    TMonitor.Exit(self);
  end;
end;

class function TRSACypher.SSLErrorMessage: string;
var
  buff: array [0..1023] of Byte;
  LWrapper: TPtrWrapper;
begin
  LWrapper := TPtrWrapper.Create(@buff[0]);
  IPPeerProcs._ERR_error_string(IPPeerProcs._ERR_get_error(), LWrapper);
  Result := TMarshal.ReadStringAsAnsi(LWrapper, sizeof(buff));
end;

{ TRSAFilter }

constructor TRSAFilter.Create;
begin
  inherited;
  FUseGlobalKey := true;
  FKeyLength := RSA_KEY_LENGTH;
  FKeyExponent := RSA_KEY_EXPONENT;
end;

destructor TRSAFilter.Destroy;
begin
  FreeAndNil(FRSACypher);
  inherited;
end;

function TRSAFilter.GetParameters: TDBXStringArray;
begin
  SetLength(Result, 1);
  Result[0] := PUBLIC_KEY;
end;

function TRSAFilter.GetParameterValue(
  const ParamName: string): string;
begin
  if AnsiCompareStr(ParamName, USE_GLOBAL) = 0  then
  begin
    if FUseGlobalKey then
      exit('true')
    else
      exit('false');
  end;
  if AnsiCompareStr(ParamName, PUBLIC_KEY) = 0  then
  begin
    InitRSA;
    exit(Encode(FRSACypher.GetPublicKey, 0, -1));
  end;
  if AnsiCompareStr(ParamName, KEY_LENGTH) = 0  then
  begin
    exit(IntToStr(FKeyLength));
  end;
  if AnsiCompareStr(ParamName, KEY_EXPONENT) = 0  then
  begin
    exit(IntToStr(FKeyExponent));
  end;
  Result := EmptyStr;
end;

function TRSAFilter.GetUserParameters: TDBXStringArray;
begin
  SetLength(Result, 3);
  Result[0] := USE_GLOBAL;
  Result[1] := KEY_LENGTH;
  Result[2] := KEY_EXPONENT;
end;

function TRSAFilter.Id: string;
begin
  Result := 'RSA';
end;

procedure TRSAFilter.InitRSA;
begin
  if FRSACypher = nil then
  begin
    if not TRSACypher.LoadSSLAndCreateKey(FKeyLength, FKeyExponent) then
      raise TDBXError.Create(0, TRSACypher.ErrorLoad);
    if FUseGlobalKey then
      FRSACypher := TRSACypher.Create
    else
    begin
      FRSACypher := TRSACypher.Create(kupUseLocalKey);
      FRSACypher.GenerateKey(FKeyLength, FKeyExponent);
    end;
  end;
end;

function TRSAFilter.IsPublicKeyCryptograph: Boolean;
begin
  Result := true;
end;

function TRSAFilter.ProcessInput(const Data: TArray<Byte>): TArray<Byte>;
begin
  InitRSA;
  Result := FRSACypher.PublicEncrypt(Data)
end;

function TRSAFilter.ProcessOutput(const Data: TArray<Byte>): TArray<Byte>;
begin
  InitRSA;
  Result := FRSACypher.PrivateDecrypt(Data)
end;

function TRSAFilter.SetConfederateParameter(const ParamName,
  ParamValue: string): Boolean;
begin
  if AnsiCompareStr(ParamName, PUBLIC_KEY) = 0  then
  begin
    InitRSA;
    FRSACypher.SetConfederatePublicKey(Decode(ParamValue));
    exit(true);
  end;
  Result := false;
end;

function TRSAFilter.SetParameterValue(const ParamName,
  ParamValue: string): Boolean;
begin
  if AnsiCompareStr(ParamName, USE_GLOBAL) = 0  then
  begin
    FUseGlobalKey := AnsiCompareText(ParamValue, 'true') = 0;
    exit(true);
  end;
  if AnsiCompareStr(ParamName, KEY_LENGTH) = 0  then
  begin
    FKeyLength := StrToInt(ParamValue);
    exit(true);
  end;
  if AnsiCompareStr(ParamName, KEY_EXPONENT) = 0  then
  begin
    FKeyExponent := StrToInt64(ParamValue);
    exit(true);
  end;
  exit(false);
end;

initialization
  TRSACypher.Init;

finalization
  TRSACypher.Clear;

end.
