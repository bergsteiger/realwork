{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Data.DBXCommonIndy;

interface

uses
  System.SysUtils,
  Data.DBXCommon,
  IPPeerAPI
;

type

  /// <summary>Indy wrapper implementation of TX500Principal.</summary>
  TX500PrincipalIndy = class(TX500Principal)
  protected
    FIdX509Name : IIPX509Name;
    FInstanceOwner : Boolean;
  public
    constructor Create(idX509Name: IIPX509Name; instanceOwner: Boolean = False); virtual;
    destructor Destroy; override;

    function GetName: string; override;
    function GetEncoded: Longint; override;
  end;

  /// <summary>Indy wrapper implementation of TX509Certificate.</summary>
  TX509CertificateIndy = class(TX509Certificate)
  protected
    FIdX509: IIPX509;
    FSubjectPrincipal: TX500PrincipalIndy;
    FIssuerPrincipal: TX500PrincipalIndy;
    FInstanceOwner : Boolean;
  public
    constructor Create(CertFile: string); overload; virtual;
    constructor Create(CertFile: string; const AIPImplementationID: string); overload; virtual;
    constructor Create(CertFile: string; const AIPImplementationID: string; const certpassword: string); overload; virtual;
    constructor Create(idX509: IIPX509; instanceOwner: Boolean = False); overload; virtual;
    destructor Destroy; override;

    {Inherited from the base Certificate class}
    function GetEncoded: TArray<Byte>; override;
    function GetPublicKey: TPublicKey; override;
    function Verify(key: TPublicKey): Boolean; override;

    {Inherited from the X.509 Certificate class}
    procedure CheckValidity; overload; override;
    procedure CheckValidity(ADate: TDateTime); overload; override;
    function GetNotAfter: TDateTime; override;
    function GetNotBefore: TDateTime; override;

    function GetBasicConstraints: Integer; override;

    function GetSerialNumber: string; override;
    function GetVersion: LongInt; override;

    function GetSigAlgName: string; override;
    function GetSignature: string; override;

    function GetIssuerX500Principal: TX500Principal; override;
    function GetSubjectX500Principal: TX500Principal; override;
    ///<summary>
    ///  Determines the certificate file type, based on the file extension. Returns a TDBXX509_Filetypes integer constant
    ///</summary>
    function GetFileType(CertFile: string): Integer;
  end;

implementation

uses
  System.Classes,
  Data.DBXClientResStrs
;

type
  TX509PublicKey = class(TPublicKey)
  private
    FIdX509: IIPX509;
  public
    constructor Create(IPX509: IIPX509);
    function GetAlgorithm: string; override;
    function GetFormat: string; override;
    function GetEncoded: TArray<Byte>; override;
  end;

{ TX509CertificateIndy }

constructor TX509CertificateIndy.Create(CertFile: string);
begin
  Create(CertFile, '', '');
end;

constructor TX509CertificateIndy.Create(CertFile: string; const AIPImplementationID: string);
begin
  Create(CertFile, AIPImplementationID, '');
end;

constructor TX509CertificateIndy.Create(CertFile: string; const AIPImplementationID: string; const certpassword: string);
var
  data: TArray<Byte>;
  dataPPtr: PPByte;
  LInterface: IInterface;
  filetype: Integer;
  LM: TMemoryStream;
begin
  Assert(FileExists(CertFile));
  filetype := GetFileType(CertFile);
  LM := TMemoryStream.Create;
  try
    try
      LM.LoadFromFile(CertFile);
    except
      raise ECertificateParsingException.Create(SCertInvalidFile);
    end;
    case filetype of
      TDBXX509_Filetypes.SSL_FILETYPE_DER:
      begin
        SetLength(data, LM.Size);
        LM.Read(data[0], LM.Size);
        dataPPtr := Addr(PByte(data));
        LInterface := PeerFactory.CreatePeer(AIPImplementationID, IIPX509,  IPProcs(AIPImplementationID)._d2i_X509(nil, dataPPtr, Length(data)),True);
      end;
      TDBXX509_Filetypes.SSL_FILETYPE_PEM:
      begin
        LInterface := PeerFactory.CreatePeer(AIPImplementationID, IIPX509,  IPProcs(AIPImplementationID)._PEM_read_bio_X509(LM.Memory, LM.Size),True);
      end;
      TDBXX509_Filetypes.SSL_FILETYPE_P12:
      begin
        LInterface := PeerFactory.CreatePeer(AIPImplementationID, IIPX509,  IPProcs(AIPImplementationID)._d2i_PKCS12_bio(LM.Memory, LM.Size, certpassword),True);
      end;
    end;
    Create(LInterface as IIPX509, True);
  finally
    LM.Free;
  end;
end;

constructor TX509CertificateIndy.Create(idX509: IIPX509; instanceOwner: Boolean = False);
begin
  Assert(idX509 <> nil);

  FIdX509 := idX509;
  FInstanceOwner := instanceOwner;
end;

destructor TX509CertificateIndy.Destroy;
begin
  if FInstanceOwner then
    FIdX509 := nil;
  FreeAndNil(FSubjectPrincipal);
  FreeAndNil(FIssuerPrincipal);
  inherited;
end;

function TX509CertificateIndy.GetFileType(CertFile: string): Integer;
var
  CIn: TFileStream;
  LCount: Integer;
  CData: Byte;
begin
  if SameFileName(ExtractFileExt(CertFile),'.p12') or SameFileName(ExtractFileExt(CertFile),'.pfx') then
    Result := TDBXX509_Filetypes.SSL_FILETYPE_P12
  else
    if SameFileName(ExtractFileExt(CertFile),'.pem') then
      Result := TDBXX509_Filetypes.SSL_FILETYPE_PEM
  else
    if SameFileName(ExtractFileExt(CertFile),'.der') then
      Result := TDBXX509_Filetypes.SSL_FILETYPE_DER
  else
    if SameFileName(ExtractFileExt(CertFile),'.crt') or SameFileName(ExtractFileExt(CertFile),'.cet') then
    begin //could be PEM or DER.  check if file has binary (DER) or ascii contents (PEM)
       Result := TDBXX509_Filetypes.SSL_FILETYPE_PEM;
       CIn := TFileStream.Create(CertFile, fmOpenRead or fmShareDenyNone);
       try
         for LCount := 1 to CIn.Size do
         begin
            CIn.Read(CData, 1);
            if (CData) > 127 then
            begin
              Result:= TDBXX509_Filetypes.SSL_FILETYPE_DER;
              break;
            end;
         end;
       finally
        CIn.Free;
       end;
    end
  else
    raise ECertificateParsingException.Create(SCertInvalidFile);
end;


procedure TX509CertificateIndy.CheckValidity;
begin
  CheckValidity(Now);
end;

procedure TX509CertificateIndy.CheckValidity(ADate: TDateTime);
begin
  if ADate > FIdX509.notAfter then
     raise ECertificateExpiredException.Create(SCertExpired);

  if ADate < FIdX509.notBefore then
     raise ECertificateNotYetValidException.Create(SCertNotYetValid);
end;

function TX509CertificateIndy.GetBasicConstraints: Integer;
begin
  Result := FIdX509.BasicConstraints;
end;

function TX509CertificateIndy.GetEncoded: TArray<Byte>;
begin
  Result := FIdX509.EncodedCertificate;
end;

function TX509CertificateIndy.GetIssuerX500Principal: TX500Principal;
begin
  if FIssuerPrincipal = nil then
  begin
    FIssuerPrincipal := TX500PrincipalIndy.Create(FIdX509.Issuer);
  end;
  Result := FIssuerPrincipal;
end;

function TX509CertificateIndy.GetSubjectX500Principal: TX500Principal;
begin
  if FSubjectPrincipal = nil then
  begin
    FSubjectPrincipal := TX500PrincipalIndy.Create(FIdX509.Subject);
  end;
  Result := FSubjectPrincipal;
end;

function TX509CertificateIndy.GetNotAfter: TDateTime;
begin
  Result := FIdX509.notAfter;
end;

function TX509CertificateIndy.GetNotBefore: TDateTime;
begin
  Result := FIdX509.notBefore;
end;

function TX509CertificateIndy.GetPublicKey: TPublicKey;
begin
  Result := TX509PublicKey.Create(FIdX509);
end;

function TX509CertificateIndy.GetSerialNumber: string;
begin
  Result := FIdX509.SerialNumber;
end;

function TX509CertificateIndy.GetSigAlgName: string;
begin
  Result := FIdX509.SigInfo.SigTypeAsString;                                      
end;

function TX509CertificateIndy.GetSignature: string;
begin
  Result := FIdX509.SigInfo.Signature;
end;

function TX509CertificateIndy.GetVersion: LongInt;
begin
  Result := FIdX509.Version;
end;

function TX509CertificateIndy.Verify(key: TPublicKey): Boolean;
begin
  Result := FIdX509.Verify(TX509PublicKey(key).FIdX509);
end;

{ TX500PrincipalIndy }

constructor TX500PrincipalIndy.Create(idX509Name: IIPX509Name; instanceOwner: Boolean = False);
begin
  Assert(idX509Name <> nil);

  FIdX509Name := idX509Name;
  FInstanceOwner := instanceOwner;
end;

destructor TX500PrincipalIndy.Destroy;
begin
  if FInstanceOwner then
  begin
    FIdX509Name := nil;
  end;
  inherited;
end;

function TX500PrincipalIndy.GetEncoded: Longint;
begin
  Result := FIdX509Name.Hash.L1;
end;

function TX500PrincipalIndy.GetName: string;
begin
  Result := FIdX509Name.OneLine;
end;

{ TX509PublicKey }

constructor TX509PublicKey.Create(IPX509: IIPX509);
begin
  inherited Create;
  FIdX509 := IPX509;
end;

function TX509PublicKey.GetAlgorithm: string;
begin
  Result := FIdX509.KeyAlgorithm;
end;

function TX509PublicKey.GetEncoded: TArray<Byte>;
begin
  Result := FIdX509.EncodedKey;
end;

function TX509PublicKey.GetFormat: string;
begin
  Result := FIdX509.KeyFormat;
end;

end.
