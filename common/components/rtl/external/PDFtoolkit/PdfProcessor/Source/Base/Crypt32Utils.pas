unit Crypt32Utils;

interface

uses
  Windows, SysUtils,Classes, gtJwaWinCrypt, Dialogs;

type


  TgtWinCrypt = class
  public

    Constructor Create;
    destructor Destroy;  override;
    function GetCertificateFromStore(AStoreName: string; ACertName: string):PCCERT_CONTEXT;
    function CertificateStoreOpen(AStoreName: string):HCERTSTORE;
    procedure FreeCertificateContext(certContext: PCCERT_CONTEXT);

    function SignMessage(certContext: PCCERT_CONTEXT; const AMessage: string;
      var pSignedData: PByte; AIsDetached: Boolean = False): Integer; overload;
    function SignMessage(certContext: PCCERT_CONTEXT; const AMessage: string;
      AIsDetached: Boolean = False):
      string; overload;
    function SignMessage(certContext: PCCERT_CONTEXT; const pMessage: PByte;
      cbMessage: DWord; AIsDetached: Boolean = False):
      string; overload;

    function VerifySignatureValue(const pSignedData: PByte;
      cbSignedBlob: Cardinal; var pVerifiedData: PByte): Integer; overload;

    function VerifySignatureValue(const SignedData: String;
      cbSignedBlob: Cardinal; var VerifiedData: string): Integer; overload;

    function VerifyDetechedSignatureValue(const SignedData: String;
      cbSignedBlob: Cardinal; InputMessage: string): Boolean; overload;
    function VerifyDetechedSignatureValue(const SignedData: String;
      cbSignedBlob: Cardinal; pInputMessage: PByte; cbInputMessageSize: DWord): Boolean; overload;

    function ComputePKCS1Envelope: Integer;   ///computing hash..

    function CreateHash: String;

  end;

implementation



{ TgtWinCrypt }



function TgtWinCrypt.CertificateStoreOpen(AStoreName: string): HCERTSTORE;
begin
  Result := CertOpenStore(
	   CERT_STORE_PROV_SYSTEM,
	   0,
	   0,
	   CERT_SYSTEM_STORE_CURRENT_USER,
	   PAnsiChar(AStoreName));

end;

function TgtWinCrypt.ComputePKCS1Envelope: Integer;
var
  hHash: HCRYPTHASH;
  LCryptProv: HCRYPTPROV;
  pData: array of Byte;
  LData: String;
  LStream: TMemoryStream;
  cbHash: DWORD;
  pHash: PBYTE;
  LHash: String;
begin
  LStream := TMemoryStream.Create;
  with LStream do
  begin
    LStream.LoadFromFile('C:\Intermediate.pdf');
    LStream.Position := 0;
    //GetMem(pMessage, LStream.Size);
    SetLength(pData, LStream.Size);
    LStream.Read(pData[0], LStream.Size);
  end;

  if CryptAcquireContext(LCryptProv, 0, 0, PROV_RSA_FULL, CRYPT_VERIFYCONTEXT) then


  if CryptCreateHash(LCryptProv, CALG_SHA1, 0, 0, hHash) then
  if(CryptHashData(hHash, @pData[0], LStream.Size, 0)) then
  begin
    if(CryptGetHashParam(hHash, HP_HASHVAL, 0, cbHash, 0)) then
    begin

      GetMem(pHash, cbHash);
      if(CryptGetHashParam(hHash, HP_HASHVAL, pHash, cbHash, 0)) then
      begin
        SetLength(LHash, cbHash);
        system.Move(pHash^, Pointer(LHash)^, cbHash);
        Showmessage(LHash);

      end;

    end;
  end;

  Showmessage(inttostr(GetLastError()));
  if hHash <> 0 then
    CryptDestroyHash(hHash);
  if LCryptProv <> 0 then
   CryptReleaseContext(LCryptProv,0);



end;

constructor TgtWinCrypt.Create;
begin

end;

