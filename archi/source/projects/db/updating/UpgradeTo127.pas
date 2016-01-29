unit UpgradeTo127;

// Починка разломанного BB_LOG

{ $Id: UpgradeTo127.pas,v 1.9 2015/04/30 11:37:29 lukyanets Exp $}

// $Log: UpgradeTo127.pas,v $
// Revision 1.9  2015/04/30 11:37:29  lukyanets
// Заготовки Большого Брата
//
// Revision 1.8  2015/04/30 11:14:39  lukyanets
// Заготовки Большого Брата
//
// Revision 1.7  2014/04/18 05:49:36  fireton
// - ISab переехал в dtIntf
//
// Revision 1.6  2011/12/12 14:02:52  fireton
// - DbReformer и DbInfo переехали в DT
//
// Revision 1.5  2011/06/09 14:31:22  fireton
// - не собиралось
//
// Revision 1.4  2007/12/03 14:00:54  fireton
// - отвязываем updater от имен таблиц dt_const и проводим профилактику подобных злоупотреблений
//
// Revision 1.3  2007/05/11 08:37:53  narry
// - исправление ряда ошибок
//
// Revision 1.2  2007/05/07 08:07:01  fireton
// - ошибочно закоммитил предыдущую версию с отладочным кодом
//
// Revision 1.1  2007/05/04 11:59:58  fireton
// - исправляем Большого Брата
//

interface

uses
 DT_DbReformer,
 DbUpgrade;

type

 TUpgradeTo127 = class(TAdminBaseUpgrade)
 private
  procedure CorrectOperationIDs;
  function IsUpgradeNeeded: Boolean;
  procedure ModifyTable(const aTableName: string;
                        const aFieldNums: TFieldNums);
 protected
  procedure ModifyBd; override;
  procedure InitRestorableTableList; override;
 public
  class function PrevVersion: Integer; override; // 126
  class function Version: Integer; override;     // 127
 end;

implementation

uses
 Ht_Dll,
 Ht_Const,

 SysUtils,

 l3Base,
 l3FileUtils,

 dtIntf,
 dt_BBLog,
 Dt_Types,
 Dt_Const,
 DT_Err,
 DT_ATbl,
 DT_Sab,
 DT_Misc;

{$INCLUDE nodt_const.inc} 

const
 TEMP_TABLE = 'TEMP_TBL';

class function TUpgradeTo127.PrevVersion: Integer;
begin
 Result := 126;
end;

procedure fn_ChangeFieldsType(var aStruct: TElemArray; aData: Pointer = nil);
var
 I: Integer;
 l_FieldNums: PFieldNums absolute aData;
begin
 if l_FieldNums = nil then
  Exit;

 for I := 0 to Length(l_FieldNums^) - 1 do
  aStruct[l_FieldNums^[I]].cType := ET_WORD;
end;

procedure TUpgradeTo127.CorrectOperationIDs;
var
 l_Tbl    : TAbsHtTbl;
 l_Sab    : ISab;
 l_Tmp    : LongWord;
 l_HTStub : Pointer;

 function ModifyOperationID(gRecNo : LongInt; fpRecord : Pointer) : MFUNC_RET;
 var
  l_OperID: Longword;
 begin
  l_Tbl.GetFieldFromRecord(fpRecord, bbID_Operation, l_OperID);
  l_OperID := l_OperID shr 16; // перемещаем значение в младшее слово
  l_Tbl.PutFieldToRecord(fpRecord, bbID_Operation, l_OperID);
  Result := MFUNC_SUCCESS;
 end;

begin
 with f_DbReformer do
 begin
  l_Tbl := TAbsHtTbl.CreateWithOpen(MainFolder,
                                    TablePass(MainTable('BB_LOG')),
                                    'BB_LOG', TAB_PRIVATE);
  try
   l_Sab := MakeSab(l_Tbl);
   l_Tmp := $0000FFFF;
   l_Sab.Select(bbID_Operation, l_Tmp, GREAT);
   l_HTStub := HTStub3(@ModifyOperationID);
   try
    l_Tbl.ModifyRecs(l_Sab.HTSab, l_HTStub);
   finally
    HTStubFree(l_HTStub);
   end;
  finally
   l_Sab := nil;
   l3Free(l_Tbl);
  end;
 end;
end;

procedure TUpgradeTo127.ModifyBd;
var
 l_FieldNums: TFieldNums;
 l_TRecs: TTableRecs;
begin
 if IsUpgradeNeeded then
 begin
  CorrectOperationIDs;
  try
   SetLength(l_FieldNums, 1);
   l_FieldNums[0] := 1;
   ModifyTable('BB_LOG', l_FieldNums);
  finally
   l_FieldNums := nil;
  end;
 end
 else
  f_DbReformer.Log('Таблица BB_LOG нормальна. Обновление не требуется.');
end;

class function TUpgradeTo127.Version: Integer;
begin
 Result := 127;
end;

procedure TUpgradeTo127.InitRestorableTableList;
begin
 inherited;
 if IsUpgradeNeeded then
  AddToRestorableList(f_DbReformer.MainTable('BB_LOG'));
end;

function TUpgradeTo127.IsUpgradeNeeded: Boolean;
var
 l_Table: Ht_Const.THANDLE;
 l_Field: Ht_Const.ThtElementInfo;
begin
 Result := False;
 htTableOpen(PChar(f_DbReformer.MainTable('BB_LOG')),'corvax','corvax', TAB_PRIVATE, l_Table);
 try
  Ht(htTableElement(l_Table, 2, l_Field, False));
  Result := (l_Field.cType = ET_DWRD);
 finally
  htTableClose(l_Table);
 end;

end;

procedure TUpgradeTo127.ModifyTable(const aTableName: string;
                                    const aFieldNums: TFieldNums);
begin
 with f_DbReformer do
 begin
  Log('Создание пустой таблицы ' + aTableName + ' с новой структурой.');
  CopyTableStruct(MainTable(aTableName),
                  MainTable(TEMP_TABLE),
                  fn_ChangeFieldsType,
                  @aFieldNums);

  Log('Копирование данных из старой таблицы ' + aTableName + ' в новую.');
  CopyData(MainTable(aTableName),
           MainTable(TEMP_TABLE));

  Log('Удаление старой таблицы ' + aTableName + ' .');
  htDropTable(PChar(MainTable(aTableName)),
              TablePass(MainTable(aTableName)),
              TablePass(MainTable(aTableName)));

  Log('Переименование новой таблицы в ' + aTableName + ' .');
  htTableRename(PChar(MainTable(TEMP_TABLE)),
                TablePass(MainTable(TEMP_TABLE)),
                TablePass(MainTable(TEMP_TABLE)),
                PChar(MainTable(aTableName)));
 end; // with
end;

end.

