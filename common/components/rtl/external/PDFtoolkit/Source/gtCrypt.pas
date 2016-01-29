{ ********************************************************************* }
{                                                                       }
{                       Gnostice PDFtoolkit v3.0                        }
{                       Copyright (c) 2002-2009                         }
{          Gnostice Information Technologies Private Limited            }
{                       http://www.gnostice.com                         }
{                                                                       }
{ ********************************************************************* }
unit gtCrypt;

interface

uses
  Classes;

type
  //enums
  TgtPDFEncryptionLevel = (el40bit, el128bit);
  TgtUserPermissionsType = (AllowCopy, AllowModify, AllowPrint, AllowAnnotation,
    AllowFormFill, AllowAccessibility, AllowDocAssembly,
    AllowHighResPrint);
  TgtUserPermissions = set of TgtUserPermissionsType;


  TgtPDFEncryptionSettings = class(TPersistent)
  private
//    FIsOwner: Boolean;
    FEnabled: Boolean;
    FLevel: TgtPDFEncryptionLevel;
    FOwnerPassword: string;
    FUserPassword: string;
    FUserPermissions: TgtUserPermissions;
    procedure SetLevel(const Value: TgtPDFEncryptionLevel);
    procedure SetOwnerPassword(const Value: string);
    procedure SetUserPassword(const Value: string);
    procedure SetUserPermissions(const Value: TgtUserPermissions);
    procedure SetEnabled(const Value: Boolean);
    function GetOwnerPassword: string;

  public
    constructor Create;
    destructor Destroy; override;

  published
    property Enabled: Boolean read FEnabled
      write SetEnabled default False;
    property Level: TgtPDFEncryptionLevel read FLevel
      write SetLevel default el128bit;
    property OwnerPassword: string read GetOwnerPassword
      write SetOwnerPassword;
    property UserPassword: string read FUserPassword
      write SetUserPassword;
    property UserPermissions: TgtUserPermissions read FUserPermissions
      write SetUserPermissions
      default [];
  end;



implementation

{ TgtPDFEncryptionSettings }

constructor TgtPDFEncryptionSettings.Create;
begin
  FUserPassword := '';
  FOwnerPassword := '';
  FUserPermissions := [];
  FEnabled := False;
end;

destructor TgtPDFEncryptionSettings.Destroy;
begin

  inherited;
end;

function TgtPDFEncryptionSettings.GetOwnerPassword: string;
begin
  Result := FOwnerPassword;
end;

procedure TgtPDFEncryptionSettings.SetEnabled(const Value: Boolean);
begin
  FEnabled := Value;
end;

procedure TgtPDFEncryptionSettings.SetLevel(const Value: TgtPDFEncryptionLevel);
begin
  FLevel := Value;
end;

procedure TgtPDFEncryptionSettings.SetOwnerPassword(const Value: string);
begin
  FOwnerPassword := Value;
end;

procedure TgtPDFEncryptionSettings.SetUserPassword(const Value: string);
begin
  FUserPassword := Value;
end;

procedure TgtPDFEncryptionSettings.SetUserPermissions(
  const Value: TgtUserPermissions);
begin
  FUserPermissions := Value;
end;

end.
