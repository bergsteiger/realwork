unit UpgradeTo120;

// ѕриведение полей ID и DICT_ID в таблицах DT#* и LNK#* к типу DWRD.
// ѕриведение к тому же типу и св€занных (с указанными выше) полей, а
// именно: DT#B.SOURCE, PRIOR.SOUR_ID, PRIOR.TYPE_ID, LOG.AUTHER, STAGE.USER.
// »справление значений в поле LIMIT таблицы FREE: 65534 -> 4294967294.


{ $Id: UpgradeTo120.pas,v 1.8 2011/12/12 14:02:52 fireton Exp $ }

// $Log: UpgradeTo120.pas,v $
// Revision 1.8  2011/12/12 14:02:52  fireton
// - DbReformer и DbInfo переехали в DT
//
// Revision 1.7  2007/12/03 14:00:54  fireton
// - отв€зываем updater от имен таблиц dt_const и проводим профилактику подобных злоупотреблений
//
// Revision 1.6  2007/10/19 13:53:15  narry
// - исправление ошибок обновлени€ с базы 113 на 129
//
// Revision 1.5  2007/05/11 08:37:53  narry
// - исправление р€да ошибок
//
// Revision 1.4  2007/03/12 13:55:17  fireton
// - bug fix: не модифицировалось ACCESS.DOCUM_GR
//
// Revision 1.3  2007/03/12 11:21:17  fireton
// - большие ID в словар€х + большие USER ID
//
// Revision 1.2  2005/02/14 15:29:59  step
// учтены новые таблицы DT#I и LNK#I
//
// Revision 1.1  2005/02/14 13:36:09  step
// исправлени€ WORD->DWRD перенесены на более поздний срок, отсюда и переименование 111,112 -> 120,121
//
// Revision 1.6  2005/02/10 12:59:56  step
// изменен список восстанавливаемых таблиц
//
// Revision 1.5  2005/02/09 17:36:51  step
// no message
//
// Revision 1.4  2005/02/07 17:14:07  step
// добавлена корректировка значений в пол€х LIMIT в табл. FREE
//
// Revision 1.3  2005/01/19 11:29:09  step
// доделаны UpgradeTo120 и UpgradeTo112 (оба касаютс€ изменени€ типа полей WORD --> DWRD)
//
// Revision 1.2  2004/12/03 18:20:45  step
// изменен алгоритм передачи номеров полей
//
// Revision 1.1  2004/12/02 15:55:23  step
// ѕриведение полей ID и DICT_ID в таблицах DT#* и LNK#* к типу DWRD (ver. 120)
//

interface

uses
 DT_DbReformer,
 DbUpgrade;

type

 TUpgradeTo120 = class(TDocBaseUpgrade)
 private
  procedure ModifyTable(const aTableName: string;
                        const aFieldNums: TFieldNums);
  procedure RecalcTableFree;
 protected
  procedure ModifyBd; override;
  procedure InitRestorableTableList; override;
 public
  class function PrevVersion: Integer; override; // 115
  class function Version: Integer; override;     // 120
 end;

 TUpgradeTo120_MAIN = class(TAdminBaseUpgrade)
 private
  procedure ModifyTable(const aTableName: string;
                        const aFieldNums: TFieldNums);
 protected
  procedure ModifyBd; override;
  procedure InitRestorableTableList; override;
 public
  class function PrevVersion: Integer; override; // 115
  class function Version: Integer; override;     // 120
 end;

implementation

uses
 Ht_Dll, Ht_Const,
 SysUtils,
 l3FileUtils,
 Dt_Const;

{$INCLUDE nodt_const.inc} 

