{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{               FireDAC DataSnap metadata               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}

unit FireDAC.Phys.DSMeta;

interface

uses
  System.Classes,
  FireDAC.Stan.Intf, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.Phys, FireDAC.Phys.Meta;

type
  TFDPhysDSMetadata = class (TFDPhysConnectionMetadata)
  protected
    // IFDPhysConnectionMetadata
    function GetKind: TFDRDBMSKind; override;
    function GetTxSupported: Boolean; override;
    function GetEventSupported: Boolean; override;
    function GetEventKinds: String; override;
    function GetParamNameMaxLength: Integer; override;
    function GetNameParts: TFDPhysNameParts; override;
    function GetNameQuotedCaseSensParts: TFDPhysNameParts; override;
    function GetNameQuoteChar(AQuote: TFDPhysNameQuoteLevel; ASide: TFDPhysNameQuoteSide): Char; override;
    function GetIdentitySupported: Boolean; override;
    function GetNamedParamMark: TFDPhysParamMark; override;
    function GetAsyncAbortSupported: Boolean; override;
    function GetLimitOptions: TFDPhysLimitOptions; override;
    function GetServerCursorSupported: Boolean; override;
    function GetColumnOriginProvided: Boolean; override;
    function GetTruncateSupported: Boolean; override;
    function GetDefValuesSupported: TFDPhysDefaultValues; override;
    // other
    function InternalGetSQLCommandKind(const ATokens: TStrings): TFDPhysCommandKind; override;
  public
    constructor Create(const AConnectionObj: TFDPhysConnection;
      AServerVersion, AClientVersion: TFDVersion; AIsUnicode: Boolean);
  end;

implementation

uses
{$IFDEF MSWINDOWS}
  // Preventing from "Inline has not expanded"
  Winapi.Windows,
{$ENDIF}
  System.SysUtils,
  FireDAC.Stan.Error, FireDAC.Stan.Consts, FireDAC.Stan.Util;

{-------------------------------------------------------------------------------}
{ TFDPhysDSMetadata                                                             }
{-------------------------------------------------------------------------------}
constructor TFDPhysDSMetadata.Create(const AConnectionObj: TFDPhysConnection;
  AServerVersion, AClientVersion: TFDVersion; AIsUnicode: Boolean);
begin
  inherited Create(AConnectionObj, AServerVersion, AClientVersion, AIsUnicode);
  FKeywords.CommaText := '';
end;

{-------------------------------------------------------------------------------}
function TFDPhysDSMetadata.InternalGetSQLCommandKind(
  const ATokens: TStrings): TFDPhysCommandKind;
var
  sToken: String;
begin
  sToken := ATokens[0];
  if sToken = 'CALL' then
    Result := skExecute
  else
    Result := inherited InternalGetSQLCommandKind(ATokens);
end;

{-------------------------------------------------------------------------------}
function TFDPhysDSMetadata.GetIdentitySupported: Boolean;
begin
  Result := False;
end;

{-------------------------------------------------------------------------------}
function TFDPhysDSMetadata.GetKind: TFDRDBMSKind;
begin
  Result := TFDRDBMSKinds.DataSnap;
end;

{-------------------------------------------------------------------------------}
function TFDPhysDSMetadata.GetNameQuotedCaseSensParts: TFDPhysNameParts;
begin
  Result := [];
end;

{-------------------------------------------------------------------------------}
function TFDPhysDSMetadata.GetParamNameMaxLength: Integer;
begin
  Result := 255;
end;

{-------------------------------------------------------------------------------}
function TFDPhysDSMetadata.GetNameParts: TFDPhysNameParts;
begin
  Result := [npSchema, npBaseObject, npObject];
end;

{-------------------------------------------------------------------------------}
function TFDPhysDSMetadata.GetNameQuoteChar(AQuote: TFDPhysNameQuoteLevel;
  ASide: TFDPhysNameQuoteSide): Char;
begin
  Result := #0;
end;

{-------------------------------------------------------------------------------}
function TFDPhysDSMetadata.GetNamedParamMark: TFDPhysParamMark;
begin
  Result := prName;
end;

{-------------------------------------------------------------------------------}
function TFDPhysDSMetadata.GetTxSupported: Boolean;
begin
  Result := False;
end;

{-------------------------------------------------------------------------------}
function TFDPhysDSMetadata.GetEventSupported: Boolean;
begin
  Result := True;
end;

{-------------------------------------------------------------------------------}
function TFDPhysDSMetadata.GetEventKinds: String;
begin
  Result := S_FD_EventKind_DS_Events;
end;

{-------------------------------------------------------------------------------}
function TFDPhysDSMetadata.GetTruncateSupported: Boolean;
begin
  Result := False;
end;

{-------------------------------------------------------------------------------}
function TFDPhysDSMetadata.GetDefValuesSupported: TFDPhysDefaultValues;
begin
  Result := dvNone;
end;

{-------------------------------------------------------------------------------}
function TFDPhysDSMetadata.GetAsyncAbortSupported: Boolean;
begin
  Result := False;
end;

{-------------------------------------------------------------------------------}
function TFDPhysDSMetadata.GetLimitOptions: TFDPhysLimitOptions;
begin
  Result := [];
end;

{-------------------------------------------------------------------------------}
function TFDPhysDSMetadata.GetServerCursorSupported: Boolean;
begin
  Result := False;
end;

{-------------------------------------------------------------------------------}
function TFDPhysDSMetadata.GetColumnOriginProvided: Boolean;
begin
  Result := False;
end;

{-------------------------------------------------------------------------------}
initialization
  FDPhysManager().RegisterRDBMSKind(TFDRDBMSKinds.DataSnap, S_FD_DS_RDBMS);

end.
