unit UpgradeTo109;

// Изменение ширины текстовых полей NameR и NameE в таблице DT#5 до 90 символов.

{ $Id: UpgradeTo109.pas,v 1.4 2011/12/12 14:02:52 fireton Exp $ }
// $Log: UpgradeTo109.pas,v $
// Revision 1.4  2011/12/12 14:02:52  fireton
// - DbReformer и DbInfo переехали в DT
//
// Revision 1.3  2007/12/03 14:00:54  fireton
// - отвязываем updater от имен таблиц dt_const и проводим профилактику подобных злоупотреблений
//
// Revision 1.2  2004/12/03 18:19:12  step
// добавлен параметр в функции типаTStructChangeProc
//
// Revision 1.1  2004/10/20 15:51:36  step
// изменение структуры таблицы garant.DT#5 (ver. 109)
//

interface

uses
 DbUpgrade;

type

 TUpgradeTo109 = class(TDocBaseUpgrade)
 protected
  procedure ModifyBd; override;
  procedure InitRestorableTableList; override;
 public
  class function PrevVersion: Integer; override; // 108
  class function Version: Integer; override;     // 109
 end;

implementation

uses
 Ht_Dll, Ht_Const,
 SysUtils,
 DT_DbReformer,
 l3FileUtils,
 Dt_Const;

{$INCLUDE nodt_const.inc} 

const
 TABLE_DT5      = 'DT#5001';
 TEMP_TABLE_DT5 = 'DT#5_NEW';
 NEW_FIELD_WIDTH = 90;

class function TUpgradeTo109.PrevVersion: Integer;
begin
 Result := 107; // !!! предыдущая версия папки GARANT именно 107, а не 108.
                // Знайте, что 108-е обновление касалось папки MAIN.
end;

procedure fn_ChangeTableStructure(var aStruct: TElemArray; aData: Pointer = nil);
begin
 aStruct[1].wLength := NEW_FIELD_WIDTH; // изменение второго поля
 aStruct[2].wLength := NEW_FIELD_WIDTH; // изменение третьего поля
end;

procedure TUpgradeTo109.ModifyBd;
begin
 with f_DbReformer do
 begin
  Log('Создание новой пустой таблицы DT#5 с увеличенными полями.');
  CopyTableStruct(FamilyTable(TABLE_DT5),
                  FamilyTable(TEMP_TABLE_DT5),
                  fn_ChangeTableStructure);

  Log('Копирование данных из старой таблицы DT#5 в новую.');
  CopyData(FamilyTable(TABLE_DT5),
           FamilyTable(TEMP_TABLE_DT5));

  Log('Удаление старой таблицы DT#5.');
  htDropTable(PChar(FamilyTable(TABLE_DT5)), nil, nil);

  Log('Переименование новой таблицы в DT#5.');
  htTableRename(PChar(FamilyTable(TEMP_TABLE_DT5)),
                nil,
                nil,
                PChar(FamilyTable(TABLE_DT5)));
 end; // with
end;

class function TUpgradeTo109.Version: Integer;
begin
 Result := 109;
end;

procedure TUpgradeTo109.InitRestorableTableList;
begin
 inherited;
 with f_DbReformer do
  AddToRestorableList(FamilyTable(TABLE_DT5));
end;

end.