const
 // все словари, кроме DT#4, DT#7, DT#9, DT#B, DT#3e, DT#Ge
 DICT_AMOUNT = 13;
 DICT_TABLES: array [0..DICT_AMOUNT - 1] of string = ('DT#1001',
                                                      'DT#2001',
                                                      'DT#3001',
                                                      //'DT#4001',
                                                      'DT#5001',
                                                      'DT#6001',
                                                      'DT#8001',
                                                      'DT#A001',
                                                      'DT#C001',
                                                      'DT#D001',
                                                      'DT#E001',
                                                      'DT#F001',
                                                      'DT#G001',
                                                      'DT#I001');

 // все линки, кроме LNK#4, LNK#7, LNK#9, LNK#B
 LINK_AMOUNT = 14;
 LINK_TABLES: array [0..LINK_AMOUNT - 1] of string = ('LNK#1001',
                                                      'LNK#2001',
                                                      'LNK#3001',
                                                      //'LNK#4001',
                                                      'LNK#5001',
                                                      'LNK#6001',
                                                      'LNK#8001',
                                                      'LNK#A001',
                                                      'LNK#C001',
                                                      'LNK#D001',
                                                      'LNK#E001',
                                                      'LNK#F001',
                                                      'LNK#G001',
                                                      'LNK#H001',
                                                      'LNK#I001');
 TEMP_TABLE = 'TEMP_TBL';

 TABLE_FREE = 'FREE001';

class function TUpgradeTo120.PrevVersion: Integer;
begin
 //raise Exception.Create('Ќе задана TUpgradeTo120.PrevVersion. »справить!');
 Result := 115;
end;

procedure fn_ChangeFieldsType(var aStruct: TElemArray; aData: Pointer = nil);
var
 I: Integer;
 l_FieldNums: PFieldNums absolute aData;
begin
 if l_FieldNums = nil then
  Exit;

 for I := 0 to Length(l_FieldNums^) - 1 do
  aStruct[l_FieldNums^[I]].cType := ET_DWRD;
end;

procedure TUpgradeTo120.ModifyBd;
var
 I: Integer;
 l_FieldNums: TFieldNums;
begin
 try

  // DICT's
  SetLength(l_FieldNums, 1);
  l_FieldNums[0] := 0;
  for I := 0 to DICT_AMOUNT - 1 do
   ModifyTable(DICT_TABLES[I], l_FieldNums);

  // LNK's
  SetLength(l_FieldNums, 1);
  l_FieldNums[0] := 1;
  for I := 0 to LINK_AMOUNT - 1 do
   ModifyTable(LINK_TABLES[I], l_FieldNums);

  // DT#B.SOURCE
  SetLength(l_FieldNums, 1);
  l_FieldNums[0] := 1;
  ModifyTable('DT#B001', l_FieldNums);

  // PRIOR.SOUR_ID, PRIOR.TYPE_ID
  SetLength(l_FieldNums, 2);
  l_FieldNums[0] := 0;
  l_FieldNums[1] := 1;
  ModifyTable('PRIOR001', l_FieldNums);

  // LOG.AUTHER
  SetLength(l_FieldNums, 1);
  l_FieldNums[0] := 6;
  ModifyTable('LOG001', l_FieldNums);

  // STAGE.USER
  SetLength(l_FieldNums, 1);
  l_FieldNums[0] := 4;
  ModifyTable('STAGE001', l_FieldNums);


  RecalcTableFree;

 finally
  l_FieldNums := nil;
 end;
end;

class function TUpgradeTo120.Version: Integer;
begin
 Result := 120;
end;

procedure TUpgradeTo120.InitRestorableTableList;
var
 I: Integer;
begin
 inherited;

 for I := 0 to DICT_AMOUNT - 1 do
  AddToRestorableList(f_DbReformer.FamilyTable(DICT_TABLES[I]));

 for I := 0 to LINK_AMOUNT - 1 do
  AddToRestorableList(f_DbReformer.FamilyTable(LINK_TABLES[I]));

 // DT#B.SOURCE
 AddToRestorableList(f_DbReformer.FamilyTable('DT#B001'));

 // PRIOR.SOUR_ID, PRIOR.TYPE_ID
 AddToRestorableList(f_DbReformer.FamilyTable('PRIOR001'));

 // LOG.AUTHER
 AddToRestorableList(f_DbReformer.FamilyTable('LOG001'));

 // STAGE.USER
 AddToRestorableList(f_DbReformer.FamilyTable('STAGE001'));

 // FREE
 AddToRestorableList(f_DbReformer.FamilyTable('FREE001'));
 
