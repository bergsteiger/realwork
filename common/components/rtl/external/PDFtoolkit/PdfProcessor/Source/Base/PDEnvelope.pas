unit PDEnvelope;

interface

uses
  Windows, SysUtils,Classes, gtJwaWinCrypt, Dialogs, gtWinCrypt;

type

  TgtPKCS7 = class
  private
    function GetFirstCerificateFromStore(hStore: HCERTSTORE): PCCERT_CONTEXT;
  public
    Constructor Create;
    destructor Destroy;  override;
    function GetPFXCertStore(pfxFileName: AnsiString; Password: AnsiString):HCERTSTORE;
    function GetCertificateName(CertContext:PCCERT_CONTEXT): AnsiString;
    function OpenCertificateStorage(AStoreName: AnsiString): HCERTSTORE;
    function ComputeHash(const pMessage: PByte; cbMessage: DWord): AnsiString;
    function SignMessage(certContext: PCCERT_CONTEXT; const pMessage: PByte;
      cbMessage: DWord; AIsDetached: Boolean = False): AnsiString; overload;
    procedure CloseCertificateStorage(hStore: HCERTSTORE);
    procedure CloseCertificate(hCert: PCCERT_CONTEXT);
    function GetPFXCertWithPvtKey(pfxFileName: Ansistring; Password: Ansistring)
      : PCCERT_CONTEXT;
  end;

  TgtPKCS1 = class
  public
    Constructor Create;
    destructor Destroy;  override;
    function OpenCertificateStorage(AStoreName: AnsiString): HCERTSTORE;
    function GetCertificateFromStore(hStore:HCERTSTORE; ACertName: AnsiString):PCCERT_CONTEXT;
    function ComputeHash(const pMessage: PByte; cbMessage: DWord): AnsiString;
    function SignMessage(certContext: PCCERT_CONTEXT; const pMessage: PByte;
      cbMessage: DWord; AIsDetached: Boolean = False): AnsiString; overload;
    procedure CloseCertificateStorage(hStore: HCERTSTORE);
    procedure CloseCertificate(hCert: PCCERT_CONTEXT);
  end;

//function GetPFXCertStore(pfxFileName: String; Password: string):HCERTSTORE;
//function GetCertificateFromStore(hStore: HCERTSTORE; ACertName: string): PCCERT_CONTEXT;
//function OpenCertificateStorage(AStoreName: string): HCERTSTORE;
//function CreateSelfSignedCertificate(AName, AOrganizationUnit, AOrganization,
//  AEmail, ALocale: String; ANotBefore, ANotAfter: TDateTime): PCCERT_CONTEXT;
//function AquireKeyContainer(AContainedName: String): HCRYPTPROV;
//function AddCertToTrustedRoot(pCertContext: PCCERT_CONTEXT): Boolean;
//function VerifyDetechedSignatureValue(const SignedData: String;
//  cbSignedBlob: Cardinal; pInputMessage: PBYTE; cbInputMessage: DWORD): Boolean; overload;

implementation

