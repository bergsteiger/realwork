unit Certificate;

interface

uses
  Windows, SysUtils, Classes, JwaWinCrypt, JwaWinType, Dialogs;

const
  MY_TYPE =  (PKCS_7_ASN_ENCODING or X509_ASN_ENCODING);
  
  CRYPT_E_SELF_SIGNED = $80092007;
  CRYPT_E_REVOKED = $80092010;
  CRYPT_E_NO_REVOCATION_DLL = $80092011;
  CRYPT_E_NO_REVOCATION_CHECK = $80092012;
  CRYPT_E_REVOCATION_OFFLINE = $80092013;
  CRYPT_E_NOT_IN_REVOCATION_DATABASE = $80092014;    
  
type      
  TgtPDCertificate = class;

  TgtPDCertificateStore = class
  private
    FStoreHandle: HCERTSTORE;
    FCertificates: TStringList;
    constructor Create; overload;
    function AquireKeyContainer(AContainedName: String): HCRYPTPROV;
    procedure EnumCertificates;
  public
    constructor Create(ACertStore: String); overload;
    constructor Create(APFXFileName, APassword: String); overload;
    destructor Destroy; override;
    function OpenStore(ACertStore: String): Boolean; overload;
    function OpenStore(APFXFileName, APassword: String): Boolean; overload;
    function RemoveCertificate(ACertificate: TgtPDCertificate): Boolean;
    function GetCertificateByName(ACertName: String): TgtPDCertificate;
    function GetNextCertificate(): TgtPDCertificate;
    function GetCertificateByHash(ACertHash: CRYPT_INTEGER_BLOB):
      TgtPDCertificate;
    function CreateSelfSignedCertificate(AName, AOrganizationUnit, AOrganization,
      AEmail, ALocale: String; ANotBefore, ANotAfter: TDateTime): TgtPDCertificate;
    property StoreHandle: HCERTSTORE read FStoreHandle;
    property Certificates: TStringList read FCertificates;
  end;

  TgtChainStatus = (csNoError, csNoTimeValid, csNotTimeNested, csTrustIsRevoked,
     csNoSignatureValid, csNotValidForUsage, csUntrustedRoot, csRevStatusUnknown,
     csIsCyclic, csIsPartialChain );

  TgtRevocationStatus = (rsNoRevCheck, rsNoRevDLL, rsNotInRevDB, rsRevoked,
      rsSuccess);

  TgtPDCertificateChain = class
  private
    FChainsCount: Integer;
    FChainHandle: PCCERT_CHAIN_CONTEXT;
    FChainStatus: TgtChainStatus;
    FCertificates: array of Integer;
    function GetCertificatesCount(Index: Integer): Integer;
    procedure MapChainStatus;
  public
    constructor Create(ACertContext: PCCERT_CHAIN_CONTEXT);
    destructor Destroy; override;
    function Validate(): Integer;  //Integrity check
    function GetCertificate(AChainIndex, ACertificateIndex: Integer): TgtPDCertificate;
    property ChainHandle: PCCERT_CHAIN_CONTEXT read FChainHandle;
    property ChainsCount: Integer read FChainsCount;
    property ChainStatus: TgtChainStatus read FChainStatus;
    property CertificatesCount[Index: Integer]: Integer read GetCertificatesCount;
  end;

  TgtPDCertificate = class
  private
    FCertificateHandle: PCCERT_CONTEXT;
    FCertificateHash: CRYPT_INTEGER_BLOB;
    FCertificateChain: TgtPDCertificateChain;
    procedure SetCertificateHandle(const Value: PCCERT_CONTEXT);
    function GetCertificateChain: TgtPDCertificateChain;
  public
    constructor Create(certContext: PCCERT_CONTEXT); overload;
    constructor Create(URL: String); overload;
    destructor Destroy; override;
    function IsSelfSigned: Boolean;
    function GetIssuerCertificate(): TgtPDCertificate;
    function IsInTrustedROOTStore: Boolean;
    function AddToTrust: Boolean;
    function ValidateTime(ADateTime: TDateTime = 0): Integer;
    function ValidateWithIssuer(AIssuerCert: TgtPDCertificate): Integer;
    function Validate: Integer;

    function VerifyRevocation: Boolean;

    property CertificateHandle: PCCERT_CONTEXT read FCertificateHandle write
     SetCertificateHandle;
    property CertificateHash: CRYPT_INTEGER_BLOB read FCertificateHash;
    property CertificateChain: TgtPDCertificateChain read GetCertificateChain;
  end;

