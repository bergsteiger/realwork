{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}

unit FireDAC.Phys.InfxDef;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf;

type
  // TFDPhysInfxConnectionDefParams
  // Generated for: FireDAC Infx driver

  TFDInfxStringFormat = (sfUnicode, sfANSI);
  TFDInfxTxSupported = (tsYes, tsNo, tsChoose);

  /// <summary> TFDPhysInfxConnectionDefParams class implements FireDAC Infx driver specific connection definition class. </summary>
  TFDPhysInfxConnectionDefParams = class(TFDConnectionDefParams)
  private
    function GetDriverID: String;
    procedure SetDriverID(const AValue: String);
    function GetODBCAdvanced: String;
    procedure SetODBCAdvanced(const AValue: String);
    function GetLoginTimeout: Integer;
    procedure SetLoginTimeout(const AValue: Integer);
    function GetServer: String;
    procedure SetServer(const AValue: String);
    function GetCharacterSet: String;
    procedure SetCharacterSet(const AValue: String);
    function GetDBCharacterSet: String;
    procedure SetDBCharacterSet(const AValue: String);
    function GetStringFormat: TFDInfxStringFormat;
    procedure SetStringFormat(const AValue: TFDInfxStringFormat);
    function GetReadTimeout: Integer;
    procedure SetReadTimeout(const AValue: Integer);
    function GetWriteTimeout: Integer;
    procedure SetWriteTimeout(const AValue: Integer);
    function GetTxSupported: TFDInfxTxSupported;
    procedure SetTxSupported(const AValue: TFDInfxTxSupported);
    function GetTxRetainLocks: Boolean;
    procedure SetTxRetainLocks(const AValue: Boolean);
    function GetTxLastCommitted: Boolean;
    procedure SetTxLastCommitted(const AValue: Boolean);
    function GetMetaDefCatalog: String;
    procedure SetMetaDefCatalog(const AValue: String);
    function GetMetaDefSchema: String;
    procedure SetMetaDefSchema(const AValue: String);
    function GetMetaCurCatalog: String;
    procedure SetMetaCurCatalog(const AValue: String);
    function GetMetaCurSchema: String;
    procedure SetMetaCurSchema(const AValue: String);
  published
    property DriverID: String read GetDriverID write SetDriverID stored False;
    property ODBCAdvanced: String read GetODBCAdvanced write SetODBCAdvanced stored False;
    property LoginTimeout: Integer read GetLoginTimeout write SetLoginTimeout stored False;
    property Server: String read GetServer write SetServer stored False;
    property CharacterSet: String read GetCharacterSet write SetCharacterSet stored False;
    property DBCharacterSet: String read GetDBCharacterSet write SetDBCharacterSet stored False;
    property StringFormat: TFDInfxStringFormat read GetStringFormat write SetStringFormat stored False default sfANSI;
    property ReadTimeout: Integer read GetReadTimeout write SetReadTimeout stored False;
    property WriteTimeout: Integer read GetWriteTimeout write SetWriteTimeout stored False;
    property TxSupported: TFDInfxTxSupported read GetTxSupported write SetTxSupported stored False default tsYes;
    property TxRetainLocks: Boolean read GetTxRetainLocks write SetTxRetainLocks stored False default True;
    property TxLastCommitted: Boolean read GetTxLastCommitted write SetTxLastCommitted stored False default True;
    property MetaDefCatalog: String read GetMetaDefCatalog write SetMetaDefCatalog stored False;
    property MetaDefSchema: String read GetMetaDefSchema write SetMetaDefSchema stored False;
    property MetaCurCatalog: String read GetMetaCurCatalog write SetMetaCurCatalog stored False;
    property MetaCurSchema: String read GetMetaCurSchema write SetMetaCurSchema stored False;
  end;

implementation

uses
  FireDAC.Stan.Consts;

// TFDPhysInfxConnectionDefParams
// Generated for: FireDAC Infx driver

{-------------------------------------------------------------------------------}
function TFDPhysInfxConnectionDefParams.GetDriverID: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_Common_DriverID];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysInfxConnectionDefParams.SetDriverID(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_Common_DriverID] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysInfxConnectionDefParams.GetODBCAdvanced: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_ODBC_ODBCAdvanced];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysInfxConnectionDefParams.SetODBCAdvanced(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_ODBC_ODBCAdvanced] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysInfxConnectionDefParams.GetLoginTimeout: Integer;
begin
  Result := FDef.AsInteger[S_FD_ConnParam_Common_LoginTimeout];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysInfxConnectionDefParams.SetLoginTimeout(const AValue: Integer);