//uses DateUtils;
{
function GetCertificateFromStore(hStore: HCERTSTORE; ACertName: string): PCCERT_CONTEXT;
const
  MY_TYPE =  (PKCS_7_ASN_ENCODING or X509_ASN_ENCODING);
begin
  Result := nil;
  if  hStore <> nil then
  begin
    Result := CertFindCertificateInStore(
       hStore,
       MY_TYPE,
       0,
       CERT_FIND_SUBJECT_STR_A,
       @ACertName[1],
       nil);
  end;

end;

function AquireKeyContainer(AContainedName: String): HCRYPTPROV;
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
        if CryptAcquireContext(LCryptProv, PAnsiChar(AContainedName), nil, PROV_RSA_FULL,
            CRYPT_NEWKEYSET) then
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

  (*//Now check if the exchange key is available.
  if CryptGetUserKey(LCryptProv, AT_KEYEXCHANGE, hKey) then
  begin
      //A signature key is available.
  end
  else
  begin
    //No signature key is available.
   // if(GetLastError() = NTE_NO_KEY)then
    begin
      //-------------------------------------------------------
      // The error was that there is a container but no key.

      // Create a signature key pair.
      //The signature key does not exist.
      //Create a signature key pair.
      if CryptGenKey(LCryptProv, AT_KEYEXCHANGE, 0, hKey) then
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
    if(hKey <> 0) then
    begin
      if(not (CryptDestroyKey(hKey))) then
      begin
         // Error during CryptDestroyKey
      end;
      hKey := 0;
    end;
  end;
  *)
  Result := LCryptProv;
end;

function CreateSelfSignedCertificate(AName, AOrganizationUnit, AOrganization,
  AEmail, ALocale: String; ANotBefore, ANotAfter: TDateTime): PCCERT_CONTEXT;
var
  LCryptProv: HCRYPTPROV;
  certName: CERT_NAME_BLOB;
  CertNameString: String;
  cbCertNameSize: DWORD;
  startTime, endTime: TSystemTime;
  cryptAlgID: CRYPT_ALGORITHM_IDENTIFIER;
  LStore: HCERTSTORE;
  dwKeySpec: DWORD;
begin
    Result := nil;
    LCryptProv := AquireKeyContainer(AName);

    CertNameString := 'CN=' +AName+', OU=' + AOrganizationUnit + ', O=' +
    AOrganization + ', E='+ AEmail + ', L='+ ALocale;

    if(CertStrToName(X509_ASN_ENCODING Or PKCS_7_ASN_ENCODING, PAnsiChar(CertNameString),
      CERT_X500_NAME_STR, nil, nil, certName.cbData, nil)) then
    begin
      GetMem(certName.pbData, certName.cbData);
      if(CertStrToName(X509_ASN_ENCODING Or PKCS_7_ASN_ENCODING, PAnsiChar(CertNameString), CERT_X500_NAME_STR,
      nil, certName.pbData, certName.cbData, nil)) then
      begin
       (* with startTime do
        begin
          wYear :=  2008;
          wMonth :=  04;
          wDay :=  1;
          wHour :=  12;
          wSecond  :=  10;
        end;
        with endTime do
        begin
          wYear :=  2010;
          wMonth := 04;
          wDay := 20;
          wHour :=  12;
          wSecond  :=  10;
        end;
       *)
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
        Result := CertCreateSelfSignCertificate(LCryptProv, @certName,
          0, nil, nil, @startTime, @endTime, nil);

        if (Result <> nil) then
        begin
          LStore := CertOpenSystemStore(0, 'MY');
          if CertAddCertificateContextToStore(LStore, Result,
                 CERT_STORE_ADD_NEW, nil) then
          begin
            //Added
          end;
          CertCloseStore(LStore, 0);
        end;
        if (Result = nil) then
          Showmessage(Inttostr(GetLastError()));
      end;
    end; 
 // if GetLastError = NTE_BAD_KEYSET then
  CryptReleaseContext(LCryptProv,0) ;
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

function OpenCertificateStorage(
  AStoreName: string): HCERTSTORE;
begin
  Result := CertOpenSystemStore(0, @AStoreName[1]);
end;

function VerifyDetechedSignatureValue(const SignedData: String;
  cbSignedBlob: Cardinal; pInputMessage: PBYTE; cbInputMessage: DWORD): Boolean; overload;
var
  pSignedData : PByte;
  VerifyParams: CRYPT_VERIFY_MESSAGE_PARA;
  cbVerifiedBlob, LInputMessage: DWORD;
  pVerifiedData: PByte;

  ArrToBeSigned: array[0..0] of PByte;
  ArrSizes: array[0..0] of DWORD;
begin
  Result := False;
   try
    GetMem(pSignedData, Length(SignedData));
    system.Move(Pointer(SignedData)^, pSignedData^, Length(SignedData));

    ZeroMemory(@VerifyParams, SizeOf(CRYPT_VERIFY_MESSAGE_PARA));

    //GetMem(pInputMessage, Length(InputMessage));
    //system.Move(Pointer(InputMessage)^, pInputMessage^, Length(InputMessage));

    VerifyParams.cbSize := SizeOf(CRYPT_VERIFY_MESSAGE_PARA);
    VerifyParams.dwMsgAndCertEncodingType := (X509_ASN_ENCODING or PKCS_7_ASN_ENCODING);
    VerifyParams.pfnGetSignerCertificate := nil;
    VerifyParams.hCryptProv := 0;
    VerifyParams.pvGetArg := nil;

    ArrSizes[0] := cbInputMessage;
    ArrToBeSigned[0] := pInputMessage;
     if(CryptVerifyDetachedMessageSignature(@VerifyParams, 0, pSignedData, cbSignedBlob,
      1, @ArrToBeSigned, @ArrSizes, nil)) then
     begin
       Showmessage('Verified');
       Result := True
     end
     else
       Showmessage(Inttostr(GetLastError()));

   finally
   end;


end;
}

{ TgtPKCS7 }

procedure TgtPKCS7.CloseCertificate(hCert: PCCERT_CONTEXT);
begin
  CertFreeCertificateContext(hCert);
end;

procedure TgtPKCS7.CloseCertificateStorage(hStore: HCERTSTORE);
begin
  CertCloseStore(hStore, 0);