implementation

uses DateUtils;

{ TgtPDCertificate }

constructor TgtPDCertificate.Create(certContext: PCCERT_CONTEXT);
var
  HashBlob: CRYPT_INTEGER_BLOB;
begin
  inherited Create;
  try
    FCertificateHandle := certContext;

    //To read the HASH of the data
    GetMem(HashBlob.pbData, 20);
    CertGetCertificateContextProperty(certContext, CERT_HASH_PROP_ID, HashBlob.pbData,
      HashBlob.cbData);
    FCertificateHash := HashBlob;
    FCertificateChain := nil;
  except on E: Exception do;
  end;
end;

destructor TgtPDCertificate.Destroy;
begin
  if FCertificateHandle <> nil then
    CertFreeCertificateContext(FCertificateHandle);
  FreeMem(FCertificateHash.pbData, FCertificateHash.cbData);

  if FCertificateChain <> nil then
    FCertificateChain.Free;
end;

procedure TgtPDCertificate.SetCertificateHandle(const Value: PCCERT_CONTEXT);
var
  HashBlob: CRYPT_INTEGER_BLOB;
begin
  try
    if FCertificateHandle <> nil then
      CertFreeCertificateContext(FCertificateHandle);

    FCertificateHandle := Value;
    GetMem(HashBlob.pbData, 20);
    CertGetCertificateContextProperty(Value, CERT_HASH_PROP_ID,
      HashBlob.pbData, HashBlob.cbData);
    FCertificateHash := HashBlob;
  except on E: Exception do;
  end;
end;

function TgtPDCertificate.Validate: Integer;
var
  LLastError: Integer;
begin
  Result := 1;

  if CryptVerifyCertificateSignatureEx(0, X509_ASN_ENCODING,
    CRYPT_VERIFY_CERT_SIGN_SUBJECT_CERT, FCertificateHandle,
    CRYPT_VERIFY_CERT_SIGN_ISSUER_CERT , FCertificateHandle, 0, nil) then
  begin
    Result := 0;
  end
  else
  begin
    LLastError := GetLastError;
    if LLastError =  NTE_BAD_SIGNATURE then    //Bad signature
      Result := -1;
  end;
end;

function TgtPDCertificate.ValidateTime(ADateTime: TDateTime): Integer;
var
  LTime: Windows.TFILETIME;
  LSystemTime: TSystemTime;
begin
  if ADateTime <> 0 then
  begin
    with LSystemTime do
    begin
     DecodeDateTime(ADateTime, wYear, wMonth, wDay, wHour, wMinute, wSecond,
      wMilliSeconds);
    end;
    SystemTimeToFileTime(LSystemTime, LTime);
    Result := CertVerifyTimeValidity(@LTime, FCertificateHandle.pCertInfo);
  end
  else
    Result := CertVerifyTimeValidity(nil, FCertificateHandle.pCertInfo);
end;

function TgtPDCertificate.VerifyRevocation: Boolean;
var
  LRevStatus: CERT_REVOCATION_STATUS;

  LChainContext: PCCERT_CHAIN_CONTEXT;
  LCertContexts: array of PVOID;
  LI, LJ : Integer;

begin
  Result := True;
  try
    LChainContext := CertificateChain.FChainHandle;
    for LI := 0 to LChainContext.cChain do
    begin
      SetLength(LCertContexts, LChainContext.rgpChain[LI].cElement);

      for LJ := 0 to LChainContext.rgpChain[LI].cElement -1 do
        LCertContexts[LJ] := LChainContext.rgpChain[LI].rgpElement[LJ].pCertContext;

      LRevStatus.cbSize := SizeOf(CERT_REVOCATION_STATUS);
      CertVerifyRevocation(MY_TYPE, CERT_CONTEXT_REVOCATION_TYPE,
        LChainContext.rgpChain[LI].cElement,
        @LCertContexts[0], CERT_VERIFY_REV_CHAIN_FLAG, nil, @LRevStatus);

      Showmessage(Inttostr(LRevStatus.dwError));
      if LRevStatus.dwError = 2148081680 then
      begin
        Result := False;
        Exit;
      end;
    end;
  except on Exception do;
  end;

