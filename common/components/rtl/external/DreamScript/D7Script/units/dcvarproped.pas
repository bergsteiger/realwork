{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dcVarPropEd;

interface
{$I dc.inc}
uses
  {$IFDEF USEOWNDSGNSTUFF}
  dcdsgnstuff,
  {$ELSE}
    {$IFDEF D6}
    DesignIntf,DesignEditors,VCLEditors,
    {$ELSE}
    dsgnintf,
    {$ENDIF}
  {$ENDIF}

  Classes

  {$IFDEF D6}
  ,Variants
  {$ENDIF}
  ;

type
  {$IFNDEF D6}
  TGetPropProc=TGetPropEditProc;
  {$ENDIF}

{$IFDEF D4}
  TDCVariantProperty = class(TPropertyEditor)
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure SetValue(const Value: string); override;
    procedure GetProperties(Proc: TGetPropProc); override;
  end;

  TVarType = (vt_Boolean, vt_Byte, vt_Currency, vt_Date, vt_Double, vt_Integer,
    vt_Null, vt_OleStr, vt_Single, vt_Smallint, vt_String);

  TVarTypeProperty = class(TNestedProperty)
    function GetAttributes: TPropertyAttributes; override;
    function GetName: string; override;
    function GetValue: string; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;
{$ELSE}
  TDCVariantProperty = class(TPropertyEditor)
    procedure SetValue(const Val: string); override;
    function GetValue: string; override;
  end;
{$ENDIF}
procedure Register;

implementation

{$IFDEF D4}

uses TypInfo, SysUtils;

const
  vtNames: array[TVarType] of string = ('Boolean', 'Byte', 'Currency', 'Date',
    'Double', 'Integer', 'Null', 'OleStr', 'Single', 'Smallint', 'String');

function IntToVarType(Value: integer): TVarType;
begin
  case Value of
    varNull: Result := vt_Null;
    varSmallint: Result := vt_Smallint;
    varInteger: Result := vt_Integer;
    varSingle: Result := vt_Single;
    varDouble: Result := vt_Double;
    varCurrency: Result := vt_Currency;
    varDate: Result := vt_Date;
    varOleStr: Result := vt_OleStr;
    varBoolean: Result := vt_Boolean;
    varByte: Result := vt_Byte;
    varString: Result := vt_String;
    else
      Result := vt_Null;
  end;
end;

function VarTypeToInt(Value: TVarType): integer;
begin
  case Value of
    vt_Null: Result := varNull;
    vt_Smallint: Result := varSmallint;
    vt_Integer: Result := varInteger;
    vt_Single: Result := varSingle;
    vt_Double: Result := varDouble;
    vt_Currency: Result := varCurrency;
    vt_Date: Result := varDate;
    vt_OleStr: Result := varOleStr;
    vt_Boolean: Result := varBoolean;
    vt_Byte: Result := varByte;
    vt_String: Result := varString;
    else
      Result := varNull;
  end;
end;

{--------------------------------------------------------------------}

function TDCVariantProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paSubProperties];
end;

{--------------------------------------------------------------------}

function TDCVariantProperty.GetValue: string;
var
  v: Variant;
begin
  v := GetVarValue;
  if TVarData(v).VType = varBoolean then
    Result := BooleanIdents[Boolean(v)]
  else
    Result := VarToStr(v);
end;

procedure TDCVariantProperty.SetValue(const Value: string);
var
  v: Variant;
begin
  v := GetVarValue;
  if TVarData(v).VType = varNull then
    v := VarAsType(Value, varString)
  else
    v := VarAsType(Value, TVarData(v).VType);
  SetVarValue(v);
end;

{--------------------------------------------------------------------}

procedure TDCVariantProperty.GetProperties(Proc: TGetPropProc);
begin
  Proc(TVarTypeProperty.Create(Self));
end;

{--------------------------------------------------------------------}

function TVarTypeProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paMultiSelect, paValueList, paSortList];
end;

{--------------------------------------------------------------------}

function TVarTypeProperty.GetName: string;
begin
  Result := 'Type';
end;

{--------------------------------------------------------------------}

function TVarTypeProperty.GetValue: string;
var
  v: Variant;
begin
  v := GetVarValue;
  Result := vtNames[IntToVarType(TVarData(v).VType)];
end;

{--------------------------------------------------------------------}

procedure TVarTypeProperty.GetValues(Proc: TGetStrProc);
var
  vt: TVarType;
begin
  for vt := Low(TVarType) to High(TVarType) do
    Proc(vtNames[vt]);
end;

{--------------------------------------------------------------------}

procedure TVarTypeProperty.SetValue(const Value: string);
var
  vti: TVarType;
  vt: word;
  v: Variant;
begin
  vt := varNull;
  v := GetVarValue;
  for vti := Low(TVarType) to High(TVarType) do
    if CompareText(Value, vtNames[vti]) = 0 then
    begin
      vt := VarTypeToInt(vti);
      break;
    end;
  if TVarData(v).VType = varNull then
    if (vt = varString) or (vt = varOleStr) then
      v := ''
    else
      v := 0;
  v := VarAsType(v, vt);
  SetVarValue(v);
end;

{$ELSE}

{--------------------------------------------------------------------}

function TDCVariantProperty.GetValue: string;
begin
  result := GetVarValue;
end;

{--------------------------------------------------------------------}

procedure TDCVariantProperty.SetValue(const Val: string);
begin
  SetVarValue(val);
end;

{$ENDIF}

{--------------------------------------------------------------------}

procedure Register;
begin
{$IFNDEF D6}
  RegisterPropertyEditor(TypeInfo(Variant), TPersistent, '', TDCVariantProperty);
{$ENDIF}
end;

{--------------------------------------------------------------------}
end.