end;

function TgtPKCS7.ComputeHash(const pMessage: PByte;
  cbMessage: DWord): AnsiString;
var
  hHash: HCRYPTHASH;
  LCryptProv: HCRYPTPROV;
  cbHash: DWORD;
  pHash: PBYTE;
  LHash: AnsiString;
begin
  if CryptAcquireContext(LCryptProv, nil, nil, PROV_RSA_FULL, CRYPT_VERIFYCONTEXT) then
  begin
    if CryptCreateHash(LCryptProv, CALG_SHA1, 0, 0, hHash) then
    begin
      if(CryptHashData(hHash, pMessage, cbMessage, 0)) then
      begin
        if(CryptGetHashParam(hHash, HP_HASHVAL, nil, cbHash, 0)) then
        begin
          GetMem(pHash, cbHash);
          if(CryptGetHashParam(hHash, HP_HASHVAL, pHash, cbHash, 0)) then
          begin
            SetLength(LHash, cbHash);
            system.Move(pHash^, Pointer(LHash)^, cbHash);
            Result := LHash;
          end;
        end;
      end;
    end;
  end;
  if hHash <> 0 then
    CryptDestroyHash(hHash);
  if LCryptProv <> 0 then
   CryptReleaseContext(LCryptProv,0);

end;

constructor TgtPKCS7.Create;
begin

end;

destructor TgtPKCS7.Destroy;
begin

  inherited;
end;