end;

function TgtPDCertificate.BuildCertChain: TgtPDCertificateChain;
var
  LChainEngine: HCERTCHAINENGINE;
  LChainConfig: CERT_CHAIN_ENGINE_CONFIG;
  pChainContext: PCCERT_CHAIN_CONTEXT;
  EnhkeyUsage: CERT_ENHKEY_USAGE;
  CertUsage: CERT_USAGE_MATCH;
  ChainPara: CERT_CHAIN_PARA;
begin
  Result := nil;
  EnhkeyUsage.cUsageIdentifier := 0;
  EnhkeyUsage.rgpszUsageIdentifier := nil;

  CertUsage.dwType := USAGE_MATCH_TYPE_AND;
  CertUsage.Usage  := EnhkeyUsage;
  ChainPara.cbSize := sizeof(CERT_CHAIN_PARA);

  ChainPara.RequestedUsage := CertUsage;

  LChainConfig.cbSize := sizeof(CERT_CHAIN_ENGINE_CONFIG);
  LChainConfig.hRestrictedRoot := nil ;
  LChainConfig.hRestrictedTrust := nil ;
  LChainConfig.hRestrictedOther := nil ;
  LChainConfig.cAdditionalStore := 0 ;
  LChainConfig.rghAdditionalStore := nil ;
  LChainConfig.dwFlags := CERT_CHAIN_CACHE_END_CERT;
  LChainConfig.dwUrlRetrievalTimeout := 0 ;
  LChainConfig.MaximumCachedCertificates :=0 ;
  LChainConfig.CycleDetectionModulus := 0;

  if not CertCreateCertificateChainEngine(@LChainConfig, LChainEngine) then
  begin
      Exit;
  end;


  if not CertGetCertificateChain(
      0,                  // use the default chain engine
      FCertificateHandle,          // pointer to the end certificate
      nil,                  // use the default time
      nil,                  // search no additional stores
      @ChainPara,            // use AND logic and enhanced key usage
                             //  as indicated in the ChainPara
                             //  data structure
      0,
      nil,                  // currently reserved
      @pChainContext)       // return a pointer to the chain created
  then
  begin
      Exit;
  end;

 if pChainContext <> nil then
    Result := TgtPDCertificateChain.Create(pChainContext);
  CertFreeCertificateChainEngine(LChainEngine);
end;

function TgtPDCertificate.AddToTrust: Boolean;
var
  LStore: HCERTSTORE;
begin
  LStore := CertOpenSystemStore(0, 'ROOT');
  Result := CertAddCertificateContextToStore(LStore, FCertificateHandle,
                 CERT_STORE_ADD_NEW, nil);
  CertCloseStore(LStore, 0);
end;

function TgtPDCertificate.IsSelfSigned: Boolean;
var
  pIssuerCert: PCCERT_CONTEXT;
  dwFlags: DWORD;
  LLastError : DWORD;
begin
  Result := False;
  dwFlags := 0;
  pIssuerCert := nil;

  pIssuerCert := CertGetIssuerCertificateFromStore(FCertificateHandle.hCertStore,
    FCertificateHandle, nil, dwFlags);
  LLastError := GetLastError;
  //If the Issuer cert is nil and dwFlags is zero then it could be self signed
  if LLastError = CRYPT_E_SELF_SIGNED then
    Result := True;
  if pIssuerCert <> nil then
    CertFreeCertificateContext(pIssuerCert);
end;

function TgtPDCertificate.GetIssuerCertificate: TgtPDCertificate;
var
  pIssuerCert: PCCERT_CONTEXT;
  dwFlags: DWORD;
  LLastError : DWORD;
begin
  Result := nil;
  dwFlags := 0;
  pIssuerCert := nil;

  pIssuerCert := CertGetIssuerCertificateFromStore(FCertificateHandle.hCertStore,
    FCertificateHandle, nil, dwFlags);
  LLastError := GetLastError;

  if pIssuerCert <> nil then
  begin
    Result := TgtPDCertificate.Create(pIssuerCert);
  end;
end;

function TgtPDCertificate.IsInTrustedROOTStore: Boolean;
var
  pCert: PCCERT_CONTEXT;
  LStore: TgtPDCertificateStore;
