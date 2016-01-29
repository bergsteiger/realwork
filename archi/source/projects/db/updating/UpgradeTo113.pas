unit UpgradeTo113;
// 1. Добавление в таблицу GUDT новых полей Pr_Import и Pr_Export.
// 2. Удаление неиспользуемой таблицы DICTSOUR.

{ $Id: UpgradeTo113.pas,v 1.3 2011/12/12 14:02:52 fireton Exp $ }
// $Log: UpgradeTo113.pas,v $
// Revision 1.3  2011/12/12 14:02:52  fireton
// - DbReformer и DbInfo переехали в DT
//
// Revision 1.2  2007/12/03 14:00:54  fireton
// - отвязываем updater от имен таблиц dt_const и проводим профилактику подобных злоупотреблений
//
// Revision 1.1  2005/09/09 16:58:11  step
// Добавление в таблицу GUDT новых полей.
// Сброс ненужной DICTSOUR.
//

interface

uses
 DbUpgrade;

type

 TUpgradeTo113 = class(TAdminBaseUpgrade)
 protected
  procedure ModifyBd; override;
  procedure InitRestorableTableList; override;
 public
  class function PrevVersion: Integer; override; // 112
  class function Version: Integer; override;     // 113
 end;

implementation

uses
 Ht_Dll, Ht_Const,
 SysUtils,
 DT_DbReformer,
 l3FileUtils;

{$INCLUDE nodt_const.inc} 

const
 TABLE_GUDT     = 'GUDT';
 NEW_TABLE_GUDT = 'GUDT_NEW';
 TABLE_DICTSOUR = 'DICTSOUR';
 DEF_PRIORITY: Smallint   = 0;

class function TUpgradeTo113.PrevVersion: Integer;
begin
 Result := 108;
end;

procedure fn_AddFieldsToGudt(var aStruct: TElemArray; aData: Pointer = nil);
const
 c_FieldName1 = 'Pr_Import';
 c_FieldName2 = 'Pr_Export';
begin
 SetLength(aStruct, Length(aStruct) + 2);

 // добавление полей
 FillChar(aStruct[3], SizeOf(aStruct[3]), #0);
 with aStruct[3] do
 begin
  wLength := 0;
  wOffset := 0;
  cClass  := EC_FIELD;
  cType   := ET_INTR;
  cKey    := EK_NOTKEY;
  mName   := c_FieldName1;
 end;

 FillChar(aStruct[4], SizeOf(aStruct[4]), #0);
 with aStruct[4] do
 begin
  wLength := 0;
  wOffset := 0;
  cClass  := EC_FIELD;
  cType   := ET_INTR;
  cKey    := EK_NOTKEY;
  mName   := c_FieldName2;
 end;

end;

procedure TUpgradeTo113.ModifyBd;
begin
 with f_DbReformer do
 begin
  Log('Создание новой пустой таблицы GUDT с новыми полями Pr_Import и Pr_Export.');
  CopyTableStruct(MainTable(TABLE_GUDT),
                  MainTable(NEW_TABLE_GUDT),
                  fn_AddFieldsToGudt);

  Log('Копирование данных из старой таблицы в новую.');
  CopyData(MainTable(TABLE_GUDT),
           MainTable(NEW_TABLE_GUDT));

  Log('Заполнение новых полей исходными значениями.');
  SetFieldValue(MainTable(NEW_TABLE_GUDT), 4, DEF_PRIORITY);
  SetFieldValue(MainTable(NEW_TABLE_GUDT), 5, DEF_PRIORITY);

  Log('Удаление старой таблицы.');
  htDropTable(PChar(MainTable(TABLE_GUDT)), nil, nil);

  Log('Переименование новой таблицы.');
  htTableRename(PChar(MainTable(NEW_TABLE_GUDT)),
                nil,
                nil,
                PChar(MainTable(TABLE_GUDT)));


  Log('Удаление неиспользуемой таблицы DICTSOUR.');
  htDropTable(PChar(MainTable(TABLE_DICTSOUR)), nil, nil);

 end; // with
end;

class function TUpgradeTo113.Version: Integer;
begin
 Result := 113;
end;

procedure TUpgradeTo113.InitRestorableTableList;
begin
 inherited;

 with f_DbReformer do
  AddToRestorableList(MainTable(TABLE_GUDT));
end;

end.

