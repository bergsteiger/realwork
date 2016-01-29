unit UpgradeTo134;

{ $Id: UpgradeTo134.pas,v 1.2 2013/10/01 09:28:18 fireton Exp $ }

// ƒобавл€ем поле LSubID (DWRD) в таблицу DT#7

interface

uses
 DT_DbReformer,
 DbUpgrade;

type

 TUpgradeTo134_MAIN = class(TAdminBaseUpgrade)
 private
 protected
  procedure ModifyBD; override;
 public
  class function PrevVersion: Integer; override; // 133
  class function Version: Integer; override;     // 134
 end;

 TUpgradeTo134_DOC = class(TDocBaseUpgrade)
 private
  procedure AddLSubIDField;
  procedure ZeroLDocIDField;
 protected
  procedure ModifyBd; override;
  procedure InitRestorableTableList; override;

  class function NameEx: string; override;
 public
  class function PrevVersion: Integer; override; // 133
  class function Version: Integer; override;     // 134
 end;

implementation

uses
 Ht_Dll, Ht_Const,
 SysUtils,
 l3FileUtils,
 Dt_Const;

{$INCLUDE nodt_const.inc}

const
 DT7_TBL = 'DT#7001';
 c_LSubIDFieldName = 'LSubID';

class function TUpgradeTo134_MAIN.PrevVersion: Integer;
begin
 Result := 133;
end;

procedure fn_AddLSubIDField(var aStruct: TElemArray; aData: Pointer = nil);
const
 cTargetLen = 6;
 cLastIdx   = 5;
var
 l_Tmp: ThtElementInfo;
begin
 // увеличиваем количество полей
 SetLength(aStruct, cTargetLen);
 // добавл€ем поле
 FillChar(l_Tmp, SizeOf(ThtElementInfo), #0);
 with l_Tmp do
 begin
  wLength := 0;
  wOffset := 0;
  cClass  := EC_FIELD;
  cType   := ET_DWRD;
  cKey    := EK_NOTKEY;
  mName   := c_LSubIDFieldName;
 end;
 aStruct[cLastIdx] := l_Tmp;
end;

procedure TUpgradeTo134_MAIN.ModifyBD;
begin
 f_DbReformer.Log('”величиваем номер версии базы');
end;

class function TUpgradeTo134_MAIN.Version: Integer;
begin
 Result := 134;
end;

procedure TUpgradeTo134_DOC.AddLSubIDField;
begin
 with f_DbReformer do
 begin
  Log('*** ƒобавл€ем поле "LSubID" в DT#7001 ***');
  RestructTable(DT7_TBL, ffGarant, fn_AddLSubIDField);
 end; // with;
end;

procedure TUpgradeTo134_DOC.InitRestorableTableList;
begin
 inherited;
 with f_DbReformer do
 begin
  AddToRestorableList(FamilyTable(DT7_TBL));
 end;
end;

procedure TUpgradeTo134_DOC.ModifyBd;
begin
 AddLSubIDField;
 ZeroLDocIDField;
end;

class function TUpgradeTo134_DOC.NameEx: string;
begin
 Result := 'базы документов';
end;

class function TUpgradeTo134_DOC.PrevVersion: Integer;
begin
 Result := 133;
end;

class function TUpgradeTo134_DOC.Version: Integer;
begin
 Result := 134;
end;

procedure TUpgradeTo134_DOC.ZeroLDocIDField;
const
 c_LDocIDField = 5;
var
 l_Zero: LongWord;
begin
 with f_DbReformer do
 begin
  Log('*** ќбнул€ем поле "LDocID" в DT#7001 ***');
  l_Zero := 0;
  SetFieldValue(DT7_TBL, ffGarant, c_LDocIDField, l_Zero);
 end; // with;
end;


end.