begin
  Result := False;
  LStore := TgtPDCertificateStore.Create('ROOT');
  pCert := CertFindCertificateInStore(LStore.FStoreHandle,
         MY_TYPE, 0, CERT_FIND_SHA1_HASH, @FCertificateHash, nil);
  LStore.Free;
  if pCert <> nil then
  begin
    Result := True;
    CertFreeCertificateContext(pCert);
  end;
end;

function TgtPDCertificate.ValidateWithIssuer(AIssuerCert: TgtPDCertificate): Integer;
var
  LLastError: Integer;
begin
  if CryptVerifyCertificateSignatureEx(0, X509_ASN_ENCODING,
    CRYPT_VERIFY_CERT_SIGN_SUBJECT_CERT, FCertificateHandle,
    CRYPT_VERIFY_CERT_SIGN_ISSUER_CERT, AIssuerCert.CertificateHandle, 0, nil) then
  begin
    Result := 0;
  end
  else
  begin
    LLastError := GetLastError;
    if LLastError =  NTE_BAD_SIGNATURE then    //Bad signature
      Result := -1;
  end;

end;

function TgtPDCertificate.GetCertificateChain: TgtPDCertificateChain;
var
  LChainEngine: HCERTCHAINENGINE;
  LChainConfig: CERT_CHAIN_ENGINE_CONFIG;
  pChainContext: PCCERT_CHAIN_CONTEXT;
  EnhkeyUsage: CERT_ENHKEY_USAGE;
  CertUsage: CERT_USAGE_MATCH;
  ChainPara: CERT_CHAIN_PARA;
begin
  if FCertificateChain = nil then
  begin
    Result := nil;
    EnhkeyUsage.cUsageIdentifier := 0;
    EnhkeyUsage.rgpszUsageIdentifier := nil;

    CertUsage.dwType := USAGE_MATCH_TYPE_AND;
    CertUsage.Usage  := EnhkeyUsage;
    ChainPara.cbSize := sizeof(CERT_CHAIN_PARA);

    ChainPara.RequestedUsage := CertUsage;

    LChainConfig.cbSize := sizeof(CERT_CHAIN_ENGINE_CONFIG);
    LChainConfig.hRestrictedRoot := nil ;
    LChainConfig.hRestrictedTrust := nil ;
    LChainConfig.hRestrictedOther := nil ;
    LChainConfig.cAdditionalStore := 0 ;
    LChainConfig.rghAdditionalStore := nil ;
    LChainConfig.dwFlags := CERT_CHAIN_CACHE_END_CERT;
    LChainConfig.dwUrlRetrievalTimeout := 0 ;
    LChainConfig.MaximumCachedCertificates :=0 ;
    LChainConfig.CycleDetectionModulus := 0;

    if not CertCreateCertificateChainEngine(@LChainConfig, LChainEngine) then
    begin
        Exit;
    end;


    if not CertGetCertificateChain(
        0,                  // use the default chain engine
        FCertificateHandle,          // pointer to the end certificate
        nil,                  // use the default time
        nil,                  // search no additional stores
        @ChainPara,            // use AND logic and enhanced key usage
                               //  as indicated in the ChainPara
                               //  data structure
        0,
        nil,                  // currently reserved
        @pChainContext)       // return a pointer to the chain created
    then
    begin
        Exit;
    end;

   if pChainContext <> nil then
      FCertificateChain := TgtPDCertificateChain.Create(pChainContext);
    CertFreeCertificateChainEngine(LChainEngine);
  end ;
  Result := FCertificateChain;
end;

constructor TgtPDCertificate.Create(URL: String);
var
  HashBlob: CRYPT_INTEGER_BLOB;
begin
  inherited Create;
  try
    if CryptRetrieveObjectByUrl(PAnsiChar(URL), CONTEXT_OID_CERTIFICATE, CRYPT_WIRE_ONLY_RETRIEVAL,
    50000, LPVOID(FCertificateHandle), 0, nil, nil, nil) then
    begin

      //To read the HASH of the data
      GetMem(HashBlob.pbData, 20);
      CertGetCertificateContextProperty(FCertificateHandle, CERT_HASH_PROP_ID, HashBlob.pbData,
        HashBlob.cbData);
      FCertificateHash := HashBlob;
      FCertificateChain := nil;
    end
    else
      FCertificateHandle := nil;
   except on E: Exception do;
   end;
end;

