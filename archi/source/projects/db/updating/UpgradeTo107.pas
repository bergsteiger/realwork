unit UpgradeTo107;
// ƒобавление в таблицу FREE записи "dictExtN 3700000 3749999".

{ $Id: UpgradeTo107.pas,v 1.6 2011/12/12 14:02:52 fireton Exp $ }
// $Log: UpgradeTo107.pas,v $
// Revision 1.6  2011/12/12 14:02:52  fireton
// - DbReformer и DbInfo переехали в DT
//
// Revision 1.5  2007/12/03 14:00:54  fireton
// - отв€зываем updater от имен таблиц dt_const и проводим профилактику подобных злоупотреблений
//
// Revision 1.4  2004/06/21 15:39:14  step
// убран вызов RestoreHlkFile
//
// Revision 1.3  2004/05/25 15:41:49  step
// new: classes TDocBaseUpgrade, TAdminBaseUpgrade
//
// Revision 1.2  2004/05/07 17:37:48  step
// куча мелких исправлений
//
// Revision 1.1  2004/05/06 14:09:13  step
// добавление интервала в табл. FREE
//

interface

uses
 DbUpgrade;

type

 TUpgradeTo107 = class(TDocBaseUpgrade)
 protected
  procedure ModifyBd; override;
  procedure InitRestorableTableList; override;
 public
  class function PrevVersion: Integer; override; // 106
  class function Version: Integer; override;     // 107
 end;

implementation

uses
 Ht_Dll, Ht_Const,
 DT_DbReformer,
 Dt_Const;

{$INCLUDE nodt_const.inc}

type
 TFreeRec = packed record
  TblName : array [0..7] of Char;
  FreeNum : Integer;
  Limit   : Integer;
 end;

const
 DT_FREE = 'FREE001';
 NEW_REC: TFreeRec = (TblName: 'DICTEXTN'; FreeNum: 3700000; Limit: 3749999);

class function TUpgradeTo107.PrevVersion: Integer;
begin
 Result := 106;
end;

procedure TUpgradeTo107.ModifyBd;
var
 l_TableHandle: HT_Const.THANDLE;
 l_TableName: string;
begin
 with f_DbReformer do
 begin
  Log('ƒобавление в таблицу FREE записи "DICTEXTN 3700000 3749999"');
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

class function TUpgradeTo107.Version: Integer;
begin
 Result := 107;
end;

procedure TUpgradeTo107.InitRestorableTableList;
begin
 inherited;
 with f_DbReformer do
  AddToRestorableList(FamilyTable(DT_FREE));
end;

end.

