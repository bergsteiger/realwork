unit UpgradeTo129;

// Изменение типа поля NewID в таблице DT#G (NewClasses) на DWORD

{ $Id: UpgradeTo129.pas,v 1.3 2011/12/12 14:02:52 fireton Exp $}

// $Log: UpgradeTo129.pas,v $
// Revision 1.3  2011/12/12 14:02:52  fireton
// - DbReformer и DbInfo переехали в DT
//
// Revision 1.2  2007/12/03 14:00:54  fireton
// - отвязываем updater от имен таблиц dt_const и проводим профилактику подобных злоупотреблений
//
// Revision 1.1  2007/09/06 12:26:12  fireton
// - 129 обновление
//


interface

uses
 DT_DbReformer,
 DbUpgrade;

type

 TUpgradeTo129_MAIN = class(TAdminBaseUpgrade)
 private
 protected
  procedure ModifyBD; override;
 public
  class function PrevVersion: Integer; override; // 128
  class function Version: Integer; override;     // 129
 end;

 TUpgradeTo129_DOC = class(TDocBaseUpgrade)
 private
  procedure ModifyTable(const aTableName: string; const aFieldNums: TFieldNums);
 protected
  procedure ModifyBd; override;
  procedure InitRestorableTableList; override;

  class function NameEx: string; override;
 public
  class function PrevVersion: Integer; override; // 128
  class function Version: Integer; override;     // 129
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

class function TUpgradeTo129_MAIN.PrevVersion: Integer;
begin
 Result := 128;
end;

procedure fn_ChangeField(var aStruct: TElemArray; aData: Pointer = nil);
var
 I: Integer;
 l_FieldNums: PFieldNums absolute aData;
begin
 if l_FieldNums = nil then
  Exit;
 for I := 0 to Length(l_FieldNums^) - 1 do
  aStruct[l_FieldNums^[I]].cType := ET_DWRD;
end;

procedure TUpgradeTo129_MAIN.ModifyBD;
begin
 f_DbReformer.Log('Увеличиваем номер версии базы');
end;

class function TUpgradeTo129_MAIN.Version: Integer;
begin
 Result := 129;
end;

const
 TBL_DT_G  = 'DT#G001';


procedure TUpgradeTo129_DOC.InitRestorableTableList;
begin
 inherited;
 with f_DbReformer do
 begin
  AddToRestorableList(FamilyTable(TBL_DT_G));
 end;
end;

procedure TUpgradeTo129_DOC.ModifyBd;
var
 l_FieldNums: TFieldNums;
begin
 try
  SetLength(l_FieldNums, 1);
  l_FieldNums[0] := 4;
  ModifyTable(TBL_DT_G, l_FieldNums);
 finally
  l_FieldNums := nil;
 end;
end;

procedure TUpgradeTo129_DOC.ModifyTable(const aTableName: string; const aFieldNums: TFieldNums);
begin
 with f_DbReformer do
 begin
  Log('Создание пустой таблицы ' + aTableName + ' с новой структурой.');
  CopyTableStruct(FamilyTable(aTableName),
                  FamilyTable(TEMP_TABLE),
                  fn_ChangeField,
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

class function TUpgradeTo129_DOC.NameEx: string;
begin
 Result := 'базы документов';
end;

class function TUpgradeTo129_DOC.PrevVersion: Integer;
begin
 Result := 128;
end;

class function TUpgradeTo129_DOC.Version: Integer;
begin
 Result := 129;
end;


end.