{ TgtPDCertificateStore }

constructor TgtPDCertificateStore.Create(ACertStore: String);
begin
  Create;
  OpenStore(ACertStore);
end;

constructor TgtPDCertificateStore.Create;
begin
  inherited;
  FCertificates := TStringList.Create;
end;

constructor TgtPDCertificateStore.Create(APFXFileName, APassword: String);
begin
  Create;
  OpenStore(APFXFileName, APassword);
end;

destructor TgtPDCertificateStore.Destroy;
begin
  if FStoreHandle <> nil then
    CertCloseStore(FStoreHandle, 0);
  if FCertificates <> nil then
    FCertificates.Free;
  inherited;
end;

function TgtPDCertificateStore.GetCertificateByHash(
  ACertHash: CRYPT_INTEGER_BLOB): TgtPDCertificate;
var
  pCert: PCCERT_CONTEXT;
begin
  if  FStoreHandle <> nil then
  begin
    pCert := CertFindCertificateInStore(FStoreHandle, MY_TYPE, 0,
      CERT_FIND_SHA1_HASH, @ACertHash, nil);
  end;
  Result := TgtPDCertificate.Create(pCert);
end;

function TgtPDCertificateStore.GetCertificateByName(
  ACertName: String): TgtPDCertificate;
var
  pCert: PCCERT_CONTEXT;
begin
  if  FStoreHandle <> nil then
  begin
    pCert := CertFindCertificateInStore(
       FStoreHandle,
       MY_TYPE,
       0,
       CERT_FIND_SUBJECT_STR_A,
       @ACertName[1],
       nil);
  end;

  Result := TgtPDCertificate.Create(pCert);
end;

function TgtPDCertificateStore.OpenStore(ACertStore: String): Boolean;
begin
  Result := False;
  if FStoreHandle <> nil then
    CertCloseStore(FStoreHandle, 0);
  FStoreHandle := CertOpenSystemStore(0, @ACertStore[1]);
  if FStoreHandle <> nil then
    Result := True;
  EnumCertificates;
end;

function TgtPDCertificateStore.GetNextCertificate: TgtPDCertificate;
var
  pCert: PCCERT_CONTEXT;
begin
  Result := nil;
  if  FStoreHandle <> nil then
  begin
    pCert := CertFindCertificateInStore(
       FStoreHandle,
       MY_TYPE,
       0,
       CERT_FIND_ANY,
       nil,
       nil);
  end;  
  if pCert <> nil then
    Result := TgtPDCertificate.Create(pCert); 
end;

function TgtPDCertificateStore.OpenStore(APFXFileName,
  APassword: String): Boolean;
var
  hFileHandle, hMapFile: THandle;
  pfx: Pointer;
  PFXBlob: CRYPT_DATA_BLOB;
  IsRecognizedPFX: Boolean;
begin
  Result := False;
  if FStoreHandle <> nil then
    CertCloseStore(FStoreHandle, 0);

  hMapFile := 0;
  pfx := nil;
  IsRecognizedPFX := False;
  hFileHandle := CreateFile(PAnsiChar(APFXFileName), GENERIC_READ, FILE_SHARE_READ,
                     nil, OPEN_EXISTING, 0, 0);

  // now, we create a file mapping object for that file
  if hFileHandle <> 0 then
    hMapFile := CreateFileMapping(hFileHandle, nil, PAGE_READONLY, 0, 0, nil);

  // we map a view of the file that we previously opened into pfx
  if hMapFile <> 0 then
    pfx := MapViewOfFile(hMapFile, FILE_MAP_READ, 0, 0, 0);

  // and with that view we make a blob ...
  if ((hFileHandle <> 0) and (pfx <> nil)) then
  begin
    PFXBlob.cbData   := GetFileSize(hFileHandle, nil);
    PFXBlob.pbData   := PBYTE(pfx);
  end;

  try
    // ... and after we try to decode that blob to see whether
    // pfx is recognized...
    if (PFXIsPFXBlob(@PFXBlob)) then
      IsRecognizedPFX := True;

  except on E: Exception do;
  end;

  if (IsRecognizedPFX) then
  begin
     // We import the certificate store from the blob. I needed it
    // to be exportable...
    FStoreHandle := PFXImportCertStore(@PFXBlob, PWideChar(WideString(APassword)),
      CRYPT_MACHINE_KEYSET or CRYPT_EXPORTABLE);
  end;

  if FStoreHandle <> nil then
    Result := True;

  EnumCertificates;

  if pfx <> nil then
    UnmapViewOfFile(pfx);
  if hMapFile <> 0 then
    CloseHandle(hMapFile);
  if hFileHandle <> 0 then
    CloseHandle(hFileHandle); 
