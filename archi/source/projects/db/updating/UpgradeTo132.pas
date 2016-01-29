unit UpgradeTo132;

// ƒобавл€ем поле Flags к таблице LNK#B дл€ флагов в св€з€х документа с
// источниками опубликовани€ <K 336134863>
//   Flags : BYTE

{ $Id: UpgradeTo132.pas,v 1.1 2012/02/08 07:26:55 fireton Exp $ }

// $Log: UpgradeTo132.pas,v $
// Revision 1.1  2012/02/08 07:26:55  fireton
// - обновление базы до 132 версии
//

interface

uses
 DT_DbReformer,
 DbUpgrade;

type

 TUpgradeTo132_MAIN = class(TAdminBaseUpgrade)
 private
 protected
  procedure ModifyBD; override;
 public
  class function PrevVersion: Integer; override; // 131
  class function Version: Integer; override;     // 132
 end;

 TUpgradeTo132_DOC = class(TDocBaseUpgrade)
 private
  procedure AddFlagsField;
 protected
  procedure ModifyBd; override;
  procedure InitRestorableTableList; override;

  class function NameEx: string; override;
 public
  class function PrevVersion: Integer; override; // 131
  class function Version: Integer; override;     // 132
 end;

implementation

uses
 Ht_Dll, Ht_Const,
 SysUtils,
 l3FileUtils,
 Dt_Const;

{$INCLUDE nodt_const.inc}

const
 LNKB_TBL = 'LNK#B001';
 c_FlagsFieldName = 'Flags';

class function TUpgradeTo132_MAIN.PrevVersion: Integer;
begin
 Result := 131;
end;

procedure fn_AddFlagsField(var aStruct: TElemArray; aData: Pointer = nil);
const
 cTargetLen = 6;
 cLastIdx   = 5;
 cTargetIdx = 4;
var
 l_Tmp: ThtElementInfo;
begin
 SetLength(aStruct, cTargetLen);
 // переносим индекс в конец списка (иначе получим ошибку)
 l_Tmp := aStruct[cTargetIdx];
 aStruct[cLastIdx] := l_Tmp;
 // добавление полей
 FillChar(l_Tmp, SizeOf(ThtElementInfo), #0);
 with l_Tmp do
 begin
  wLength := 0;
  wOffset := 0;
  cClass  := EC_FIELD;
  cType   := ET_BYTE;
  cKey    := EK_NOTKEY;
  mName   := c_FlagsFieldName;
 end;
 aStruct[cTargetIdx] := l_Tmp;
end;

procedure TUpgradeTo132_MAIN.ModifyBD;
begin
 f_DbReformer.Log('”величиваем номер версии базы');
end;

class function TUpgradeTo132_MAIN.Version: Integer;
begin
 Result := 132;
end;

procedure TUpgradeTo132_DOC.AddFlagsField;
begin
 with f_DbReformer do
 begin
  Log('*** ƒобавл€ем поле "Flags" в LNK#B001 ***');
  RestructTable(LNKB_TBL, ffGarant, fn_AddFlagsField);
 end; // with;
end;

procedure TUpgradeTo132_DOC.InitRestorableTableList;
begin
 inherited;
 with f_DbReformer do
 begin
  AddToRestorableList(FamilyTable(LNKB_TBL));
 end;
end;

procedure TUpgradeTo132_DOC.ModifyBd;
begin
 AddFlagsField;
end;

class function TUpgradeTo132_DOC.NameEx: string;
begin
 Result := 'базы документов';
end;

class function TUpgradeTo132_DOC.PrevVersion: Integer;
begin
 Result := 131;
end;

class function TUpgradeTo132_DOC.Version: Integer;
begin
 Result := 132;
end;


end.