begin
  FDef.AsInteger[S_FD_ConnParam_Common_LoginTimeout] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysInfxConnectionDefParams.GetServer: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_Common_Server];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysInfxConnectionDefParams.SetServer(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_Common_Server] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysInfxConnectionDefParams.GetCharacterSet: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_Common_CharacterSet];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysInfxConnectionDefParams.SetCharacterSet(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_Common_CharacterSet] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysInfxConnectionDefParams.GetDBCharacterSet: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_Infx_DBCharacterSet];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysInfxConnectionDefParams.SetDBCharacterSet(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_Infx_DBCharacterSet] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysInfxConnectionDefParams.GetStringFormat: TFDInfxStringFormat;
var
  s: String;
begin
  s := FDef.AsString[S_FD_ConnParam_Infx_StringFormat];
  if CompareText(s, 'Unicode') = 0 then
    Result := sfUnicode
  else if CompareText(s, 'ANSI') = 0 then
    Result := sfANSI
  else
    Result := sfANSI;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysInfxConnectionDefParams.SetStringFormat(const AValue: TFDInfxStringFormat);
const
  C_StringFormat: array[TFDInfxStringFormat] of String = ('Unicode', 'ANSI');
begin
  FDef.AsString[S_FD_ConnParam_Infx_StringFormat] := C_StringFormat[AValue];
end;

{-------------------------------------------------------------------------------}
function TFDPhysInfxConnectionDefParams.GetReadTimeout: Integer;
begin
  Result := FDef.AsInteger[S_FD_ConnParam_Infx_ReadTimeout];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysInfxConnectionDefParams.SetReadTimeout(const AValue: Integer);
begin
  FDef.AsInteger[S_FD_ConnParam_Infx_ReadTimeout] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysInfxConnectionDefParams.GetWriteTimeout: Integer;
begin
  Result := FDef.AsInteger[S_FD_ConnParam_Infx_WriteTimeout];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysInfxConnectionDefParams.SetWriteTimeout(const AValue: Integer);
begin
  FDef.AsInteger[S_FD_ConnParam_Infx_WriteTimeout] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysInfxConnectionDefParams.GetTxSupported: TFDInfxTxSupported;
var
  s: String;
begin
  s := FDef.AsString[S_FD_ConnParam_Infx_TxSupported];
  if CompareText(s, 'Yes') = 0 then
    Result := tsYes
  else if CompareText(s, 'No') = 0 then
    Result := tsNo
  else if CompareText(s, 'Choose') = 0 then
    Result := tsChoose
  else
    Result := tsYes;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysInfxConnectionDefParams.SetTxSupported(const AValue: TFDInfxTxSupported);
const
  C_TxSupported: array[TFDInfxTxSupported] of String = ('Yes', 'No', 'Choose');
begin
  FDef.AsString[S_FD_ConnParam_Infx_TxSupported] := C_TxSupported[AValue];
end;

{-------------------------------------------------------------------------------}
function TFDPhysInfxConnectionDefParams.GetTxRetainLocks: Boolean;
begin
  if not FDef.HasValue(S_FD_ConnParam_Infx_TxRetainLocks) then
    Result := True
  else
    Result := FDef.AsYesNo[S_FD_ConnParam_Infx_TxRetainLocks];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysInfxConnectionDefParams.SetTxRetainLocks(const AValue: Boolean);
begin
  FDef.AsYesNo[S_FD_ConnParam_Infx_TxRetainLocks] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysInfxConnectionDefParams.GetTxLastCommitted: Boolean;
begin
  if not FDef.HasValue(S_FD_ConnParam_Infx_TxLastCommitted) then
    Result := True
  else
    Result := FDef.AsYesNo[S_FD_ConnParam_Infx_TxLastCommitted];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysInfxConnectionDefParams.SetTxLastCommitted(const AValue: Boolean);
begin
  FDef.AsYesNo[S_FD_ConnParam_Infx_TxLastCommitted] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysInfxConnectionDefParams.GetMetaDefCatalog: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_Common_MetaDefCatalog];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysInfxConnectionDefParams.SetMetaDefCatalog(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_Common_MetaDefCatalog] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysInfxConnectionDefParams.GetMetaDefSchema: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_Common_MetaDefSchema];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysInfxConnectionDefParams.SetMetaDefSchema(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_Common_MetaDefSchema] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysInfxConnectionDefParams.GetMetaCurCatalog: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_Common_MetaCurCatalog];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysInfxConnectionDefParams.SetMetaCurCatalog(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_Common_MetaCurCatalog] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysInfxConnectionDefParams.GetMetaCurSchema: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_Common_MetaCurSchema];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysInfxConnectionDefParams.SetMetaCurSchema(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_Common_MetaCurSchema] := AValue;
end;

end.
