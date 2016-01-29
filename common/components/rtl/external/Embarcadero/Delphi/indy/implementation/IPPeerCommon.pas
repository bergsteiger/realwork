{*******************************************************}
{                                                       }
{              Delphi Indy Implementation               }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{$HPPEMIT '#pragma link "IPPeerCommon"'}    {Do not Localize}
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
  IdBuffer, IdSSLOpenSSL, IdSSLOpenSSLHeaders, IdGlobalProtocols, IdGlobal,
  IdFips, IdUri,

  IPPeerResStrs, IPPeerAPI; //put last because we have some type names identical to indy ones in here

type
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

  TIdSocketHandlePeer = class(TInterfacedObject, IIPSocketHandle, IIPObject)
  private
    FHandle: TIdSocketHandle;
  protected
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
    procedure Write(const ABuffer: TIPBytesPeer; const ALength: Integer = -1; const AOffset: Integer = 0);
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

  TIdSSLIOHandlerSocketOpenSSLIP = class(TIdSSLIOHandlerSocketOpenSSL)
  private
    FSetDestroyedProc: TProc;
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

  TIdX509IP = class(TIdX509)
  private
    FSetDestroyedProc: TProc;
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
    function URLEncode(const ASrc: string): string;
    function URLDecode(ASrc: string; AByteEncoding: IIPTextEncodingPeer = nil): string;
    function ReadStringAsCharset(AStream: TStream; const ACharset: string): string;
    function ParamsEncode(const ASrc: string; AByteEncoding: IIPTextEncodingPeer = nil): string;
    function ReadStringFromStream(AStream: TStream; ASize: Integer = -1; AByteEncoding: IIPTextEncodingPeer = nil): string;
    function GMTToLocalDateTime(S: string): TDateTime;
    function IsHMACSHA256Avail: Boolean;
    function GetHMACSHA256HashInst(const AKey: TIPBytesPeer): TIPHMACIntCtx;
    procedure UpdateHMACInst(ACtx: TIPHMACIntCtx; const AIn: TIPBytesPeer);
    function FinalHMACInst(ACtx: TIPHMACIntCtx): TIPBytesPeer;
    function IsHMACSHA1Avail: Boolean;
    function GetHMACSHA1HashInst(const AKey: TIPBytesPeer): TIPHMACIntCtx;
  end;

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

procedure TIdIOHandlerPeerIP.Write(const ABuffer: TIPBytesPeer; const ALength,
  AOffset: Integer);
begin
  FHandler.Write(TIdBytes(ABuffer), ALength, AOffset);
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
    FIdX509Peer := TIdX509Peer.Create(Certificate, False);
    Result := FOnVerifyPeer(FIdX509Peer, AOk, ADepth, AError);
  end;
end;

function TIdSSLIOHandlerSocketOpenSSLPeer.NeedToFree: Boolean;
begin
  Result := not FIsFreed;
end;

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
  else raise EIPPeerException.Create('Unexpected method version found');
  end;
end;

function TIdSSLOptionsPeer.GetMode: TIPSSLModePeer;
begin
  case FOptions.Mode of
    TIdSSLMode.sslmUnassigned: Result := TIPSSLModePeer.sslmUnassigned;
    TIdSSLMode.sslmClient: Result := TIPSSLModePeer.sslmClient;
    TIdSSLMode.sslmServer: Result := TIPSSLModePeer.sslmServer;
    TIdSSLMode.sslmBoth: Result := TIPSSLModePeer.sslmBoth;
  else raise EIPPeerException.Create('Unexpected mode found');
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

{ TIdSocketHandlePeer }

constructor TIdSocketHandlePeer.Create(Handle: TIdSocketHandle);
begin
  FHandle := Handle;
end;

function TIdSocketHandlePeer.GetHandle: TIPStackSocketHandlePeer;
begin
  Result := FHandle.Handle;
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

{ TIdProc }

function TIdProc._d2i_RSAPublicKey(pr: PRSAPeer; _in : PPByte; len : TIPC_INT): PRSAPeer;
begin
  Result := d2i_RSAPublicKey(pr, IdSSLOpenSSLHeaders.PPByte(_in), len);
end;

function TIdProc._d2i_X509(pr: PX509Peer; _in: PPByte; len: TIPC_INT): PX509Peer;
begin
  Result := d2i_X509(pr, IdSSLOpenSSLHeaders.PPByte(_in), len);
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
begin
  Result := RSA_generate_key(bits, e, nil, nil);
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

function TIdProc.GMTToLocalDateTime(S: string): TDateTime;
begin
  Result := IdGlobalProtocols.GMTToLocalDateTime(S)
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

function IPImpId: string;
begin
  Result := '';
end;

initialization
  PeerFactory.RegisterPeer(IPImpId, IIPPeerProcs, TIdProc);
  PeerFactory.RegisterPeer(IPImpId, IIPX509, TIdX509Peer);
  PeerFactory.RegisterPeer(IPImpId, IIPHeaderList, TIdHeaderListPeer);
  PeerFactory.RegisterPeer(IPImpId, IIPSSLOptions, TIdSSLOptionsPeer);
  PeerFactory.RegisterPeer(IPImpId, IIPSocketHandle, TIdSocketHandlePeer);
  PeerFactory.RegisterPeer(IPImpId, IIPIOHandler, TIdIOHandlerPeerIP);
  PeerFactory.RegisterPeer(IPImpId, IIPIOHandlerSocket, TIdIOHandlerSocketPeer);
  PeerFactory.RegisterPeer(IPImpId, IIPSSLIOHandlerSocketOpenSSL, TIdSSLIOHandlerSocketOpenSSLPeer);

finalization
  PeerFactory.UnregisterPeerClass(IPImpId, TIdProc);
  PeerFactory.UnregisterPeerClass(IPImpId, TIdX509Peer);
  PeerFactory.UnregisterPeerClass(IPImpId, TIdHeaderListPeer);
  PeerFactory.UnregisterPeerClass(IPImpId, TIdSSLOptionsPeer);
  PeerFactory.UnregisterPeerClass(IPImpId, TIdSocketHandlePeer);
  PeerFactory.UnregisterPeerClass(IPImpId, TIdIOHandlerPeerIP);
  PeerFactory.UnregisterPeerClass(IPImpId, TIdIOHandlerSocketPeer);
  PeerFactory.UnregisterPeerClass(IPImpId, TIdSSLIOHandlerSocketOpenSSLPeer);
  PeerFactory.UnregisterPeers(IPImpId);

end.