end;

function TgtPDCertificateStore.RemoveCertificate(
  ACertificate: TgtPDCertificate): Boolean;
begin
  if ACertificate <> nil then
    Result := CertDeleteCertificateFromStore(ACertificate.FCertificateHandle);
  ACertificate.Free;
end;

function TgtPDCertificateStore.CreateSelfSignedCertificate(AName,
  AOrganizationUnit, AOrganization, AEmail, ALocale: String; ANotBefore,
  ANotAfter: TDateTime): TgtPDCertificate;
var
  pCert: PCCERT_CONTEXT;
  LCryptProv: HCRYPTPROV;
  certName: CERT_NAME_BLOB;
  CertNameString: String;
  cbCertNameSize: DWORD;
  startTime, endTime: TSystemTime;
  cryptAlgID: CRYPT_ALGORITHM_IDENTIFIER;
  LStore: HCERTSTORE;
  dwKeySpec: DWORD;
begin
  try
    Result := nil;
    LCryptProv := AquireKeyContainer(AName);

    CertNameString := 'CN=' +AName+', OU=' + AOrganizationUnit + ', O=' +
    AOrganization + ', E='+ AEmail + ', L='+ ALocale;

    if(CertStrToName(MY_TYPE, PAnsiChar(CertNameString),
      CERT_X500_NAME_STR, nil, nil, certName.cbData, nil)) then
    begin
      GetMem(certName.pbData, certName.cbData);
      if(CertStrToName(X509_ASN_ENCODING Or PKCS_7_ASN_ENCODING, PAnsiChar(CertNameString), CERT_X500_NAME_STR,
      nil, certName.pbData, certName.cbData, nil)) then
      begin
        with startTime do
        begin
          DecodeDate(ANotBefore, wYear, wMonth, wDay);
          wHour :=  12;
          wSecond  :=  10;
        end;
        with endTime do
        begin
          DecodeDate(ANotAfter, wYear, wMonth, wDay);
          wHour :=  12;
          wSecond  :=  10;
        end;


        cryptAlgID.pszObjId := szOID_RSA_SHA1RSA;
        pCert := CertCreateSelfSignCertificate(LCryptProv, @certName,
          0, nil, nil, @startTime, @endTime, nil);

        if (Result <> nil) then
        begin
          LStore := CertOpenSystemStore(0, 'MY');
          if CertAddCertificateContextToStore(LStore, pCert,
                 CERT_STORE_ADD_NEW, nil) then
          begin
            //Added
          end;
          CertCloseStore(LStore, 0);
        end;

        if pCert <> nil then
          Result := TgtPDCertificate.Create(pCert);
      end;
    end;
    CryptReleaseContext(LCryptProv,0) ;
  except on E: Exception do
  end;
end;

function AddCertToTrustedRoot(pCertContext: PCCERT_CONTEXT): Boolean;
var
  LStore: HCERTSTORE;
begin
  LStore := CertOpenSystemStore(0, 'ROOT');
  Result := CertAddCertificateContextToStore(LStore, pCertContext,
                 CERT_STORE_ADD_NEW, nil);
  CertCloseStore(LStore, 0);
end;

function GetPFXCertStore(pfxFileName: String; Password: string):HCERTSTORE;
var
  hFileHandle, hMapFile: THandle;
  pfx: Pointer;
  PFXBlob: CRYPT_DATA_BLOB;
  IsRecognizedPFX: Boolean;
