unit UpgradeTo128;

// Изменение длин полей некоторых таблиц

{ $Id: UpgradeTo128.pas,v 1.3 2011/12/12 14:02:52 fireton Exp $}

// $Log: UpgradeTo128.pas,v $
// Revision 1.3  2011/12/12 14:02:52  fireton
// - DbReformer и DbInfo переехали в DT
//
// Revision 1.2  2007/12/03 14:00:54  fireton
// - отвязываем updater от имен таблиц dt_const и проводим профилактику подобных злоупотреблений
//
// Revision 1.1  2007/08/21 14:05:28  fireton
// - upd 128
//

interface

uses
 DT_DbReformer,
 DbUpgrade;

type

 TUpgradeTo128_MAIN = class(TAdminBaseUpgrade)
 private
 protected
  procedure ModifyBD; override;
 public
  class function PrevVersion: Integer; override; // 127
  class function Version: Integer; override;     // 128
 end;

 TUpgradeTo128_DOC = class(TDocBaseUpgrade)
 private
  procedure ModifyTable(const aTableName: string; const aFieldNums: TFieldNums);
 protected
  procedure ModifyBd; override;
  procedure InitRestorableTableList; override;

  class function NameEx: string; override;
 public
  class function PrevVersion: Integer; override; // 127
  class function Version: Integer; override;     // 128
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

var
 g_Length : Word = 0;

class function TUpgradeTo128_MAIN.PrevVersion: Integer;
begin
 Result := 127;
end;

procedure fn_ChangeFieldsLength(var aStruct: TElemArray; aData: Pointer = nil);
var
 I: Integer;
 l_FieldNums: PFieldNums absolute aData;
begin
 if l_FieldNums = nil then
  Exit;

 for I := 0 to Length(l_FieldNums^) - 1 do
  aStruct[l_FieldNums^[I]].wLength := g_Length;
end;

procedure TUpgradeTo128_MAIN.ModifyBD;
begin
 f_DbReformer.Log('Увеличиваем номер версии базы');
end;

class function TUpgradeTo128_MAIN.Version: Integer;
begin
 Result := 128;
end;

const
 TBL_DT_3  = 'DT#3001';
 TBL_DT_G  = 'DT#G001';
 TBL_DT_5  = 'DT#5001';
 TBL_DT_7  = 'DT#7001';


procedure TUpgradeTo128_DOC.InitRestorableTableList;
begin
 inherited;
 with f_DbReformer do
 begin
  AddToRestorableList(FamilyTable(TBL_DT_3));
  AddToRestorableList(FamilyTable(TBL_DT_G));
  AddToRestorableList(FamilyTable(TBL_DT_5));
  AddToRestorableList(FamilyTable(TBL_DT_7));
 end;
end;

procedure TUpgradeTo128_DOC.ModifyBd;
var
 l_FieldNums: TFieldNums;
begin
 try
  g_Length := 200;

  SetLength(l_FieldNums, 2);
  l_FieldNums[0] := 1;
  l_FieldNums[1] := 2;
  ModifyTable(TBL_DT_3, l_FieldNums);

  SetLength(l_FieldNums, 2);
  l_FieldNums[0] := 1;
  l_FieldNums[1] := 2;
  ModifyTable(TBL_DT_G, l_FieldNums);

  SetLength(l_FieldNums, 2);
  l_FieldNums[0] := 1;
  l_FieldNums[1] := 2;
  ModifyTable(TBL_DT_5, l_FieldNums);

  g_Length := 40;

  SetLength(l_FieldNums, 1);
  l_FieldNums[0] := 2;
  ModifyTable(TBL_DT_7, l_FieldNums);
 finally
  l_FieldNums := nil;
 end;
end;

procedure TUpgradeTo128_DOC.ModifyTable(const aTableName: string; const aFieldNums: TFieldNums);
begin
 with f_DbReformer do
 begin
  Log('Создание пустой таблицы ' + aTableName + ' с новой структурой.');
  CopyTableStruct(FamilyTable(aTableName),
                  FamilyTable(TEMP_TABLE),
                  fn_ChangeFieldsLength,
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

class function TUpgradeTo128_DOC.NameEx: string;
begin
 Result := 'базы документов';
end;

class function TUpgradeTo128_DOC.PrevVersion: Integer;
begin
 Result := 127;
end;

class function TUpgradeTo128_DOC.Version: Integer;
begin
 Result := 128;
end;


end.