function TgtWinCrypt.CreateHash: String;
var
  HashPara: CRYPT_HASH_MESSAGE_PARA;
  AlgId: CRYPT_ALGORITHM_IDENTIFIER;
  pData: array of Byte;
  LData: String;
  LStream: TMemoryStream;
  cbHash: DWORD;
  pHash, pEncodedHash: PByte;
  cbData, cbEncodedhash: DWord;
begin
  LStream := TMemoryStream.Create;
  with LStream do
  begin
    LStream.LoadFromFile('C:\Intermediate.pdf');
    LStream.Position := 0;
    //GetMem(pMessage, LStream.Size);
    SetLength(pData, LStream.Size);
    LStream.Read(pData[0],LStream.Size );
  end;
  cbData := LStream.Size ;


  //-------------------------------------------------------------------
  //  Initialize the CRYPT_HASH_MESSAGE_PARA data structure.

  AlgId.pszObjId := szOID_RSA_SHA1RSA;
  AlgId.Parameters.cbData := 0;

  HashPara.cbSize := sizeof(CRYPT_HASH_MESSAGE_PARA);
  HashPara.dwMsgEncodingType := PKCS_7_ASN_ENCODING or X509_ASN_ENCODING;
  HashPara.hCryptProv := 0;
  HashPara.HashAlgorithm := AlgId;
  HashPara.pvHashAuxInfo := 0;

  if(CryptHashMessage(@HashPara, FALSE, 1, @pData[0], @cbData,
        0, @cbEncodedHash, 0, 0)) then
  begin
    GetMem(pHash, cbHash);
    GetMem(pEncodedHash, cbEncodedhash);
    if(CryptHashMessage(@HashPara, FALSE, 1, @pData[0], @cbData,
          pEncodedHash, @cbEncodedhash, 0, 0)) then
    begin
      SetLength(Result, cbHash);
      system.Move(pHash^, Pointer(Result)^, cbHash);
      Showmessage(Result);
    end
  else
    Showmessage(Inttostr(GetLastError));
  end;

end;

destructor TgtWinCrypt.Destroy;
begin

end;

procedure TgtWinCrypt.FreeCertificateContext(certContext: PCCERT_CONTEXT);
begin
  CertFreeCertificateContext(certContext);
end;

function TgtWinCrypt.GetCertificateFromStore(AStoreName,
  ACertName: string): PCCERT_CONTEXT;
var
  hStoreHandle: HCERTSTORE;
const
  MY_TYPE =  (PKCS_7_ASN_ENCODING or X509_ASN_ENCODING);
begin

  Result := nil;
  hStoreHandle := CertOpenSystemStore(0, @AStoreName[1]);

  if  hStoreHandle <> nil then
  begin
    Result := CertFindCertificateInStore(
       hStoreHandle,
       MY_TYPE,
       0,
       CERT_FIND_SUBJECT_STR_A,
       @ACertName[1],
       0);
  end;

end;

function TgtWinCrypt.SignMessage(certContext: PCCERT_CONTEXT;
  const AMessage: string; var pSignedData: PByte; AIsDetached: Boolean = False): Integer;
var
  LPDataToBeSigned: PByte;
  LpPDataToBeSigned: array[0..0] of PByte;
  SigParams: CRYPT_SIGN_MESSAGE_PARA;
  cbSignedBlob: DWORD;
  dwDataSizeArray: array[0..0] of DWORD;
begin
  Result := 0;
   GetMem(LPDataToBeSigned, Length(AMessage));
   try
      system.Move(Pointer(AMessage)^, LPDataToBeSigned^, Length(AMessage));

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
      SigParams.dwFlags := 0;
      SigParams.pvHashAuxInfo := nil;
      SigParams.rgAuthAttr := nil;

      LpPDataToBeSigned[0] := LPDataToBeSigned;

      dwDataSizeArray[0] := Length(AMessage);
      cbSignedBlob := 0;

     if(CryptSignMessage(@SigParams, AIsDetached, 1, @LpPDataToBeSigned,  @dwDataSizeArray,
      nil, cbSignedBlob)) then
      begin
        GetMem(pSignedData, cbSignedBlob);
        try
           CryptSignMessage(@SigParams, AIsDetached, 1, @LpPDataToBeSigned,
             @dwDataSizeArray, pSignedData, cbSignedBlob);
           Result := cbSignedBlob ;
        finally
        end;
      end;
   finally
      FreeMem(LPDataToBeSigned);
   end; 