begin
  Result := nil;
  hMapFile := 0;
  pfx := nil;
  IsRecognizedPFX := False;
  hFileHandle := CreateFile(PAnsiChar(pfxFileName), GENERIC_READ, FILE_SHARE_READ,
                     nil, OPEN_EXISTING, 0, 0);

  // now, we create a file mapping object for that file
  if hFileHandle <> 0 then
    hMapFile := CreateFileMapping(hFileHandle, nil, PAGE_READONLY, 0, 0, nil);

  // we map a view of the file that we previously opened into pfx
  if hMapFile <> 0 then
    pfx := MapViewOfFile(hMapFile, FILE_MAP_READ, 0, 0, 0);

  // and with that view we make a blob ...
  if ((hFileHandle <> 0) and (pfx <> nil)) then
  begin
    PFXBlob.cbData   := GetFileSize(hFileHandle, nil);
    PFXBlob.pbData   := PBYTE(pfx);
  end;

  try

    // ... and after we try to decode that blob to see whether
    // pfx is recognized...
    if (PFXIsPFXBlob(@PFXBlob)) then
      IsRecognizedPFX := True;

  except on E: Exception do;
  end;

  if (IsRecognizedPFX) then
  begin
                // We import the certificate store from the blob. I needed it
    // to be exportable...
    Result := PFXImportCertStore(@PFXBlob, PWideChar(WideString(Password)), CRYPT_MACHINE_KEYSET
      or CRYPT_EXPORTABLE);
  end;

  if pfx <> nil then
    UnmapViewOfFile(pfx);
  if hMapFile <> 0 then
    CloseHandle(hMapFile);
  if hFileHandle <> 0 then
    CloseHandle(hFileHandle); 

end;

function TgtPDCertificateStore.AquireKeyContainer(
  AContainedName: String): HCRYPTPROV;
var
  LCryptProv: HCRYPTPROV;
  hKey: HCRYPTKEY;
begin
  if CryptAcquireContext(LCryptProv, PAnsiChar(AContainedName), nil, PROV_RSA_FULL, 0) then
  begin
    //Aquired the existing container
  end
  else
  begin
    //if( GetLastError() = NTE_BAD_KEYSET) then
    begin
        if CryptAcquireContext(LCryptProv, PAnsiChar(AContainedName), nil,
          PROV_RSA_FULL, CRYPT_NEWKEYSET) then
        begin
          //new key context is acquired
        end
        else
        begin
        //Could not create a new key container.
        end;
    end;
  end;
  //NewKeyset or existing one is aquired.

  //Now check if the signature key is available.
  if CryptGetUserKey(LCryptProv, AT_SIGNATURE, hKey) then
  begin
      //A signature key is available.
  end
  else
  begin
    //No signature key is available.
    //if(GetLastError() = NTE_NO_KEY) then
    begin
      //-------------------------------------------------------
      // The error was that there is a container but no key.

      // Create a signature key pair.
      //The signature key does not exist.
      //Create a signature key pair.
      if CryptGenKey(LCryptProv, AT_SIGNATURE, 0, hKey) then
      begin
        //Created a signature key pair.
      end
      else
      begin
          //Error occurred creating a ")
      end;
    end; // End if.

    //A signature key pair existed, or one was created

    // Destroy the signature key.
    if (hKey <> 0) then
    begin
      if(not (CryptDestroyKey(hKey))) then
      begin
         // Error during CryptDestroyKey
      end;
      hKey := 0;
    end;
  end;
  Result := LCryptProv;
end;

procedure TgtPDCertificateStore.EnumCertificates;
var
  CertContext: PCertContext;
  CertName:  array[0..255] of AnsiChar;
begin
  CertContext := CertEnumCertificatesInStore(FStoreHandle, nil);
  while CertContext <> nil do
  begin
    if CertGetNameString(CertContext, CERT_NAME_SIMPLE_DISPLAY_TYPE, 0, nil,
        CertName, 256) <> 0 then
      FCertificates.Add(CertName);
    CertContext := CertEnumCertificatesInStore(FStoreHandle, CertContext);
  end;
end;

{ TgtPDCertificateChain }

constructor TgtPDCertificateChain.Create(ACertContext: PCCERT_CHAIN_CONTEXT);
var
  LI : Integer;
begin
  inherited Create;
  FChainHandle := ACertContext;

  FChainsCount := FChainHandle.cChain;
  SetLength(FCertificates, FChainsCount);
  for LI := 0 to FChainsCount -1 do
    FCertificates[LI] := FChainHandle.rgpChain[LI].cElement;
  MapChainStatus;
end;

destructor TgtPDCertificateChain.Destroy;
begin
  if FChainHandle <> nil then
    CertFreeCertificateChain(FChainHandle);
  FChainHandle := nil;
  inherited;
end;

