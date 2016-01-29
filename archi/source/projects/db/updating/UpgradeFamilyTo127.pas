unit UpgradeFamilyTo127;

interface

uses
 DT_DbReformer,
 DbUpgrade;

type
 TUpgradeTo127_DOC = class(TDocBaseUpgrade)
 protected
  procedure ModifyBd; override;
  //procedure InitRestorableTableList; override;

  class function NameEx: string; override;
 public
  class function PrevVersion: Integer; override;
  class function Version: Integer; override;
 end;

implementation
uses
 HT_Const,
 Ht_Dll;

{$INCLUDE nodt_const.inc}

type
 TFreeRec = packed record
  TblName : array [0..7] of Char;
  FreeNum : Integer;
  Limit   : Integer;
 end;

const
 DT_FREE = 'FREE001';
 NEW_REC: TFreeRec = (TblName: 'DT#J'; FreeNum: 1; Limit: MaxInt);

procedure fn_ChangeCharLength(var aStruct: TElemArray; aData: Pointer = nil);
begin
 aStruct[1].wLength := 100;
 aStruct[2].wLength := 100;
end;

procedure TUpgradeTo127_DOC.ModifyBd;
var
 l_TableName  : string;
 l_TableHandle: HT_Const.THANDLE;
begin
 with f_DbReformer do
 begin
  Log('Создание новой таблицы DT#J');
  CopyTableStruct(FamilyTable('DT#2001'), FamilyTable('DT#J001'), fn_ChangeCharLength);
  Log('Создание новой таблицы LNK#J');
  CopyTableStruct(FamilyTable('LNK#2001'), FamilyTable('LNK#J001'));
  Log('Добавление диапазона в таблицу FREE');
  l_TableName := FamilyTable(DT_FREE);
  htTableOpen(PChar(l_TableName),
              nil,
              nil,
              TAB_PRIVATE,
              l_TableHandle);
  try
   htRecordAdd(l_TableHandle, @NEW_REC);
  finally
   htTableClose(l_TableHandle);
  end;
  htUpdateTable(PChar(l_TableName), nil, nil, True, True);
 end;
end;

class function TUpgradeTo127_DOC.NameEx: string;
begin
 Result := 'базы документов';
end;

class function TUpgradeTo127_DOC.PrevVersion: Integer;
begin
 Result := 125;
end;

class function TUpgradeTo127_DOC.Version: Integer;
begin
 Result := 127;
end;

end.
