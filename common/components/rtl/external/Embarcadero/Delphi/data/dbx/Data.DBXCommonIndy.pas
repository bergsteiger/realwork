{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
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

  ///  <summary> Indy wrapper implementation of TX500Principal</summary>
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

  ///  <summary> Indy wrapper implementation of TX509Certificate</summary>
  TX509CertificateIndy = class(TX509Certificate)
  protected
    FIdX509: IIPX509;
    FSubjectPrincipal: TX500PrincipalIndy;
    FIssuerPrincipal: TX500PrincipalIndy;
    FInstanceOwner : Boolean;
  public
    constructor Create(CertFile: string); overload; virtual;
    constructor Create(CertFile: string; const AIPImplementationID: string); overload; virtual;
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
  end;

implementation

uses
  System.Classes,
  Data.DBXClientResStrs
;

{ TX509CertificateIndy }

constructor TX509CertificateIndy.Create(CertFile: string);
begin
  Create(CertFile, '');
end;

constructor TX509CertificateIndy.Create(CertFile: string; const AIPImplementationID: string);
var
  fileStream: TFileStream;
  data: TArray<Byte>;
  dataPPtr: PPByte;
begin
  Assert(FileExists(CertFile));

  fileStream := TFileStream.Create(CertFile, fmOpenRead);
  try
    SetLength(data, fileStream.Size);
    fileStream.Read(data[0], fileStream.Size);

    dataPPtr := Addr(PByte(data));
    Create(PeerFactory.CreatePeer(AIPImplementationID, IIPX509,  IPProcs(AIPImplementationID)._d2i_X509(nil, dataPPtr, Length(data)), True) as IIPX509, True);
  finally
    fileStream.Free;
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
  raise TDBXError.Create(TDBXErrorCodes.NotImplemented, SNotImplemented);
end;

function TX509CertificateIndy.GetEncoded: TArray<Byte>;
begin
  raise TDBXError.Create(TDBXErrorCodes.NotImplemented, SNotImplemented);
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
  raise TDBXError.Create(TDBXErrorCodes.NotImplemented, SNotImplemented);
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
  raise TDBXError.Create(TDBXErrorCodes.NotImplemented, SNotImplemented);
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

end.