end;

function TgtWinCrypt.SignMessage(certContext: PCCERT_CONTEXT;
  const AMessage: string; AIsDetached: Boolean = False): string;
var
  LPDataToBeSigned, pSignedData: PByte;
  LpPDataToBeSigned: array[0..0] of PByte;
  SigParams: CRYPT_SIGN_MESSAGE_PARA;
  cbSignedBlob: DWORD;
  dwDataSizeArray: array[0..0] of DWORD;
begin
  Result := '';
   GetMem(LPDataToBeSigned, Length(AMessage));
   try
      system.Move(Pointer(AMessage)^, LPDataToBeSigned^, Length(AMessage));

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
      SigParams.dwFlags := 0;
      SigParams.pvHashAuxInfo := nil;
      SigParams.rgAuthAttr := nil;

      LpPDataToBeSigned[0] := LPDataToBeSigned;

      dwDataSizeArray[0] := Length(AMessage);
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
      FreeMem(LPDataToBeSigned);
   end; 


end;

function TgtWinCrypt.SignMessage(certContext: PCCERT_CONTEXT;
  const pMessage: PByte; cbMessage: DWord; AIsDetached: Boolean = False): string;
var
  LPDataToBeSigned, pSignedData: PByte;
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

function TgtWinCrypt.VerifyDetechedSignatureValue(const SignedData: String;
  cbSignedBlob: Cardinal; InputMessage: string): Boolean;
var
  pSignedData, pInputMessage: PByte;
  VerifyParams: CRYPT_VERIFY_MESSAGE_PARA;
  cbVerifiedBlob, LInputMessage: DWORD;
  pVerifiedData: PByte;
begin
  Result := False;
   try
    GetMem(pSignedData, Length(SignedData));
    system.Move(Pointer(SignedData)^, pSignedData^, Length(SignedData));

    ZeroMemory(@VerifyParams, SizeOf(CRYPT_VERIFY_MESSAGE_PARA));

    GetMem(pInputMessage, Length(InputMessage));
    system.Move(Pointer(InputMessage)^, pInputMessage^, Length(InputMessage));

    VerifyParams.cbSize := SizeOf(CRYPT_VERIFY_MESSAGE_PARA);
    VerifyParams.dwMsgAndCertEncodingType := (X509_ASN_ENCODING or PKCS_7_ASN_ENCODING);
    VerifyParams.pfnGetSignerCertificate := nil;
    VerifyParams.hCryptProv := 0;
    VerifyParams.pvGetArg := nil;

     //if(CryptVerifyMessageSignature(@VerifyParams, 0, pSignedData, cbSignedBlob,
    //  InputMessage, @cbVerifiedBlob, nil)) then
     begin
       Showmessage('Varified');
      // GetMem(pVerifiedData, cbVerifiedBlob);

     //  try
      //   LInputMessage := Length(InputMessage);
      //  Result := CryptVerifyDetachedMessageSignature(@VerifyParams, 0, pSignedData, cbSignedBlob,
      //    1, pInputMessage, @LInputMessage, 0);

       // finally
        //    FreeMem(pSignedData);
       // end;
     end;

   finally
   end;

end;

function TgtWinCrypt.VerifyDetechedSignatureValue(const SignedData: String;
  cbSignedBlob: Cardinal; pInputMessage: PByte; cbInputMessageSize: DWord): Boolean;
var
  pSignedData: PByte;
  VerifyParams: CRYPT_VERIFY_MESSAGE_PARA;
  cbVerifiedBlob, LInputMessage: DWORD;
  pVerifiedData: PByte;
