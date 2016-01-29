unit UpgradeTo125;

// Приведение полей USER ID и т.п. типа WORD в таблицах семейства MAIN и GARANT к типу DWRD.
// А конкретно - PASS.USER_ID, USERS.ID, GULNK.Us_ID,

{ $Id: UpgradeTo125.pas,v 1.7 2011/12/12 14:02:52 fireton Exp $}

// $Log: UpgradeTo125.pas,v $
// Revision 1.7  2011/12/12 14:02:52  fireton
// - DbReformer и DbInfo переехали в DT
//
// Revision 1.6  2007/12/03 14:00:54  fireton
// - отвязываем updater от имен таблиц dt_const и проводим профилактику подобных злоупотреблений
//
// Revision 1.5  2007/05/11 08:37:53  narry
// - исправление ряда ошибок
//
// Revision 1.4  2007/03/13 14:36:01  fireton
// - bugfix: BB_LOG менять не надо, он и так нормальный был
//
// Revision 1.3  2007/03/12 13:55:17  fireton
// - bug fix: не модифицировалось ACCESS.DOCUM_GR
//
// Revision 1.2  2007/03/12 11:21:17  fireton
// - большие ID в словарях + большие USER ID
//
// Revision 1.1  2007/02/22 15:00:58  fireton
// - переход на 64 бита в HyTech
//


// ниже - история из прошлой жизни этого юнита (UpgradeTo115)

// Revision 1.3  2006/06/08 15:55:56  fireton
// - подготовка к переходу на большой User ID
//
// Revision 1.2.2.1  2006/06/08 09:26:58  fireton
// - перевод User ID на Longword
//

//

interface

uses
 DT_DbReformer,
 DbUpgrade;

type

 TUpgradeTo125_MAIN = class(TAdminBaseUpgrade)
 private
  procedure ModifyTable(const aTableName: string;
                        const aFieldNums: TFieldNums);
 protected
  procedure ModifyBd; override;
  procedure InitRestorableTableList; override;
 public
  class function PrevVersion: Integer; override; // 113
  class function Version: Integer; override;     // 115
 end;

 TUpgradeTo125_DOC = class(TDocBaseUpgrade)
 private
  procedure ModifyTable(const aTableName: string; const aFieldNums: TFieldNums);
 protected
  procedure ModifyBd; override;
  procedure InitRestorableTableList; override;

  class function NameEx: string; override;
 public
  class function PrevVersion: Integer; override; // 114
  class function Version: Integer; override;     // 115
 end;

implementation

uses
 Ht_Dll, Ht_Const,
 SysUtils,
 l3FileUtils,
 Dt_Const;

{$INCLUDE nodt_const.inc} 

const
 TEMP_TABLE = 'TEMP_TBL';

class function TUpgradeTo125_MAIN.PrevVersion: Integer;
begin
 //raise Exception.Create('Не задана TUpgradeTo125_MAIN.PrevVersion. Исправить!');
 Result := 120;
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

procedure TUpgradeTo125_MAIN.ModifyBd;
var
 l_FieldNums: TFieldNums;
 l_TRecs: TTableRecs;
begin
 try
  SetLength(l_FieldNums, 1);
  l_FieldNums[0] := 2;
  ModifyTable('PASS',     l_FieldNums);

  SetLength(l_FieldNums, 1);
  l_FieldNums[0] := 0;
  ModifyTable('USERS',    l_FieldNums);

  SetLength(l_FieldNums, 1);
  l_FieldNums[0] := 0;
  ModifyTable('GULNK',    l_FieldNums);
 finally
  l_FieldNums := nil;
 end;
 with f_DbReformer do
 try
  Log('Добавление новой записи в таблицу FREE.');
  SetLength(l_TRecs, 1);
  SetLength(l_Trecs[0], 3);
  l_TRecs[0][0] := 'USERS';
  l_TRecs[0][1] := '65001';
  l_TRecs[0][2] := '4294967294';
  InsertRecords(MainTable('FREE'), l_TRecs);
 finally
  l_TRecs := nil;
 end;
end;

class function TUpgradeTo125_MAIN.Version: Integer;
begin
 Result := 125;
end;

procedure TUpgradeTo125_MAIN.InitRestorableTableList;
const
 UPD_TABLES_AMOUNT = 4;
 UPD_TABLES: array [0..UPD_TABLES_AMOUNT - 1] of string =
  ('PASS', 'USERS', 'GULNK', 'FREE');
var
 I: Integer;
begin
 inherited;

 for I := 0 to UPD_TABLES_AMOUNT - 1 do
  AddToRestorableList(f_DbReformer.MainTable(UPD_TABLES[I]));
end;

procedure TUpgradeTo125_MAIN.ModifyTable(const aTableName: string;
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

const
 TBL_DT_9  = 'DT#9001';
 TBL_LOG   = 'LOG001';
 TBL_STAGE = 'STAGE001';


procedure TUpgradeTo125_DOC.InitRestorableTableList;
begin
 inherited;
 with f_DbReformer do
 begin
  AddToRestorableList(FamilyTable(TBL_DT_9));
  AddToRestorableList(FamilyTable(TBL_LOG));
  AddToRestorableList(FamilyTable(TBL_STAGE));
 end;
end;

procedure TUpgradeTo125_DOC.ModifyBd;
var
 l_FieldNums: TFieldNums;
begin
 try
  SetLength(l_FieldNums, 1);
  l_FieldNums[0] := 4;
  ModifyTable(TBL_DT_9, l_FieldNums);

  SetLength(l_FieldNums, 1);
  l_FieldNums[0] := 6;
  ModifyTable(TBL_LOG, l_FieldNums);

  SetLength(l_FieldNums, 1);
  l_FieldNums[0] := 4;
  ModifyTable(TBL_STAGE, l_FieldNums);

 finally
  l_FieldNums := nil;
 end;
end;

procedure TUpgradeTo125_DOC.ModifyTable(const aTableName: string; const aFieldNums: TFieldNums);
begin
 with f_DbReformer do
 begin
  Log('Создание пустой таблицы ' + aTableName + ' с новой структурой.');
  CopyTableStruct(FamilyTable(aTableName),
                  FamilyTable(TEMP_TABLE),
                  fn_ChangeFieldsType,
                  @aFieldNums);

  Log('Копирование данных из старой таблицы ' + aTableName + ' в новую.');
  CopyData(FamilyTable(aTableName),
           FamilyTable(TEMP_TABLE));

  Log('Удаление старой таблицы ' + aTableName + ' .');
  htDropTable(PChar(FamilyTable(aTableName)),
              TablePass(FamilyTable(aTableName)),
              TablePass(FamilyTable(aTableName)));

  Log('Переименование новой таблицы в ' + aTableName + ' .');
  htTableRename(PChar(FamilyTable(TEMP_TABLE)),
                TablePass(FamilyTable(TEMP_TABLE)),
                TablePass(FamilyTable(TEMP_TABLE)),
                PChar(FamilyTable(aTableName)));
 end; // with
end;

class function TUpgradeTo125_DOC.NameEx: string;
begin
 Result := 'базы документов';
end;

class function TUpgradeTo125_DOC.PrevVersion: Integer;
begin
 //raise Exception.Create('Не задана TUpgradeTo125_DOC.PrevVersion. Исправить!');
 Result := 120;
end;

class function TUpgradeTo125_DOC.Version: Integer;
begin
 Result := 125;
end;


end.