end;

procedure TUpgradeTo120.ModifyTable(const aTableName: string;
                                    const aFieldNums: TFieldNums);
begin
 
  with f_DbReformer do
  begin
    Log('—оздание пустой таблицы ' + aTableName + ' с новой структурой.');
    CopyTableStruct(FamilyTable(aTableName),
                    FamilyTable(TEMP_TABLE),
                    fn_ChangeFieldsType,
                    @aFieldNums);

    Log(' опирование данных из старой таблицы ' + aTableName + ' в новую.');
    CopyData(FamilyTable(aTableName),
             FamilyTable(TEMP_TABLE));

    Log('”даление старой таблицы ' + aTableName + ' .');
    htDropTable(PChar(FamilyTable(aTableName)),
                TablePass(FamilyTable(aTableName)),
                TablePass(FamilyTable(aTableName)));

    Log('ѕереименование новой таблицы в ' + aTableName + ' .');
    htTableRename(PChar(FamilyTable(TEMP_TABLE)),
                  TablePass(FamilyTable(TEMP_TABLE)),
                  TablePass(FamilyTable(TEMP_TABLE)),
                  PChar(FamilyTable(aTableName)));
  end; // with
end;

procedure TUpgradeTo120.RecalcTableFree;
var
 l_OldValue,
 l_NewValue: Longword;
begin
 l_OldValue := 65534;
 l_NewValue := 4294967294;
 with f_DbReformer do
 begin
  Log('»справление максимальных значений в табл. FREE (65534 -> 4294967294)');
  UpdateRecords(FamilyTable(TABLE_FREE), 3, l_OldValue, l_NewValue);
 end; // with
end;

procedure TUpgradeTo120_MAIN.InitRestorableTableList;
var
 I: Integer;
begin
 inherited;
 // ACCESS.Docum_Gr
 AddToRestorableList(f_DbReformer.MainTable('ACCESS'));
end;

procedure TUpgradeTo120_MAIN.ModifyBd;
var
 I: Integer;
 l_FieldNums: TFieldNums;
begin
 try
  // ACCESS.DOCUM_GR
  SetLength(l_FieldNums, 1);
  l_FieldNums[0] := 2;
  ModifyTable('ACCESS', l_FieldNums);
 finally
  l_FieldNums := nil;
 end;
end;

procedure TUpgradeTo120_MAIN.ModifyTable(const aTableName: string; const aFieldNums: TFieldNums);
begin
 with f_DbReformer do
 begin
  Log('—оздание пустой таблицы ' + aTableName + ' с новой структурой.');
  CopyTableStruct(MainTable(aTableName),
                  MainTable(TEMP_TABLE),
                  fn_ChangeFieldsType,
                  @aFieldNums);

  Log(' опирование данных из старой таблицы ' + aTableName + ' в новую.');
  CopyData(MainTable(aTableName),
           MainTable(TEMP_TABLE));

  Log('”даление старой таблицы ' + aTableName + ' .');
  htDropTable(PChar(MainTable(aTableName)),
              TablePass(MainTable(aTableName)),
              TablePass(MainTable(aTableName)));

  Log('ѕереименование новой таблицы в ' + aTableName + ' .');
  htTableRename(PChar(MainTable(TEMP_TABLE)),
                TablePass(MainTable(TEMP_TABLE)),
                TablePass(MainTable(TEMP_TABLE)),
                PChar(MainTable(aTableName)));
 end; // with
end;

class function TUpgradeTo120_MAIN.PrevVersion: Integer;
begin
 //raise Exception.Create('Ќе задана TUpgradeTo120.PrevVersion. »справить!');
 Result := 115;
end;

class function TUpgradeTo120_MAIN.Version: Integer;
begin
 Result := 120;
end;


end.