begin
  Result := False;
   try
    GetMem(pSignedData, Length(SignedData));
    system.Move(Pointer(SignedData)^, pSignedData^, Length(SignedData));

    ZeroMemory(@VerifyParams, SizeOf(CRYPT_VERIFY_MESSAGE_PARA));


    VerifyParams.cbSize := SizeOf(CRYPT_VERIFY_MESSAGE_PARA);
    VerifyParams.dwMsgAndCertEncodingType := (X509_ASN_ENCODING or PKCS_7_ASN_ENCODING);
    VerifyParams.pfnGetSignerCertificate := nil;
    VerifyParams.hCryptProv := 0;
    VerifyParams.pvGetArg := nil;

     //if(CryptVerifyMessageSignature(@VerifyParams, 0, pSignedData, cbSignedBlob,
     // nil, @cbVerifiedBlob, nil)) then
     begin
     //  GetMem(pVerifiedData, cbVerifiedBlob);

       try
         LInputMessage := cbInputMessageSize;
        // Result := CryptVerifyDetachedMessageSignature(@VerifyParams, 0, pSignedData, cbSignedBlob,
         //  1, pInputMessage, @LInputMessage, 0);
         if Result then
           Showmessage('Varified');

        finally
            FreeMem(pSignedData);
        end;
     end;

   finally
   end;
end;

function TgtWinCrypt.VerifySignatureValue(const SignedData: String;
  cbSignedBlob: Cardinal; var VerifiedData: string): Integer;
var
  pSignedData: PByte;
  VerifyParams: CRYPT_VERIFY_MESSAGE_PARA;
  cbVerifiedBlob: DWORD;
  pVerifiedData: PByte;
begin
  Result := 0;
  VerifiedData := '';
   try
    GetMem(pSignedData, Length(SignedData));
    system.Move(Pointer(SignedData)^, pSignedData^, Length(SignedData));

    ZeroMemory(@VerifyParams, SizeOf(CRYPT_VERIFY_MESSAGE_PARA));

    VerifyParams.cbSize := SizeOf(CRYPT_VERIFY_MESSAGE_PARA);
    VerifyParams.dwMsgAndCertEncodingType := (X509_ASN_ENCODING or PKCS_7_ASN_ENCODING);
    VerifyParams.pfnGetSignerCertificate := nil;
    VerifyParams.hCryptProv := 0;
    VerifyParams.pvGetArg := nil;

     if(CryptVerifyMessageSignature(@VerifyParams, 0, pSignedData, cbSignedBlob,
      nil, @cbVerifiedBlob, nil)) then
     begin
       GetMem(pVerifiedData, cbVerifiedBlob);

       try
        if(CryptVerifyMessageSignature(@VerifyParams, 0, pSignedData, cbSignedBlob,
          pVerifiedData, @cbVerifiedBlob, nil)) then
        begin
          Result := cbVerifiedBlob;
          SetLength(VerifiedData, cbVerifiedBlob);
          system.Move(pVerifiedData^, Pointer(VerifiedData)^, cbVerifiedBlob);
        end;
        finally
            FreeMem(pSignedData);
        end;
     end;

   finally
   end;


end;

function TgtWinCrypt.VerifySignatureValue(const pSignedData: PByte;
  cbSignedBlob: Cardinal; var pVerifiedData: PBYTE): Integer;
var
  VerifyParams: CRYPT_VERIFY_MESSAGE_PARA;
  cbVerifiedBlob: DWORD;
begin
  Result := 0;
   try
      ZeroMemory(@VerifyParams, SizeOf(CRYPT_VERIFY_MESSAGE_PARA));

      VerifyParams.cbSize := SizeOf(CRYPT_VERIFY_MESSAGE_PARA);
      VerifyParams.dwMsgAndCertEncodingType := (X509_ASN_ENCODING or PKCS_7_ASN_ENCODING);
      VerifyParams.pfnGetSignerCertificate := nil;
      VerifyParams.hCryptProv := 0;
	    VerifyParams.pvGetArg := nil;

     if(CryptVerifyMessageSignature(@VerifyParams, 0, pSignedData, cbSignedBlob,
      nil, @cbVerifiedBlob, nil)) then
     begin
       GetMem(pVerifiedData, cbVerifiedBlob);

       try
        if(CryptVerifyMessageSignature(@VerifyParams, 0, pSignedData, cbSignedBlob,
          pVerifiedData, @cbVerifiedBlob, nil)) then
        begin
          Result := cbVerifiedBlob;
        end;
        finally
          //  FreeMem(signature);
        end;
     end;

   finally
   end;   
end;

end.
