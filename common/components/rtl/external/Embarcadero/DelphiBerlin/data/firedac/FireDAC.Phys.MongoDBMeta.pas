{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{               FireDAC MongoDB metadata                }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}

unit FireDAC.Phys.MongoDBMeta;

interface

uses
  System.Classes,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Consts,
  FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.Phys, FireDAC.Phys.Meta, FireDAC.Phys.SQLGenerator;

type
  TFDPhysMongoMetadata = class (TFDPhysConnectionMetadata)
  protected
    function GetKind: TFDRDBMSKind; override;
    function GetTxSupported: Boolean; override;
    function GetEventSupported: Boolean; override;
    function GetEventKinds: String; override;
    function GetParamNameMaxLength: Integer; override;
    function GetNameParts: TFDPhysNameParts; override;
    function GetNameQuotedSupportedParts: TFDPhysNameParts; override;
    function GetNameQuotedCaseSensParts: TFDPhysNameParts; override;
    function GetNameDefLowCaseParts: TFDPhysNameParts; override;
    function GetIdentitySupported: Boolean; override;
    function GetIdentityInsertSupported: Boolean; override;
    function GetIdentityInWhere: Boolean; override;
    function GetNamedParamMark: TFDPhysParamMark; override;
    function GetSelectOptions: TFDPhysSelectOptions; override;
    function GetAsyncAbortSupported: Boolean; override;
    function GetAsyncNativeTimeout: Boolean; override;
    function GetArrayExecMode: TFDPhysArrayExecMode; override;
    function GetLimitOptions: TFDPhysLimitOptions; override;
    function IsNameValid(const AName: String): Boolean; override;
    function GetTruncateSupported: Boolean; override;
    function GetDefValuesSupported: TFDPhysDefaultValues; override;
    function InternalEscapeBoolean(const AStr: String): String; override;
    function InternalEscapeDate(const AStr: String): String; override;
    function InternalEscapeTime(const AStr: String): String; override;
    function InternalEscapeDateTime(const AStr: String): String; override;
    function InternalEscapeFloat(const AStr: String): String; override;
    function InternalEscapeString(const AStr: String): String; override;
                                                                                     
//    function InternalEscapeFunction(const ASeq: TFDPhysEscapeData): String; override;
//    function InternalGetSQLCommandKind(const ATokens: TStrings): TFDPhysCommandKind; override;
  end;

  TFDPhysMongoCommandGenerator = class(TFDPhysCommandGenerator)
  end;

implementation

uses
  System.SysUtils, System.StrUtils,
  FireDAC.Stan.Util, FireDAC.Stan.Param;

{-------------------------------------------------------------------------------}
{ TFDPhysMongoMetadata                                                          }
{-------------------------------------------------------------------------------}
function TFDPhysMongoMetadata.GetKind: TFDRDBMSKind;
begin
  Result := TFDRDBMSKinds.MongoDB;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMongoMetadata.GetTxSupported: Boolean;
begin
  Result := False;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMongoMetadata.GetEventSupported: Boolean;
begin
  Result := True;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMongoMetadata.GetEventKinds: String;
begin
  Result := S_FD_EventKind_Mongo_Tail;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMongoMetadata.GetParamNameMaxLength: Integer;
begin
  Result := 1024;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMongoMetadata.GetNameParts: TFDPhysNameParts;
begin
  Result := [npCatalog, npBaseObject, npObject];
end;

{-------------------------------------------------------------------------------}
function TFDPhysMongoMetadata.GetNameQuotedCaseSensParts: TFDPhysNameParts;
begin
  Result := [];
end;

{-------------------------------------------------------------------------------}
function TFDPhysMongoMetadata.GetNameQuotedSupportedParts: TFDPhysNameParts;
begin
  Result := [npBaseObject, npObject];
end;

{-------------------------------------------------------------------------------}
function TFDPhysMongoMetadata.GetNameDefLowCaseParts: TFDPhysNameParts;
begin
  Result := GetNameParts;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMongoMetadata.GetIdentitySupported: Boolean;
begin
  Result := True;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMongoMetadata.GetIdentityInsertSupported: Boolean;
begin
  Result := True;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMongoMetadata.GetIdentityInWhere: Boolean;
begin
  Result := True;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMongoMetadata.GetNamedParamMark: TFDPhysParamMark;
begin
  Result := prName;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMongoMetadata.GetSelectOptions: TFDPhysSelectOptions;
begin
  Result := [];
end;

{-------------------------------------------------------------------------------}
function TFDPhysMongoMetadata.GetAsyncAbortSupported: Boolean;
begin
                                 
  Result := False;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMongoMetadata.GetAsyncNativeTimeout: Boolean;
begin
  Result := True;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMongoMetadata.GetArrayExecMode: TFDPhysArrayExecMode;
begin
  Result := aeCollectAllErrors;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMongoMetadata.GetLimitOptions: TFDPhysLimitOptions;
begin
  Result := [loSkip, loRows];
end;

{-------------------------------------------------------------------------------}
function TFDPhysMongoMetadata.IsNameValid(const AName: String): Boolean;
var
  i: Integer;
begin
  Result := True;
  for i := 1 to Length(AName) do
    if not ((i = 1) and (AName[i] <> '$') or
            (i > 1) and (AName[i] <> '.') and (AName[i] <> #0)) then begin
      Result := False;
      Break;
    end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMongoMetadata.GetTruncateSupported: Boolean;
begin
  Result := False;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMongoMetadata.GetDefValuesSupported: TFDPhysDefaultValues;
begin
  Result := dvNone;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMongoMetadata.InternalEscapeBoolean(const AStr: String): String;
begin
  Result := LowerCase(AStr);
end;

{-------------------------------------------------------------------------------}
function TFDPhysMongoMetadata.InternalEscapeDate(const AStr: String): String;
begin
  Result := '{ "$date": "' + Trim(AStr) + '" }';
end;

{-------------------------------------------------------------------------------}
function TFDPhysMongoMetadata.InternalEscapeTime(const AStr: String): String;
begin
  Result := '{ "$date": "0000-00-00T' + Trim(AStr) + '" }';
end;

{-------------------------------------------------------------------------------}
function TFDPhysMongoMetadata.InternalEscapeDateTime(const AStr: String): String;
begin
  Result := '{ "$date": "' + ReplaceText(Trim(AStr), ' ', 'T') + '" }';
end;

{-------------------------------------------------------------------------------}
function TFDPhysMongoMetadata.InternalEscapeFloat(const AStr: String): String;
begin
  Result := AStr;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMongoMetadata.InternalEscapeString(const AStr: String): String;
begin
  Result := '"' + AStr + '"';
end;

{-------------------------------------------------------------------------------}
initialization
  FDPhysManager().RegisterRDBMSKind(TFDRDBMSKinds.MongoDB, S_FD_Mongo_NoSQL);

end.