function TgtPDCertificateChain.GetCertificate(AChainIndex,
  ACertificateIndex: Integer): TgtPDCertificate;
var
  LCertContext : PCCERT_CONTEXT;
begin
  LCertContext := FChainHandle.rgpChain[AChainIndex].rgpElement[ACertificateIndex].pCertContext;
  if LCertContext <> nil then
    Result := TgtPDCertificate.Create(LCertContext);
end;

function TgtPDCertificateChain.GetCertificatesCount(Index: Integer): Integer;
begin
  Result := FCertificates[Index];
end;

procedure TgtPDCertificateChain.MapChainStatus;
begin
  case FChainHandle.TrustStatus.dwErrorStatus of
    CERT_TRUST_NO_ERROR:
      FChainStatus := csNoError;
    CERT_TRUST_IS_NOT_TIME_VALID:
      FChainStatus := csNoTimeValid;

     CERT_TRUST_IS_NOT_TIME_NESTED:
       FChainStatus := csNotTimeNested;

     CERT_TRUST_IS_REVOKED:
       FChainStatus := csTrustIsRevoked;

     CERT_TRUST_IS_NOT_SIGNATURE_VALID:
       FChainStatus := csNoSignatureValid;

     CERT_TRUST_IS_NOT_VALID_FOR_USAGE:
       FChainStatus := csNotValidForUsage;

     CERT_TRUST_IS_UNTRUSTED_ROOT:
       FChainStatus := csUntrustedRoot;

     CERT_TRUST_REVOCATION_STATUS_UNKNOWN:
       FChainStatus := csRevStatusUnknown;

     CERT_TRUST_IS_CYCLIC :
       FChainStatus := csIsCyclic;

     CERT_TRUST_IS_PARTIAL_CHAIN:
       FChainStatus := csIsPartialChain;
     else
       FChainStatus := csNoError; 
    end;

end;

function TgtPDCertificateChain.Validate: Integer;
var
  LRevStatus: CERT_REVOCATION_STATUS;
  LI, LJ, LK: Integer;
  LLastError: Integer;
begin
  for LK := 0 to FChainsCount -1 do
  begin
    LI := FCertificates[LK];
    LJ := 0;     
    if LI > 1 then
    begin
      while LI > 1 do
      begin
        if CryptVerifyCertificateSignatureEx(0, X509_ASN_ENCODING, CRYPT_VERIFY_CERT_SIGN_SUBJECT_CERT,
          FChainHandle.rgpChain[LK].rgpElement[LJ].pCertContext, CRYPT_VERIFY_CERT_SIGN_ISSUER_CERT
        , FChainHandle.rgpChain[LK].rgpElement[LJ + 1].pCertContext, 0, nil) then
        begin
          Result := 0;
        end
        else
        begin
          LLastError := GetLastError;
          if LLastError =  NTE_BAD_SIGNATURE then    //Bad signature
          begin
            Result := -1;
            Exit;
          end;
        end;
        Inc(LJ);
        Dec(LI);
      end;
      LI := FChainHandle.rgpChain[0].cElement;

      if CryptVerifyCertificateSignatureEx(0, X509_ASN_ENCODING, CRYPT_VERIFY_CERT_SIGN_SUBJECT_CERT,
        FChainHandle.rgpChain[0].rgpElement[LI -1].pCertContext, CRYPT_VERIFY_CERT_SIGN_ISSUER_CERT
      , FChainHandle.rgpChain[0].rgpElement[LI -1].pCertContext, 0, nil) then
      begin
        Result := 0;
      end
      else
      begin
        LLastError := GetLastError;
        if LLastError =  NTE_BAD_SIGNATURE then    //Bad signature
          Result := -1;
      end;
    end
    else
    begin
      if CryptVerifyCertificateSignatureEx(0, X509_ASN_ENCODING, CRYPT_VERIFY_CERT_SIGN_SUBJECT_CERT,
        FChainHandle.rgpChain[LK].rgpElement[0].pCertContext, CRYPT_VERIFY_CERT_SIGN_ISSUER_CERT
      , FChainHandle.rgpChain[LK].rgpElement[0].pCertContext, 0, nil) then
      begin
        Result := 0;
      end
      else
      begin
        LLastError := GetLastError;
        if LLastError =  NTE_BAD_SIGNATURE then    //Bad signature
          Result := -1;
      end;
    end;
  end;
end;

end.