function TgtPKCS7.GetPFXCertStore(pfxFileName: AnsiString; Password: AnsiString):
    HCERTSTORE;
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
  hFileHandle := CreateFileA(PAnsiChar(pfxFileName), GENERIC_READ, FILE_SHARE_READ,
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

function TgtPKCS7.GetPFXCertWithPvtKey(pfxFileName,
  Password: Ansistring): PCCERT_CONTEXT;
var
  LStore: HCERTSTORE;
  LCertContext: PCCERT_CONTEXT;
  LSize: DWORD;
begin
  Result := nil;
  LStore := GetPFXCertStore(pfxFileName, Password);
  try
    LCertContext := CertEnumCertificatesInStore(LStore, nil);
    while LCertContext <> nil do
    begin
      if(CertGetCertificateContextProperty(LCertContext, CERT_KEY_PROV_INFO_PROP_ID,
        nil, LSize)) then
      begin
        Result := LCertContext;
        Exit;
      end;
      LCertContext := CertEnumCertificatesInStore(LStore, LCertContext);
    end;
  finally
    CertCloseStore(LStore, 0);
  end;
end;

function TgtPKCS7.GetCertificateName(CertContext: PCCERT_CONTEXT): AnsiString;
var
  CertName: array[0..255] of WideChar;
begin
  CertGetNameStringW(CertContext, CERT_NAME_SIMPLE_DISPLAY_TYPE, 0, nil,
    CertName, 256);
  Result := CertName;
end;

function TgtPKCS7.GetFirstCerificateFromStore(hStore: HCERTSTORE): PCCERT_CONTEXT;
begin
  CertEnumCertificatesInStore(hStore, nil)
end;

function TgtPKCS7.OpenCertificateStorage(
  AStoreName: AnsiString): HCERTSTORE;
begin
  Result := CertOpenSystemStore(0, @AStoreName[1]);
end;

function TgtPKCS7.SignMessage(certContext: PCCERT_CONTEXT;
  const pMessage: PByte; cbMessage: DWord; AIsDetached: Boolean = False): AnsiString;
var
  pSignedData: PByte;
  LpPDataToBeSigned: array[0..0] of PByte;
  SigParams: CRYPT_SIGN_MESSAGE_PARA;
  cbSignedBlob: DWORD;
  dwDataSizeArray: array[0..0] of DWORD;
begin
  Result := '';
   try

      //Initialize SigParams
      ZeroMemory(@SigParams, SizeOf(CRYPT_SIGN_MESSAGE_PARA));
      SigParams.cbSize := SizeOf(CRYPT_SIGN_MESSAGE_PARA);
      SigParams.dwMsgEncodingType := (X509_ASN_ENCODING or PKCS_7_ASN_ENCODING);
      SigParams.pSigningCert := certContext;
      SigParams.HashAlgorithm.pszObjId := szOID_RSA_SHA1RSA;
      SigParams.HashAlgorithm.Parameters.cbData := 0;
      SigParams.cMsgCert := 1;
      SigParams.rgpMsgCert := @certContext;
      SigParams.cAuthAttr := 0;
      SigParams.dwInnerContentType := 0;
      SigParams.cMsgCrl := 0;
      SigParams.cUnauthAttr := 0;
      SigParams.dwFlags := 0 ;
      SigParams.pvHashAuxInfo := nil;
      SigParams.rgAuthAttr := nil;

      LpPDataToBeSigned[0] := pMessage;

      dwDataSizeArray[0] := cbMessage;
      cbSignedBlob := 0;

     if(CryptSignMessage(@SigParams, AIsDetached, 1, @LpPDataToBeSigned,  @dwDataSizeArray,
      nil, cbSignedBlob)) then
      begin
        GetMem(pSignedData, cbSignedBlob);
        try
           CryptSignMessage(@SigParams, AIsDetached, 1, @LpPDataToBeSigned,
             @dwDataSizeArray, pSignedData, cbSignedBlob);

          SetLength(Result, cbSignedBlob);
          system.Move(pSignedData^, Pointer(Result)^, cbSignedBlob);
        finally
        end;
      end;
   finally
   end;


end;

{ TgtPKCS1 }

procedure TgtPKCS1.CloseCertificate(hCert: PCCERT_CONTEXT);
begin
  CertFreeCertificateContext(hCert);

end;

procedure TgtPKCS1.CloseCertificateStorage(hStore: HCERTSTORE);
begin
  CertCloseStore(hStore, 0);

end;

function TgtPKCS1.ComputeHash(const pMessage: PByte;
  cbMessage: DWord): AnsiString;
var
  hHash: HCRYPTHASH;
  LCryptProv: HCRYPTPROV;
  cbHash: DWORD;
  pHash: PBYTE;
  LHash: AnsiString;
begin
  if CryptAcquireContext(LCryptProv, nil, nil, PROV_RSA_FULL, CRYPT_VERIFYCONTEXT) then
  begin
    if CryptCreateHash(LCryptProv, CALG_SHA1, 0, 0, hHash) then
    begin
      if(CryptHashData(hHash, pMessage, cbMessage, 0)) then
      begin
        if(CryptGetHashParam(hHash, HP_HASHVAL, nil, cbHash, 0)) then
        begin
          GetMem(pHash, cbHash);
          if(CryptGetHashParam(hHash, HP_HASHVAL, pHash, cbHash, 0)) then
          begin
            SetLength(LHash, cbHash);
            system.Move(pHash^, Pointer(LHash)^, cbHash);
            Result := LHash;
          end;
        end;
      end;
    end;
  end;
  if hHash <> 0 then
    CryptDestroyHash(hHash);
  if LCryptProv <> 0 then
   CryptReleaseContext(LCryptProv,0);

end;

constructor TgtPKCS1.Create;
begin

end;

destructor TgtPKCS1.Destroy;
begin

  inherited;
end;

function TgtPKCS1.GetCertificateFromStore(hStore: HCERTSTORE;
  ACertName: AnsiString): PCCERT_CONTEXT;
const
  MY_TYPE =  (PKCS_7_ASN_ENCODING or X509_ASN_ENCODING);
begin
  Result := nil;
  if  hStore <> nil then
  begin
    Result := CertFindCertificateInStore(
       hStore,
       MY_TYPE,
       0,
       CERT_FIND_SUBJECT_STR_A,
       @ACertName[1],
       nil);
  end;

end;

function TgtPKCS1.OpenCertificateStorage(AStoreName: AnsiString): HCERTSTORE;
begin
  Result := CertOpenSystemStore(0, @AStoreName[1]);

end;

function TgtPKCS1.SignMessage(certContext: PCCERT_CONTEXT;
  const pMessage: PByte; cbMessage: DWord; AIsDetached: Boolean): AnsiString;
var
  phCryptProv: HCRYPTPROV;
  dwKeySpec: DWORD;
  CallerFreeProv: Boolean;
  LCryptKey: HCRYPTKEY;

  hHash: HCRYPTHASH;
  LCryptProv: HCRYPTPROV;
  cbHash, cbSignature, cbEncodedSignature: DWORD;
  pHash, pEncodedSignature: PBYTE;
  LHash: AnsiString;
  pSignatureRev, pSignatureTemp : array of Byte;
  LI, LJ, cbCertLength: Integer;

  LCertStr: AnsiString;
  LTextFile, LTextFile1: TextFile;

  pSignature, pSigByte: PByte;
  SigArray, EncodedSigArray, pTempMessage: array of Byte;
  LMem: TMemoryStream;
  LLength: Integer;
begin
(* //To store certificate in /cert entry
  cbCertLength :=  certContext^.cbCertEncoded ;
  SetLength(LCertStr,certContext^.cbCertEncoded);
  system.Move(certContext^.pbCertEncoded^, Pointer(LCertStr)^, certContext^.cbCertEncoded);

  AssignFile(LTextFile, 'C:\Cert.txt');
  Append(LTextFile) ;
  Writeln(LTextFile, LCertStr) ;
  CloseFile(LTextFile) ;

                LMem := TMemoryStream.Create;
                LMem.LoadFromFile('C:\IntermediateRSA.pdf');
                LLength := LMem.Size - 7299;
                SetLength(pTempMessage, LLength);
                LMem.Position := 7299;
                LMem.Read(pTempMessage[0], LLength);
                LMem.Position := 7299;
                LMem.Size := LMem.Size + cbCertLength;
                LMem.Write(certContext^.pbCertEncoded^, cbCertLength);
                LMem.Write(pTempMessage[0], LLength);


                //LMem.Write(SigArray[0], cbSignature);
                LMem.SaveToFile('C:\IntermediateRSA.pdf');
                LMem.Free;

*)

  dwKeySpec := AT_SIGNATURE;
  if( CryptAcquireCertificatePrivateKey(certContext, 0 ,
    nil, LCryptProv, @dwKeySpec,  nil)) then
  begin
    begin
      if CryptCreateHash(LCryptProv, CALG_SHA1, 0, 0, hHash) then
      begin
        if(CryptHashData(hHash, pMessage, cbMessage, 0)) then
        begin
            if(CryptGetHashParam(hHash, HP_HASHVAL, nil, cbHash, 0)) then
            begin
              GetMem(pHash, cbHash);
              if(CryptGetHashParam(hHash, HP_HASHVAL, pHash, cbHash, 0)) then
              begin
                SetLength(LHash, cbHash);
                system.Move(pHash^, Pointer(LHash)^, cbHash);
                Result := LHash;
                  AssignFile(LTextFile1, 'C:\Cert2.txt');
                  Append(LTextFile1) ;
                  Writeln(LTextFile1, Result) ;
                  CloseFile(LTextFile1) ;
              end;
            end;    


            if CryptSignHash(hHash, AT_SIGNATURE, '', 0, nil,
              cbSignature) then
            begin
              //Getmem(pSignature, cbSignature);
              SetLength(SigArray, cbSignature);
              //if CryptSignHash(hHash, AT_SIGNATURE, '', 0, pSignature,
                //cbSignature) then
              if CryptSignHash(hHash, AT_SIGNATURE, '', 0, @SigArray[0],
                cbSignature) then
              begin
                LMem := TMemoryStream.Create;
                LMem.Write(SigArray[0], cbSignature);
                LMem.Position := 0;
                Randomize;
                LMem.SaveToFile('C:\Cert1_' + IntToStr(Random(10000)) + '.txt');
                LMem.Free;
                  //SetLength(Result, cbSignature);

                  //system.Move(pSignature, Pointer(Result)^, cbSignature);
                  //Showmessage(Result);

                  //AssignFile(LTextFile1, 'C:\Cert1.txt');
                  //Append(LTextFile1) ;
                  //Writeln(LTextFile1, Result) ;
                  //CloseFile(LTextFile1) ;
              end;
              end;
            end;
          end;
        end;
      end;

    if SigArray <> nil then
    begin
      LJ := 0;
      SetLength(pSignatureRev, cbSignature);
      for LI := cbSignature -1 downto 0 do
      begin
        pSignatureRev[LJ] := SigArray[LI] ;
        Inc(LJ);
      end;




      if CryptEncodeObject(X509_ASN_ENCODING  , X509_DSS_SIGNATURE,
                           @SigArray[0], nil, cbEncodedSignature) then
      begin
        SetLength(EncodedSigArray, cbEncodedSignature);
        if CryptEncodeObject(X509_ASN_ENCODING  , X509_DSS_SIGNATURE,
                         @SigArray[0], @EncodedSigArray[0], cbEncodedSignature) then
        begin
          SetLength(Result, cbEncodedSignature);
        //system.Move(EncodedSigArray, Pointer(Result)^, cbEncodedSignature);
                LMem := TMemoryStream.Create;
                LMem.Write(EncodedSigArray[0], cbEncodedSignature);
                LMem.Position := 0;
                LMem.Read(Result[1], LMem.Size);
                Showmessage(Result);
                Randomize;
                LMem.SaveToFile('C:\Signed_' + IntToStr(Random(10000)) + '.txt');
                LMem.Free;

        end;
      end;
    end;
    
    if hHash <> 0 then
      CryptDestroyHash(hHash);
    if LCryptProv <> 0 then
     CryptReleaseContext(LCryptProv,0);
end;


end.
