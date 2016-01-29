{ ********************************************************************* }
{                                                                       }
{                           Gnostice Streams                            }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

unit EncryptionSettings;

interface

uses
  Classes;

type

  TgtPDFEncryptionLevel = (el40Bit, el128Bit);
  TgtCryptAlgorithm = (cryptRC4, cryptAES);
  TgtUserPermissionsType = (AllowCopy, AllowModify, AllowPrint, AllowAnnotation,
    AllowFormFill, AllowAccessibility, AllowDocAssembly, AllowHighResPrint);

  TgtUserPermissions = set of TgtUserPermissionsType;

  TgtEncryptionSettings = class(TPersistent)
  private
    FIsOwner: Boolean;
    FEnabled: Boolean;
    FLevel: TgtPDFEncryptionLevel;
    FOwnerPassword: AnsiString;
    FUserPassword: AnsiString;
    FUserPermissions: TgtUserPermissions;
    FFileID: AnsiString;
    FPermission: Integer;

    procedure SetLevel(const Value: TgtPDFEncryptionLevel);
    procedure SetOwnerPassword(const Value: AnsiString);
    procedure SetUserPassword(const Value: AnsiString);
    procedure SetUserPermissions(const Value: TgtUserPermissions);
    procedure SetEnabled(const Value: Boolean);
    procedure SetFileID(Value: AnsiString);
    procedure SetPermission(Value: Integer);
    function GetOwnerPassword: AnsiString;

  public
    constructor Create;
    destructor Destroy; override;
    property IsOwner: Boolean read FIsOwner write FIsOwner;
    property FileID: AnsiString read FFileID write SetFileID;
    property Permission: Integer read FPermission write SetPermission;

  published
    property Enabled: Boolean read FEnabled
      write SetEnabled default False;
    property Level: TgtPDFEncryptionLevel read FLevel
      write SetLevel default el128bit;
    property OwnerPassword: AnsiString read GetOwnerPassword
      write SetOwnerPassword;
    property UserPassword: AnsiString read FUserPassword
      write SetUserPassword;
    property UserPermissions: TgtUserPermissions read FUserPermissions
      write SetUserPermissions;
  end;

implementation

{ TgtPDFEncryptionSettings }

constructor TgtEncryptionSettings.Create;
begin
  FIsOwner := True;
  FEnabled := False;
  FLevel := el128bit;
  FOwnerPassword := '';
  FUserPassword := '';
  FUserPermissions := [];
end;

destructor TgtEncryptionSettings.Destroy;
begin

  inherited;
end;

function TgtEncryptionSettings.GetOwnerPassword: AnsiString;
begin
  Result := FOwnerPassword;
end;

procedure TgtEncryptionSettings.SetEnabled(const Value: Boolean);
begin
  FEnabled := Value;
end;

procedure TgtEncryptionSettings.SetFileID(Value: AnsiString);
begin
  FFileID := Value;
end;

procedure TgtEncryptionSettings.SetLevel(const Value: TgtPDFEncryptionLevel);
begin
  FLevel := Value;
end;

procedure TgtEncryptionSettings.SetOwnerPassword(const Value: AnsiString);
begin
  FOwnerPassword := Value;
end;

procedure TgtEncryptionSettings.SetPermission(Value: Integer);
begin
  FPermission := Value;
end;

procedure TgtEncryptionSettings.SetUserPassword(const Value: AnsiString);
begin
  FUserPassword := Value;
end;

procedure TgtEncryptionSettings.SetUserPermissions(
  const Value: TgtUserPermissions);
begin
  FUserPermissions := Value;
end;

end.
