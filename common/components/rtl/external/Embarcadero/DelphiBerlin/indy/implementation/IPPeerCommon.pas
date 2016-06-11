{*******************************************************}
{                                                       }
{              Delphi Indy Implementation               }
{                                                       }
{ Copyright(c) 1995-2014 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{$HPPEMIT LINKUNIT}
{$IFDEF MACOS}
  (*$HPPEMIT '#if defined(__APPLE__) && !defined(_NO_PRAGMA_LINK_INDY)' *)
  (*$HPPEMIT ' #ifndef USEPACKAGES' *)
  (*$HPPEMIT '  #pragma link "IndyCore.a"' *)
  (*$HPPEMIT '  #pragma link "IndyProtocols.a"' *)
  (*$HPPEMIT '  #pragma link "IndySystem.a"' *)
  (*$HPPEMIT ' #else' *)
  (*$HPPEMIT '  #pragma link "IndyCore.bpi"' *)
  (*$HPPEMIT '  #pragma link "IndyProtocols.bpi"' *)
  (*$HPPEMIT '  #pragma link "IndySystem.bpi"' *)
  (*$HPPEMIT ' #endif' *)
  (*$HPPEMIT '#endif' *)
{$ELSE} //Win32, Win64
  (*$HPPEMIT '#if !defined(_NO_PRAGMA_LINK_INDY)' *)
  (*$HPPEMIT ' #ifndef USEPACKAGES' *) //static
  {$IFDEF WIN64}
    (*$HPPEMIT '  #pragma link "IndyCore.a"' *)
    (*$HPPEMIT '  #pragma link "IndyProtocols.a"' *)
    (*$HPPEMIT '  #pragma link "IndySystem.a"' *)
  {$ELSE}
    (*$HPPEMIT '  #pragma link "IndyCore.lib"' *)
    (*$HPPEMIT '  #pragma link "IndyProtocols.lib"' *)
    (*$HPPEMIT '  #pragma link "IndySystem.lib"' *)
  {$ENDIF}
  (*$HPPEMIT ' #else' *)
  (*$HPPEMIT '  #pragma link "IndyCore.bpi"' *)
  (*$HPPEMIT '  #pragma link "IndyProtocols.bpi"' *)
  (*$HPPEMIT '  #pragma link "IndySystem.bpi"' *)
  (*$HPPEMIT ' #endif' *)
  (*$HPPEMIT '#endif' *)
{$ENDIF}

unit IPPeerCommon;

interface

type
  TIdClassIP = class(TInterfacedObject)
  private
    FIsFreed: Boolean;
  protected
    procedure SetDestroyed;
    function NeedToFree: Boolean;
  public
    procedure AfterConstruction; override;
  end;

function IPImpId: string;

implementation

uses
  System.Classes, System.SysUtils,
  IdHeaderList, IdIOHandler, IdSocketHandle, IdIOHandlerSocket,
  IdBuffer, 
{$IF not Defined(NEXTGEN) or not Defined(MSWINDOWS)}
  IdSSLOpenSSL, IdSSLOpenSSLHeaders, 
{$ENDIF}  
  IdGlobalProtocols, IdGlobal,
  IdFips, IdUri, IdMultipartFormData,
  IdCoderMIME,
  IdHashMessageDigest,
  IdHMACSHA1,


  IPPeerResStrs, IPPeerAPI; //put last because we have some type names identical to indy ones in here

type
  TIdMultipartFormDataStreamPeer = class(TInterfacedObject, IIPMultipartFormDataStream, IIPObject)
  private
    FStream: TIdMultipartFormDataStream;
    FInstanceOwner: Boolean;
  public
    constructor Create;
    destructor Destroy; override;
    function GetObject: TObject;
    function GetIPImplementationID: string;
    procedure AddFormField(const AFieldName, AFieldValue: string);
    // Pass False to take ownership of the stream
    function GetStream(AInstanceOwner: Boolean): TStream;
  end;

  TIdHeaderListPeer = class(TInterfacedObject, IIPHeaderList, IIPObject)
  private
    FList: TIdHeaderList;
  protected
    function GetFoldLines: Boolean;
    procedure SetFoldLines(Val: Boolean);
    function GetValue(const Name: string): string;
    procedure SetValue(const Name: string; Val: string);
    function Add(const S: string): Integer;
    function IndexOfName(const AName: string): Integer;
    function GetCount: Integer;
    function GetName(Index: Integer): string;
  public
    function GetObject: TObject;
    function GetIPImplementationID: string;
    procedure Clear;
    procedure AddValue(const AName, AValue: string);
    constructor Create(HeaderList: TIdHeaderList);
  end;
  
{$IF not Defined(NEXTGEN) or not Defined(MSWINDOWS)}
  TIdSSLOptionsPeer = class(TInterfacedObject, IIPSSLOptions, IIPObject)
  private
    FOptions: TIdSSLOptions;
  protected
    function GetVerifyMode: TIPSSLVerifyModeSetPeer;
    procedure SetVerifyMode(mode: TIPSSLVerifyModeSetPeer);
    function GetCertFile: string;
    procedure SetCertFile(ctfile: string);
    function GetKeyFile: string;
    procedure SetKeyFile(kfile: string);
    function GetRootCertFile: string;
    procedure SetRootCertFile(rootfile: string);
    function GetMode: TIPSSLModePeer;
    procedure SetMode(mode: TIPSSLModePeer);
    function GetMethod: TIPSSLVersionPeer;
    procedure SetMethod(method: TIPSSLVersionPeer);
  public
    function GetObject: TObject;
    function GetIPImplementationID: string;
    constructor Create(Options: TIdSSLOptions);
  end;
{$ENDIF}  

  TIdSocketHandlePeer = class(TInterfacedObject, IIPSocketHandle, IIPObject)
  private
    FHandle: TIdSocketHandle;
  protected
    function GetIP: string;
    procedure SetIP(const AIP: string);
    function GetPort: TIPPortPeer;
    procedure SetPort(APort: TIPPortPeer);
    function GetIPVersion: TIPVersionPeer;
    procedure SetIPVersion(const Value: TIPVersionPeer);
    function GetHandle: TIPStackSocketHandlePeer;
    function GetPeerIP: string;
    function GetPeerPort: TIPPortPeer;
  public
    function GetObject: TObject;
    function GetIPImplementationID: string;
    constructor Create(Handle: TIdSocketHandle);
  end;

  TIdIOHandlerPeerIP = class(TInterfacedObject, IIPIOHandler, IIPObject)
  private
    FHandler: TIdIOHandler;
    FBuffer: IIPBuffer;
  protected
    procedure Close;
    function ReadByte: Byte;
    function GetInputBuffer: IIPBuffer;
    procedure ReadBytes(var VBuffer: TIPBytesPeer; AByteCount: Integer; AAppend: Boolean = True);
    procedure ReadStream(const AStream: TStream; const AByteCount: Int64 = -1; AReadUntilDisconnect: Boolean = False);
    procedure Write(const ABuffer: TIPBytesPeer; const ALength: Integer = -1; const AOffset: Integer = 0); overload;
    procedure Write(const AStream: TStream; const ASize: Int64 = 0; AWriteByteCount: Boolean = False); overload;

    function WriteFile(const AFile: string; AEnableTransferFile: Boolean = False): Int64;

    function CheckForDataOnSource(ATimeout: Integer = 0): Boolean;
    function Connected: Boolean;
  public
    function GetObject: TObject;
    function GetIPImplementationID: string;
    constructor Create(Handler: TIdIOHandler);
  end;

  TIdIOHandlerSocketPeer = class(TIdIOHandlerPeerIP, IIPIOHandlerSocket, IIPObject)
  private
    FHandler: TIdIOHandlerSocket;
    FBinding: IIPSocketHandle;
  protected
    function GetBinding: IIPSocketHandle;
  public
    function GetObject: TObject;
    function GetIPImplementationID: string;
    constructor Create(Handler: TIdIOHandlerSocket);
  end;

{$IF not Defined(NEXTGEN) or not Defined(MSWINDOWS)}
  TIdSSLIOHandlerSocketOpenSSLIP = class(TIdSSLIOHandlerSocketOpenSSL)
  private
    FSetDestroyedProc: procedure of object;
  public
    destructor Destroy; override;
  end;

  TIdSSLIOHandlerSocketOpenSSLPeer = class(TIdIOHandlerSocketPeer, IIPSSLIOHandlerSocketOpenSSL, IIPSSLIOHandlerSocketBase, IIPObject)
  { TIdClassIP }
  private
    FIsFreed: Boolean;
    procedure SetDestroyed;
    function NeedToFree: Boolean;
  public
    procedure AfterConstruction; override;
  { TIdClassIP End }
  private
    FHandler: TIdSSLIOHandlerSocketOpenSSL;
    FSSLOptions: IIPSSLOptions;
    FOnVerifyPeer: TVerifyPeerEventPeer;
    FIdX509Peer: IIPX509;
    function LOnVerifyPeerEvent(Certificate: TIdX509; AOk: Boolean; ADepth, AError: Integer): Boolean;
  protected
    function GetOnVerifyPeer: TVerifyPeerEventPeer;
    procedure SetOnVerifyPeer(OnVerify: TVerifyPeerEventPeer);
    function GetSSLOptions: IIPSSLOptions;
    procedure SetSSLOptions(options: IIPSSLOptions);
    function GetPassThrough: Boolean;
    procedure SetPassThrough(pass: Boolean);
  public
    function GetObject: TObject;
    function GetIPImplementationID: string;
    constructor Create(AOwner: TComponent); overload;
    constructor Create(AIdSSLIOHandlerSocketOpenSSL: TIdSSLIOHandlerSocketOpenSSL); overload;
    destructor Destroy; override;
  end;
{$ENDIF}
  
  TIdBufferPeer = class(TInterfacedObject, IIPBuffer, IIPObject)
  private
    FBuffer: TIdBuffer;
  protected
    function GetSize: Integer;
  public
    function GetObject: TObject;
    function GetIPImplementationID: string;
    constructor Create(Buffer: TIdBuffer);
  end;

{$IF not Defined(NEXTGEN) or not Defined(MSWINDOWS)}
  TIdX509IP = class(TIdX509)
  private
    FSetDestroyedProc: procedure of object;
  public
    destructor Destroy; override;
  end;

  TIdX509Peer = class(TIdClassIP, IIPX509, IIPObject)
  private
    FObj: TIdX509IP;
    FIssuer: IIPX509Name;
    FSigInfo: IIPX509SigInfo;
    FSubject: IIPX509Name;
  protected
    function GetNotAfter: TDateTime;
    function GetNotBefore: TDateTime;
    function GetIssuer: IIPX509Name;
    function GetSubject: IIPX509Name;
    function GetSerialNumber: string;
    function GetSigInfo: IIPX509SigInfo;
    function GetVersion: TIPC_LONG;
    function GetEncoded: TArray<Byte>;
    function GetBasicConstraints: Integer;
    function GetKeyAlgorithm: string;
    function GetEncodedKey: TArray<Byte>;
    function GetKeyFormat: string;
    function Verify(Root: IIPX509): Boolean;
  public
    function GetObject: TObject;
    function GetIPImplementationID: string;
    constructor Create(aX509: PX509Peer; aCanFreeX509: Boolean = True);
    destructor Destroy; override;
  end;

  TIdX509NamePeer = class(TInterfacedObject, IIPX509Name, IIPObject)
  private
    FName: TIdX509Name;
  protected
    function GetHash: TIPSSLULong;
    function GetOneLine: string;
  public
    function GetObject: TObject;
    function GetIPImplementationID: string;
    constructor Create(Name: TIdX509Name);
  end;

  TIdX509SigInfoPeer = class(TInterfacedObject, IIPX509SigInfo, IIPObject)
  private
    FSigInfo: TIdX509SigInfo;
  protected
    function GetSigTypeAsString: string;
    function GetSignature: string;
  public
    function GetObject: TObject;
    function GetIPImplementationID: string;
    constructor Create(SigInfo: TIdX509SigInfo);
  end;
  
  TIdProc = class(TInterfacedObject, IIPPeerProcs)
  public
    function RSA_PKCS1_PADDING: Integer;
    procedure _RSA_free(Ptr: PRSAPeer);
    function _RSA_generate_key(bits: TIPC_INT; e: TIPC_ULONG): PRSAPeer;
    function _i2d_RSAPublicKey(x: PRSAPeer; buf: PPByte): TIPC_INT;
    function _d2i_RSAPublicKey(pr: PRSAPeer; _in :PPByte; len: TIPC_INT): PRSAPeer;
    function _SSLLoad: Boolean;
    procedure _ERR_load_crypto_strings;
    procedure _OpenSSL_add_all_ciphers;
    function _RSA_size(key: PRSAPeer): TIPC_INT;
    function _RSA_private_decrypt(flen: TIPC_INT; from: PByte; _to: PByte; rsa: PRSAPeer; padding: TIPC_INT): TIPC_INT;
    function _RSA_public_encrypt(flen: TIPC_INT; from: PByte; _to: PByte; rsa: PRSAPeer; padding: TIPC_INT): TIPC_INT;
    function _ERR_error_string(e: TIPC_ULONG; buf: TPtrWrapper): TPtrWrapper;
    function _ERR_get_error: TIPC_ULONG;
    function _d2i_X509(pr: PX509Peer; _in: PPByte; len: TIPC_INT): PX509Peer;
    function _PEM_read_bio_X509(mp: Pointer; size: Int64): PX509Peer;
    function _d2i_PKCS12_bio(mp: Pointer; size: Int64; certpassword: string): PX509Peer;
    function URLEncode(const ASrc: string): string;
    function URLDecode(ASrc: string; AByteEncoding: IIPTextEncodingPeer = nil): string;
    function ReadStringAsCharset(AStream: TStream; const ACharset: string): string;
    function ParamsEncode(const ASrc: string; AByteEncoding: IIPTextEncodingPeer = nil): string;
    function ReadStringFromStream(AStream: TStream; ASize: Integer = -1; AByteEncoding: IIPTextEncodingPeer = nil): string;
    function GMTToLocalDateTime(S: string): TDateTime;
    function IsHMACSHA256Avail: Boolean;
    function GetHMACSHA256HashInst(const AKey: TIPBytesPeer): TIPHMACIntCtx;
    function HashSHA256(const AData: TIPBytesPeer): TIPBytesPeer;
    procedure UpdateHMACInst(ACtx: TIPHMACIntCtx; const AIn: TIPBytesPeer);
    function FinalHMACInst(ACtx: TIPHMACIntCtx): TIPBytesPeer;
    function IsHMACSHA1Avail: Boolean;
    function GetHMACSHA1HashInst(const AKey: TIPBytesPeer): TIPHMACIntCtx; // requires SSL
    function HashHMACSHA1(const AData, AKey: string): string; // no SSL requirement
    function HashStringAsHex(const AValue: string): string;
  end;
{$ENDIF}

{ TIdClassIP }

procedure TIdClassIP.AfterConstruction;
begin
  inherited;
  FIsFreed := False;
end;

function TIdClassIP.NeedToFree: Boolean;
begin
  Result := not FIsFreed;
end;

procedure TIdClassIP.SetDestroyed;
begin
  FIsFreed := True;
end;

{ TIdBufferPeer }

constructor TIdBufferPeer.Create(Buffer: TIdBuffer);
begin
  FBuffer := Buffer;
end;

function TIdBufferPeer.GetIPImplementationID: string;
begin
  Result := IPImpId;
end;

function TIdBufferPeer.GetObject: TObject;
begin
  Result := FBuffer;
end;

function TIdBufferPeer.GetSize: Integer;
begin
  Result := FBuffer.Size;
end;

{$IF not Defined(NEXTGEN) or not Defined(MSWINDOWS)}
{ TIdX509IP }

destructor TIdX509IP.Destroy;
begin
  //Let Peer know that object is destroyed
  if Assigned(FSetDestroyedProc) then
    FSetDestroyedProc();
  inherited;
end;

{ TIdX509Peer }

constructor TIdX509Peer.Create(aX509: PX509Peer; aCanFreeX509: Boolean);
begin
  FIssuer := nil;
  FSigInfo := nil;
  FSubject := nil;
  FObj := TIdX509IP.Create(aX509, aCanFreeX509);
  FObj.FSetDestroyedProc := SetDestroyed;
end;

destructor TIdX509Peer.Destroy;
begin
  if NeedToFree then
    FObj.Free;
  inherited;
end;

function TIdX509Peer.GetBasicConstraints: Integer;
begin
  Result := -1;
end;

function TIdX509Peer.GetEncoded: TArray<Byte>;
var
  Len: Integer;
  BufPtr: PByte;
begin
  BufPtr := nil;
  Len := i2d_X509(FObj.FX509, @BufPtr);
  Result := BytesOf(BufPtr, Len);
end;

function TIdX509Peer.GetEncodedKey: TArray<Byte>;
begin
  Result := BytesOf(FObj.FX509.cert_info.key.public_key.data, FObj.FX509.cert_info.key.public_key.length);
end;

function TIdX509Peer.GetIPImplementationID: string;
begin
  Result := IPImpId;
end;

function TIdX509Peer.GetIssuer: IIPX509Name;
begin
  if FObj.Issuer = nil then
    Result := nil
  else if Assigned(FIssuer) and (FIssuer.GetObject = FObj.Issuer) then
    Result := FIssuer
  else
  begin
    Result := TIdX509NamePeer.Create(FObj.Issuer);
    FIssuer := Result;
  end;
end;

function TIdX509Peer.GetKeyAlgorithm: string;
begin
  Result := string(OBJ_nid2ln(OBJ_obj2nid(FObj.FX509.cert_info.key.algor.algorithm)));
end;

function TIdX509Peer.GetKeyFormat: string;
begin
  Result := 'DER';
end;

function TIdX509Peer.GetNotAfter: TDateTime;
begin
  Result := FObj.notAfter;
end;

function TIdX509Peer.GetNotBefore: TDateTime;
begin
  Result := FObj.notBefore;
end;

function TIdX509Peer.GetObject: TObject;
begin
  Result := FObj;
end;

function TIdX509Peer.GetSerialNumber: string;
begin
  Result := FObj.SerialNumber;
end;

function TIdX509Peer.GetSigInfo: IIPX509SigInfo;
begin
  if FObj.SigInfo = nil then
    Result := nil
  else if Assigned(FSigInfo) and (FSigInfo.GetObject = FObj.SigInfo) then
    Result := FSigInfo
  else
  begin
    Result := TIdX509SigInfoPeer.Create(FObj.SigInfo);
    FSigInfo := Result;
  end;
end;

function TIdX509Peer.GetSubject: IIPX509Name;
begin
  if FObj.Subject = nil then
    Result := nil
  else if Assigned(FSubject) and (FSubject.GetObject = FObj.Subject) then
    Result := FSubject
  else
  begin
    Result := TIdX509NamePeer.Create(FObj.Subject);
    FSubject := Result;
  end;
end;

function TIdX509Peer.GetVersion: TIPC_LONG;
begin
  Result := FObj.Version;
end;

function TIdX509Peer.Verify(Root: IIPX509): Boolean;
var
  PubKey: PEVP_PKEY;
begin
  PubKey := nil;
  Result := false;
  try
  PubKey := X509_PUBKEY_get(TIdX509IP(Root.GetObject).FX509.cert_info.key);
    if not Assigned(PubKey) then
      raise EIPPeerException.Create(sPublicKeyNotObtained);
  Result := X509_verify(FObj.FX509, PubKey) > 0;
  finally
    if Assigned(PubKey) then
  EVP_PKEY_free(PubKey);
end;
end;

{ TIdX509NamePeer }

constructor TIdX509NamePeer.Create(Name: TIdX509Name);
begin
  FName := Name;
end;

function TIdX509NamePeer.GetHash: TIPSSLULong;
begin
  with FName.Hash do
  begin
    Result.B1 := B1;
    Result.B2 := B2;
    Result.B3 := B3;
    Result.B4 := B4;
    Result.W1 := W1;
    Result.W2 := W2;
    Result.L1 := L1;
    Result.C1 := C1;
  end;
end;

function TIdX509NamePeer.GetIPImplementationID: string;
begin
  Result := IPImpId;
end;

function TIdX509NamePeer.GetObject: TObject;
begin
  Result := FName;
end;

function TIdX509NamePeer.GetOneLine: string;
begin
  Result := FName.OneLine;
end;

{ TIdX509SigInfoPeer }

constructor TIdX509SigInfoPeer.Create(SigInfo: TIdX509SigInfo);
begin
  FSigInfo := SigInfo;
end;

function TIdX509SigInfoPeer.GetIPImplementationID: string;
begin
  Result := IPImpId;
end;

function TIdX509SigInfoPeer.GetObject: TObject;
begin
  Result := FSigInfo;
end;

function TIdX509SigInfoPeer.GetSignature: string;
begin
  Result := FSigInfo.Signature;
end;

function TIdX509SigInfoPeer.GetSigTypeAsString: string;
begin
  Result := FSigInfo.SigTypeAsString;
end;
{$ENDIF}

{ TIdIOHandlerPeerIP }

function TIdIOHandlerPeerIP.CheckForDataOnSource(ATimeout: Integer): Boolean;
begin
  Result := FHandler.CheckForDataOnSource(ATimeout);
end;

procedure TIdIOHandlerPeerIP.Close;
begin
  FHandler.Close;
end;

function TIdIOHandlerPeerIP.Connected: Boolean;
begin
  Result := FHandler.Connected;
end;

constructor TIdIOHandlerPeerIP.Create(Handler: TIdIOHandler);
begin
  FBuffer := nil;
  FHandler := Handler;
end;

function TIdIOHandlerPeerIP.GetInputBuffer: IIPBuffer;
begin
  if FHandler.InputBuffer = nil then
    Result := nil
  else if Assigned(FBuffer) and (FBuffer.GetObject = FHandler.InputBuffer) then
    Result := FBuffer
  else
  begin
    Result := TIdBufferPeer.Create(FHandler.InputBuffer);
    FBuffer := Result;
  end;
end;

function TIdIOHandlerPeerIP.GetIPImplementationID: string;
begin
  Result := IPImpId;
end;

function TIdIOHandlerPeerIP.GetObject: TObject;
begin
  Result := FHandler;
end;

function TIdIOHandlerPeerIP.ReadByte: Byte;
begin
  Result := FHandler.ReadByte;
end;

procedure TIdIOHandlerPeerIP.ReadBytes(var VBuffer: TIPBytesPeer; AByteCount: Integer;
  AAppend: Boolean);
begin
  FHandler.ReadBytes(TIdBytes(VBuffer), AByteCount, AAppend);
end;

procedure TIdIOHandlerPeerIP.ReadStream(const AStream: TStream; const AByteCount: Int64; AReadUntilDisconnect: Boolean);
begin
  FHandler.ReadStream(AStream, AByteCount, AReadUntilDisconnect);
end;

procedure TIdIOHandlerPeerIP.Write(const AStream: TStream; const ASize: Int64; AWriteByteCount: Boolean);
begin
  FHandler.Write(AStream, ASize, AWriteByteCount);
end;

procedure TIdIOHandlerPeerIP.Write(const ABuffer: TIPBytesPeer; const ALength,
  AOffset: Integer);
begin
  FHandler.Write(TIdBytes(ABuffer), ALength, AOffset);
end;

function TIdIOHandlerPeerIP.WriteFile(const AFile: string; AEnableTransferFile: Boolean): Int64;
begin
  Result := FHandler.WriteFile(AFile, AEnableTransferFile);
end;

{ TIdIOHandlerSocketPeer }

constructor TIdIOHandlerSocketPeer.Create(Handler: TIdIOHandlerSocket);
begin
  inherited Create(Handler);
  FBinding := nil;
  FHandler := Handler;
end;

function TIdIOHandlerSocketPeer.GetBinding: IIPSocketHandle;
begin
  if FHandler.Binding = nil then
    Result := nil
  else if Assigned(FBinding) and (FBinding.GetObject = FHandler.Binding) then
    Result := FBinding
  else
  begin
    Result := TIdSocketHandlePeer.Create(FHandler.Binding);
    FBinding := Result;
  end;
end;

function TIdIOHandlerSocketPeer.GetIPImplementationID: string;
begin
  Result := IPImpId;
end;

function TIdIOHandlerSocketPeer.GetObject: TObject;
begin
  Result := FHandler;
end;

{$IF not Defined(NEXTGEN) or not Defined(MSWINDOWS)}
{ TIdSSLIOHandlerSocketOpenSSLIP }

destructor TIdSSLIOHandlerSocketOpenSSLIP.Destroy;
begin
  //Let Peer know that object is destroyed
  if Assigned(FSetDestroyedProc) then
    FSetDestroyedProc();
  inherited;
end;

{ TIdSSLIOHandlerSocketOpenSSLPeer }

procedure TIdSSLIOHandlerSocketOpenSSLPeer.AfterConstruction;
begin
  inherited;
  FIsFreed := False;
end;

constructor TIdSSLIOHandlerSocketOpenSSLPeer.Create(AOwner: TComponent);
begin
  FSSLOptions := nil;
  FOnVerifyPeer := nil;
  FIdX509Peer := nil;
  FHandler := TIdSSLIOHandlerSocketOpenSSLIP.Create(AOwner);
  TIdSSLIOHandlerSocketOpenSSLIP(FHandler).FSetDestroyedProc := SetDestroyed;
  inherited Create(FHandler);
end;

constructor TIdSSLIOHandlerSocketOpenSSLPeer.Create(
  AIdSSLIOHandlerSocketOpenSSL: TIdSSLIOHandlerSocketOpenSSL);
begin
  FSSLOptions := nil;
  FOnVerifyPeer := nil;
  FIdX509Peer := nil;
  FHandler := AIdSSLIOHandlerSocketOpenSSL;
  inherited Create(FHandler);
end;

destructor TIdSSLIOHandlerSocketOpenSSLPeer.Destroy;
begin
  //Clear interface references (TODO: check order of nil'ing)
  FSSLOptions := nil;

  if NeedToFree and Assigned(FHandler) and (FHandler is TIdSSLIOHandlerSocketOpenSSLIP) then
    FHandler.Free;
  inherited;
end;

function TIdSSLIOHandlerSocketOpenSSLPeer.GetIPImplementationID: string;
begin
  Result := IPImpId;
end;

function TIdSSLIOHandlerSocketOpenSSLPeer.GetObject: TObject;
begin
  Result := FHandler;
end;

function TIdSSLIOHandlerSocketOpenSSLPeer.GetOnVerifyPeer: TVerifyPeerEventPeer;
begin
  if Assigned(FHandler.OnVerifyPeer) then
    Result := FOnVerifyPeer
  else
    Result := nil;
end;

function TIdSSLIOHandlerSocketOpenSSLPeer.GetPassThrough: Boolean;
begin
  Result := FHandler.PassThrough;
end;

function TIdSSLIOHandlerSocketOpenSSLPeer.GetSSLOptions: IIPSSLOptions;
begin
  if FHandler.SSLOptions = nil then
    Result := nil
  else if Assigned(FSSLOptions) and (FSSLOptions.GetObject = FHandler.SSLOptions) then
    Result := FSSLOptions
  else
  begin
    Result := TIdSSLOptionsPeer.Create(FHandler.SSLOptions);
    FSSLOptions := Result;
  end;
end;

procedure TIdSSLIOHandlerSocketOpenSSLPeer.SetDestroyed;
begin
  FIsFreed := True;
end;

procedure TIdSSLIOHandlerSocketOpenSSLPeer.SetOnVerifyPeer(
  OnVerify: TVerifyPeerEventPeer);
begin
  FOnVerifyPeer := OnVerify;
  FHandler.OnVerifyPeer := LOnVerifyPeerEvent;
end;

procedure TIdSSLIOHandlerSocketOpenSSLPeer.SetPassThrough(pass: Boolean);
begin
  FHandler.PassThrough := pass;
end;

procedure TIdSSLIOHandlerSocketOpenSSLPeer.SetSSLOptions(
  options: IIPSSLOptions);
begin
  FHandler.SSLOptions := options.GetObject as TIdSSLOptions;
  FSSLOptions := options;
end;

function TIdSSLIOHandlerSocketOpenSSLPeer.LOnVerifyPeerEvent(Certificate: TIdX509;
  AOk: Boolean; ADepth, AError: Integer): Boolean;
begin
  Result := False;
  if Assigned(FOnVerifyPeer) then
  begin
    FIdX509Peer := TIdX509Peer.Create(TIdX509IP(Certificate).FX509, False);
    Result := FOnVerifyPeer(FIdX509Peer, AOk, ADepth, AError);
  end;
end;

function TIdSSLIOHandlerSocketOpenSSLPeer.NeedToFree: Boolean;
begin
  Result := not FIsFreed;
end;
{$ENDIF}

{ TIdHeaderListPeer }

function TIdHeaderListPeer.Add(const S: string): Integer;
begin
  Result := FList.Add(S);
end;

procedure TIdHeaderListPeer.AddValue(const AName, AValue: string);
begin
  FList.AddValue(AName, AValue);
end;

procedure TIdHeaderListPeer.Clear;
begin
  FList.Clear;
end;

constructor TIdHeaderListPeer.Create(HeaderList: TIdHeaderList);
begin
  FList := HeaderList;
end;

function TIdHeaderListPeer.GetCount: Integer;
begin
  Result := FList.Count;
end;

function TIdHeaderListPeer.GetFoldLines: Boolean;
begin
  Result := FList.FoldLines;
end;

function TIdHeaderListPeer.GetIPImplementationID: string;
begin
  Result := IPImpId;
end;

function TIdHeaderListPeer.GetName(Index: Integer): string;
begin
  Result := FList.Names[Index];
end;

function TIdHeaderListPeer.GetObject: TObject;
begin
  Result := FList;
end;

function TIdHeaderListPeer.GetValue(const Name: string): string;
begin
  Result := FList.Values[Name];
end;

function TIdHeaderListPeer.IndexOfName(const AName: string): Integer;
begin
  Result := FList.IndexOfName(AName);
end;

procedure TIdHeaderListPeer.SetFoldLines(Val: Boolean);
begin
  FList.FoldLines := Val;
end;

procedure TIdHeaderListPeer.SetValue(const Name: string; Val: string);
begin
  FList.Values[Name] := Val;
end;

{$IF not Defined(NEXTGEN) or not Defined(MSWINDOWS)}
{ TIdSSLOptionsPeer }

constructor TIdSSLOptionsPeer.Create(Options: TIdSSLOptions);
begin
  FOptions := Options;
end;

function TIdSSLOptionsPeer.GetCertFile: string;
begin
  Result := FOptions.CertFile;
end;

function TIdSSLOptionsPeer.GetIPImplementationID: string;
begin
  Result := IPImpId;
end;

function TIdSSLOptionsPeer.GetKeyFile: string;
begin
  Result := FOptions.KeyFile;
end;

function TIdSSLOptionsPeer.GetMethod: TIPSSLVersionPeer;
begin
  case FOptions.Method of
    TIdSSLVersion.sslvSSLv2: Result := TIPSSLVersionPeer.sslvSSLv2;
    TIdSSLVersion.sslvSSLv23: Result := TIPSSLVersionPeer.sslvSSLv23;
    TIdSSLVersion.sslvSSLv3: Result := TIPSSLVersionPeer.sslvSSLv3;
    TIdSSLVersion.sslvTLSv1: Result := TIPSSLVersionPeer.sslvTLSv1;
    TIdSSLVersion.sslvTLSv1_1: Result := TIPSSLVersionPeer.sslvTLSv1_1;
    TIdSSLVersion.sslvTLSv1_2: Result := TIPSSLVersionPeer.sslvTLSv1_2;
  else raise EIPPeerException.Create(sUnexpectedMethodVersion);
  end;
end;

function TIdSSLOptionsPeer.GetMode: TIPSSLModePeer;
begin
  case FOptions.Mode of
    TIdSSLMode.sslmUnassigned: Result := TIPSSLModePeer.sslmUnassigned;
    TIdSSLMode.sslmClient: Result := TIPSSLModePeer.sslmClient;
    TIdSSLMode.sslmServer: Result := TIPSSLModePeer.sslmServer;
    TIdSSLMode.sslmBoth: Result := TIPSSLModePeer.sslmBoth;
  else raise EIPPeerException.Create(sUnexpectedMode);
  end;
end;

function TIdSSLOptionsPeer.GetObject: TObject;
begin
  Result := FOptions;
end;

function TIdSSLOptionsPeer.GetRootCertFile: string;
begin
  Result := FOptions.RootCertFile;
end;

function TIdSSLOptionsPeer.GetVerifyMode: TIPSSLVerifyModeSetPeer;
begin
  Result := [];
  if TIdSSLVerifyMode.sslvrfPeer in FOptions.VerifyMode then
    Result := Result + [TIPSSLVerifyModePeer.sslvrfPeer];
  if TIdSSLVerifyMode.sslvrfFailIfNoPeerCert in FOptions.VerifyMode then
    Result := Result + [TIPSSLVerifyModePeer.sslvrfFailIfNoPeerCert];
  if TIdSSLVerifyMode.sslvrfClientOnce in FOptions.VerifyMode then
    Result := Result + [TIPSSLVerifyModePeer.sslvrfClientOnce];
end;

procedure TIdSSLOptionsPeer.SetCertFile(ctfile: string);
begin
  FOptions.CertFile := ctfile;
end;

procedure TIdSSLOptionsPeer.SetKeyFile(kfile: string);
begin
  FOptions.KeyFile := kfile;
end;

procedure TIdSSLOptionsPeer.SetMethod(method: TIPSSLVersionPeer);
begin
  case method of
    sslvSSLv2: FOptions.Method := TIdSSLVersion.sslvSSLv2;
    sslvSSLv23: FOptions.Method := TIdSSLVersion.sslvSSLv23;
    sslvSSLv3: FOptions.Method := TIdSSLVersion.sslvSSLv3;
    sslvTLSv1: FOptions.Method := TIdSSLVersion.sslvTLSv1;
    sslvTLSv1_1: FOptions.Method := TIdSSLVersion.sslvTLSv1_1;
    sslvTLSv1_2: FOptions.Method := TIdSSLVersion.sslvTLSv1_2;
  end;
end;

procedure TIdSSLOptionsPeer.SetMode(mode: TIPSSLModePeer);
begin
  case mode of
    sslmUnassigned: FOptions.Mode := TIdSSLMode.sslmUnassigned;
    sslmClient: FOptions.Mode := TIdSSLMode.sslmClient;
    sslmServer: FOptions.Mode := TIdSSLMode.sslmServer;
    sslmBoth: FOptions.Mode := TIdSSLMode.sslmBoth;
  end;
end;

procedure TIdSSLOptionsPeer.SetRootCertFile(rootfile: string);
begin
  FOptions.RootCertFile := rootfile;
end;

procedure TIdSSLOptionsPeer.SetVerifyMode(mode: TIPSSLVerifyModeSetPeer);
begin
  FOptions.VerifyMode := [];
  if TIPSSLVerifyModePeer.sslvrfPeer in mode then
    FOptions.VerifyMode := FOptions.VerifyMode + [TIdSSLVerifyMode.sslvrfPeer];
  if TIPSSLVerifyModePeer.sslvrfFailIfNoPeerCert in mode then
    FOptions.VerifyMode := FOptions.VerifyMode + [TIdSSLVerifyMode.sslvrfFailIfNoPeerCert];
  if TIPSSLVerifyModePeer.sslvrfClientOnce in mode then
    FOptions.VerifyMode := FOptions.VerifyMode + [TIdSSLVerifyMode.sslvrfClientOnce];
end;
{$ENDIF}

{ TIdSocketHandlePeer }

constructor TIdSocketHandlePeer.Create(Handle: TIdSocketHandle);
begin
  FHandle := Handle;
{$IFDEF LINUX64}
  if Handle <> nil then
    FHandle.ReuseSocket := rsTrue;
{$ENDIF}
end;

function TIdSocketHandlePeer.GetHandle: TIPStackSocketHandlePeer;
begin
  Result := FHandle.Handle;
end;

function TIdSocketHandlePeer.GetIP: string;
begin
  Result := FHandle.IP;
end;

function TIdSocketHandlePeer.GetIPImplementationID: string;
begin
  Result := IPImpId;
end;

function TIdSocketHandlePeer.GetIPVersion: TIPVersionPeer;
begin
  if FHandle.IPVersion = TIdIPVersion.Id_IPv6 then
    Result := TIPVersionPeer.IP_IPv6
  else
    Result := TIPVersionPeer.IP_IPv4; //default
end;

function TIdSocketHandlePeer.GetObject: TObject;
begin
  Result := FHandle;
end;

function TIdSocketHandlePeer.GetPeerIP: string;
begin
  Result := FHandle.PeerIP;
end;

function TIdSocketHandlePeer.GetPeerPort: TIPPortPeer;
begin
  Result := FHandle.PeerPort;
end;

function TIdSocketHandlePeer.GetPort: TIPPortPeer;
begin
  Result := FHandle.Port;
end;

procedure TIdSocketHandlePeer.SetIP(const AIP: string);
begin
  FHandle.IP := AIP;
end;

procedure TIdSocketHandlePeer.SetIPVersion(const Value: TIPVersionPeer);
begin
  if Value = TIPVersionPeer.IP_IPv4 then
    FHandle.IPVersion := TIdIPVersion.Id_IPv4
  else if Value = TIPVersionPeer.IP_IPv6 then
    FHandle.IPVersion := TIdIPVersion.Id_IPv6
end;

procedure TIdSocketHandlePeer.SetPort(APort: TIPPortPeer);
begin
  FHandle.Port := APort;
end;

{$IF not Defined(NEXTGEN) or not Defined(MSWINDOWS)}
{ TIdProc }

function TIdProc._d2i_RSAPublicKey(pr: PRSAPeer; _in : PPByte; len : TIPC_INT): PRSAPeer;
begin
  Result := d2i_RSAPublicKey(pr, IdSSLOpenSSLHeaders.PPByte(_in), len);
end;

function TIdProc._d2i_X509(pr: PX509Peer; _in: PPByte; len: TIPC_INT): PX509Peer;
begin
  Result := d2i_X509(pr, IdSSLOpenSSLHeaders.PPByte(_in), len);
  if not Assigned(Result) then
    raise EIPPeerException.CreateFmt(sCertificateNotLoaded, [ERR_reason_error_string(ERR_get_error)]);
end;

function TIdProc._PEM_read_bio_X509(mp: Pointer; size: Int64): PX509Peer;
var
  Lin: PBIO;
begin
  Result := nil;
  Lin := BIO_new_mem_buf(mp, size);
  try
    if not Assigned(Lin) then begin
      raise EIPPeerException.CreateFmt(sCertificateNotLoaded, [ERR_reason_error_string(ERR_get_error)]);
    end;
    Result := PEM_read_bio_X509(Lin, nil, nil, nil);
  finally
    BIO_free(Lin);
  end;
  if not Assigned(Result) then
    raise EIPPeerException.CreateFmt(sCertificateNotLoaded, [ERR_reason_error_string(ERR_get_error)]);
end;

function TIdProc._d2i_PKCS12_bio(mp: Pointer; size: Int64; certpassword: string ): PX509Peer;
var
  P12: PPKCS12;
  Lin: PBIO;
  PKey: PEVP_PKEY;
  CertChain: PSTACK_OF_X509;
  LCert: PX509;
  M: TMarshaller;
begin
  LCert:= nil;
  Lin := BIO_new_mem_buf(mp, size);
  try
    if not Assigned(Lin) then begin
      raise EIPPeerException.CreateFmt(sCertificateNotLoaded, [ERR_reason_error_string(ERR_get_error)]);
    end;
    PKey := nil;
    CertChain := nil;
    P12 := d2i_PKCS12_bio(Lin, nil);
    if not Assigned(P12) then
      raise EIPPeerException.CreateFmt(sCertificateNotLoaded, [ERR_reason_error_string(ERR_get_error)]);
    try
      if PKCS12_parse(P12, M.AsAnsi(certpassword).ToPointer, PKey, LCert, @CertChain) <> 1 then
        raise EIPPeerException.CreateFmt(sCertificateNotLoaded, [ERR_reason_error_string(ERR_get_error)]);
    finally
      PKCS12_free(P12);
      EVP_PKEY_free(PKey);
    end;
  finally
    BIO_free(Lin);
  end;
  Result:= LCert;
  if not Assigned(Result) then
    raise EIPPeerException.CreateFmt(sCertificateNotLoaded, [ERR_reason_error_string(ERR_get_error)]);
end;


function TIdProc._ERR_error_string(e: TIPC_ULONG;
  buf: TPtrWrapper): TPtrWrapper;
begin
  Result := TPtrWrapper.Create(ERR_error_string(e, buf.ToPointer));
end;

function TIdProc._ERR_get_error: TIPC_ULONG;
begin
  Result := ERR_get_error;
end;

procedure TIdProc._ERR_load_crypto_strings;
begin
  ERR_load_crypto_strings;
end;

function TIdProc._i2d_RSAPublicKey(x:PRSAPeer; buf: PPByte): TIPC_INT;
begin
  Result := i2d_RSAPublicKey(x, IdSSLOpenSSLHeaders.PPByte(buf));
end;

procedure TIdProc._OpenSSL_add_all_ciphers;
begin
  OpenSSL_add_all_ciphers;
end;

procedure TIdProc._RSA_free(Ptr: PRSAPeer);
begin
  RSA_free(Ptr);
end;

function TIdProc._RSA_generate_key(bits: TIPC_INT;
  e: TIPC_ULONG): PRSAPeer;
var
  Exponent: PBIGNUM;
  LRSA: PRSA;
begin
  Result := nil;
  if Assigned(RSA_generate_key) then
    Result := RSA_generate_key(bits, e, nil, nil)
  else if Assigned(RSA_generate_key_ex) then
  begin
    Exponent := BN_new;
    try
      BN_set_word(Exponent, e);
      LRSA := RSA_new;
      RSA_generate_key_ex(LRSA, bits, Exponent, nil);
      Result := LRSA;
    finally
      BN_free(Exponent);
    end;
  end
  else
    raise EIPPeerException.Create(sKeyGenerationNotLoaded);
end;

function TIdProc._RSA_private_decrypt(flen: TIPC_INT;
  from, _to: PByte; rsa: PRSAPeer; padding: TIPC_INT): TIPC_INT;
begin
  Result := RSA_private_decrypt(flen, from, _to, rsa, padding);
end;

function TIdProc._RSA_public_encrypt(flen: TIPC_INT;
  from, _to: PByte; rsa: PRSAPeer; padding: TIPC_INT): TIPC_INT;
begin
  Result := RSA_public_encrypt(flen, from, _to, rsa, padding);
end;

function TIdProc._RSA_size(key: PRSAPeer): TIPC_INT;
begin
  Result := RSA_size(key);
end;

function TIdProc._SSLLoad: Boolean;
begin
  Result := Load;
end;

function TIdProc.FinalHMACInst(ACtx: TIPHMACIntCtx): TIPBytesPeer;
begin
  Result := TIPBytesPeer(IdFips.FinalHMACInst(ACtx));
end;

function TIdProc.GetHMACSHA1HashInst(const AKey: TIPBytesPeer): TIPHMACIntCtx;
begin
  Result := IdFIPS.GetHMACSHA1HashInst(TIdBytes(AKey));
end;

function TIdProc.GetHMACSHA256HashInst(const AKey: TIPBytesPeer): TIPHMACIntCtx;
begin
  Result := IdFIPS.GetHMACSHA256HashInst(TIdBytes(AKey));
end;

function TIdProc.HashSHA256(const AData: TIPBytesPeer): TIPBytesPeer;
var
  Lctx : TIdHashIntCtx;
begin
  Lctx := IdFIPS.GetSHA256HashInst;
  IdFIPS.UpdateHashInst(Lctx, TIdBytes(AData));
  Result := TIPBytesPeer(IdFIPS.FinalHashInst(Lctx));
end;


function TIdProc.GMTToLocalDateTime(S: string): TDateTime;
begin
  Result := IdGlobalProtocols.GMTToLocalDateTime(S)
end;

function TIdProc.HashHMACSHA1(const AData, AKey: string): string;
var
  LHMACSHA1: TIdHMACSHA1;
begin
  LHMACSHA1 := TIdHMACSHA1.Create;
  try
    LHMACSHA1.Key := ToBytes(AKey);
    result := TIdEncoderMIME.EncodeBytes(LHMACSHA1.HashValue(ToBytes(AData)));
  finally
    LHMACSHA1.Free;
  end;
end;

function TIdProc.HashStringAsHex(const AValue: string): string;
var
  LMD5: TIdHashMessageDigest;
begin
  LMD5 := TIdHashMessageDigest5.Create;
  try
    Result := LMD5.HashStringAsHex(AValue);
  finally
    LMD5.Free;
  end;
end;

function TIdProc.IsHMACSHA1Avail: Boolean;
begin
  Result := IdFips.IsHMACSHA1Avail;
end;

function TIdProc.IsHMACSHA256Avail: Boolean;
begin
  Result := IdFIPS.IsHMACSHA256Avail;
end;

function TIdProc.ParamsEncode(const ASrc: string;
  AByteEncoding: IIPTextEncodingPeer): string;
var
  LEncoding: IIdTextEncoding;
begin
  if (AByteEncoding = nil) or Supports(AByteEncoding, IIdTextEncoding, LEncoding) then
    Result := TIdUri.ParamsEncode(ASrc, LEncoding)
  else
    raise EIPPeerException.Create(sNotIdEncodingIntf)
end;

function TIdProc.ReadStringAsCharset(AStream: TStream;
  const ACharset: string): string;
begin
  Result := IdGlobalProtocols.ReadStringAsCharset(AStream, ACharset);
end;

function TIdProc.ReadStringFromStream(AStream: TStream; ASize: Integer; AByteEncoding: IIPTextEncodingPeer): string;
var
  LEncoding: IIdTextEncoding;
begin
  if (AByteEncoding = nil) or Supports(AByteEncoding, IIdTextEncoding, LEncoding) then
    Result := IdGlobal.ReadStringFromStream(AStream, ASize, LEncoding)
  else
    raise EIPPeerException.Create(sNotIdEncodingIntf)
end;

function TIdProc.RSA_PKCS1_PADDING: Integer;
begin
  Result := IdSSLOpenSSLHeaders.RSA_PKCS1_PADDING;
end;

procedure TIdProc.UpdateHMACInst(ACtx: TIPHMACIntCtx; const AIn: TIPBytesPeer);
begin
  IdFIPS.UpdateHMACInst(ACtx, TIdBytes(AIn));
end;

function TIdProc.URLDecode(ASrc: string;
  AByteEncoding: IIPTextEncodingPeer): string;
var
  LEncoding: IIdTextEncoding;
begin
  if (AByteEncoding = nil) or Supports(AByteEncoding, IIdTextEncoding, LEncoding) then
    Result := TIdURI.URLDecode(ASrc, LEncoding)
  else
    raise EIPPeerException.Create(sNotIdEncodingIntf)
end;

function TIdProc.URLEncode(const ASrc: string): string;
begin
  Result := TIdURI.URLEncode(ASrc);
end;
{$ENDIF}

function IPImpId: string;
begin
  Result := '';
end;

{ TIdMultipartFormDataStreamPeer }

procedure TIdMultipartFormDataStreamPeer.AddFormField(const AFieldName,
  AFieldValue: string);
begin
  FStream.AddFormField(AFieldName, AFieldValue)
end;

constructor TIdMultipartFormDataStreamPeer.Create;
begin
  inherited;
  FStream := TIdMultipartFormDataStream.Create;
  FInstanceOwner := True;
end;

destructor TIdMultipartFormDataStreamPeer.Destroy;
begin
  if FInstanceOwner then
    FStream.Free;
  inherited;
end;

function TIdMultipartFormDataStreamPeer.GetIPImplementationID: string;
begin
  Result := IPImpId;
end;

function TIdMultipartFormDataStreamPeer.GetObject: TObject;
begin
  Result := FStream;
end;

function TIdMultipartFormDataStreamPeer.GetStream(
  AInstanceOwner: Boolean): TStream;
begin
  FInstanceOwner := AInstanceOwner;
  Result := FStream;
end;

initialization
{$IF not Defined(NEXTGEN) or not Defined(MSWINDOWS)}
  PeerFactory.RegisterPeer(IPImpId, IIPPeerProcs, TIdProc);
  PeerFactory.RegisterPeer(IPImpId, IIPX509, TIdX509Peer);
  PeerFactory.RegisterPeer(IPImpId, IIPSSLOptions, TIdSSLOptionsPeer);
  PeerFactory.RegisterPeer(IPImpId, IIPSSLIOHandlerSocketOpenSSL, TIdSSLIOHandlerSocketOpenSSLPeer);
{$ENDIF}  
  PeerFactory.RegisterPeer(IPImpId, IIPHeaderList, TIdHeaderListPeer);
  PeerFactory.RegisterPeer(IPImpId, IIPSocketHandle, TIdSocketHandlePeer);
  PeerFactory.RegisterPeer(IPImpId, IIPIOHandler, TIdIOHandlerPeerIP);
  PeerFactory.RegisterPeer(IPImpId, IIPIOHandlerSocket, TIdIOHandlerSocketPeer);
  PeerFactory.RegisterPeer(IPImpId, IIPMultipartFormDataStream, TIdMultipartFormDataStreamPeer);

finalization
{$IF not Defined(NEXTGEN) or not Defined(MSWINDOWS)}
  PeerFactory.UnregisterPeerClass(IPImpId, TIdProc);
  PeerFactory.UnregisterPeerClass(IPImpId, TIdSSLOptionsPeer);
  PeerFactory.UnregisterPeerClass(IPImpId, TIdSSLIOHandlerSocketOpenSSLPeer);
{$ENDIF}  
  PeerFactory.UnregisterPeerClass(IPImpId, TIdHeaderListPeer);
  PeerFactory.UnregisterPeerClass(IPImpId, TIdSocketHandlePeer);
  PeerFactory.UnregisterPeerClass(IPImpId, TIdIOHandlerPeerIP);
  PeerFactory.UnregisterPeerClass(IPImpId, TIdIOHandlerSocketPeer);
  PeerFactory.UnregisterPeerClass(IPImpId, TIdMultipartFormDataStreamPeer);
  PeerFactory.UnregisterPeers(IPImpId);

end.
