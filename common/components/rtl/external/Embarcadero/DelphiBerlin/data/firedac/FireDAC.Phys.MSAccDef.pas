{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}

unit FireDAC.Phys.MSAccDef;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf;

type
  // TFDPhysMSAccConnectionDefParams
  // Generated for: FireDAC MSAcc driver

  TFDMSAccStringFormat = (sfChoose, sfUnicode, sfANSI);

  /// <summary> TFDPhysMSAccConnectionDefParams class implements FireDAC MSAcc driver specific connection definition class. </summary>
  TFDPhysMSAccConnectionDefParams = class(TFDConnectionDefParams)
  private
    function GetDriverID: String;
    procedure SetDriverID(const AValue: String);
    function GetODBCAdvanced: String;
    procedure SetODBCAdvanced(const AValue: String);
    function GetLoginTimeout: Integer;
    procedure SetLoginTimeout(const AValue: Integer);
    function GetSystemDB: String;
    procedure SetSystemDB(const AValue: String);
    function GetReadOnly: Boolean;
    procedure SetReadOnly(const AValue: Boolean);
    function GetStringFormat: TFDMSAccStringFormat;
    procedure SetStringFormat(const AValue: TFDMSAccStringFormat);
  published
    property DriverID: String read GetDriverID write SetDriverID stored False;
    property ODBCAdvanced: String read GetODBCAdvanced write SetODBCAdvanced stored False;
    property LoginTimeout: Integer read GetLoginTimeout write SetLoginTimeout stored False;
    property SystemDB: String read GetSystemDB write SetSystemDB stored False;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly stored False;
    property StringFormat: TFDMSAccStringFormat read GetStringFormat write SetStringFormat stored False default sfChoose;
  end;

implementation

uses
  FireDAC.Stan.Consts;

// TFDPhysMSAccConnectionDefParams
// Generated for: FireDAC MSAcc driver

{-------------------------------------------------------------------------------}
function TFDPhysMSAccConnectionDefParams.GetDriverID: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_Common_DriverID];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMSAccConnectionDefParams.SetDriverID(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_Common_DriverID] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMSAccConnectionDefParams.GetODBCAdvanced: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_ODBC_ODBCAdvanced];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMSAccConnectionDefParams.SetODBCAdvanced(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_ODBC_ODBCAdvanced] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMSAccConnectionDefParams.GetLoginTimeout: Integer;
begin
  Result := FDef.AsInteger[S_FD_ConnParam_Common_LoginTimeout];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMSAccConnectionDefParams.SetLoginTimeout(const AValue: Integer);
begin
  FDef.AsInteger[S_FD_ConnParam_Common_LoginTimeout] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMSAccConnectionDefParams.GetSystemDB: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_MSAcc_SystemDB];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMSAccConnectionDefParams.SetSystemDB(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_MSAcc_SystemDB] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMSAccConnectionDefParams.GetReadOnly: Boolean;
begin
  Result := FDef.AsBoolean[S_FD_ConnParam_MSAcc_ReadOnly];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMSAccConnectionDefParams.SetReadOnly(const AValue: Boolean);
begin
  FDef.AsBoolean[S_FD_ConnParam_MSAcc_ReadOnly] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMSAccConnectionDefParams.GetStringFormat: TFDMSAccStringFormat;
var
  s: String;
begin
  s := FDef.AsString[S_FD_ConnParam_MSAcc_StringFormat];
  if CompareText(s, 'Choose') = 0 then
    Result := sfChoose
  else if CompareText(s, 'Unicode') = 0 then
    Result := sfUnicode
  else if CompareText(s, 'ANSI') = 0 then
    Result := sfANSI
  else
    Result := sfChoose;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMSAccConnectionDefParams.SetStringFormat(const AValue: TFDMSAccStringFormat);
const
  C_StringFormat: array[TFDMSAccStringFormat] of String = ('Choose', 'Unicode', 'ANSI');
begin
  FDef.AsString[S_FD_ConnParam_MSAcc_StringFormat] := C_StringFormat[AValue];
end;

end.
