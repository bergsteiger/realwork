unit UpgradeTo108;

// 1. Добавление в таблицу AdminBase.FREE нового поля Limit ВЗАМЕН группы Unikey.
// (практически полная копия UpgradeTo106 за некоторым исключением)

{ $Id: UpgradeTo108.pas,v 1.5 2011/12/12 14:02:52 fireton Exp $ }
// $Log: UpgradeTo108.pas,v $
// Revision 1.5  2011/12/12 14:02:52  fireton
// - DbReformer и DbInfo переехали в DT
//
// Revision 1.4  2007/12/03 14:00:54  fireton
// - отвязываем updater от имен таблиц dt_const и проводим профилактику подобных злоупотреблений
//
// Revision 1.3  2004/12/03 18:19:12  step
// добавлен параметр в функции типаTStructChangeProc
//
// Revision 1.2  2004/05/26 09:58:03  step
// исправлен предок
//
// Revision 1.1  2004/05/26 09:01:50  step
// изменение структуры таблицы main.FREE
//

interface

uses
 DbUpgrade;


type

 TUpgradeTo108 = class(TAdminBaseUpgrade)
 protected
  procedure ModifyBd; override;
  procedure InitRestorableTableList; override;
 public
  class function PrevVersion: Integer; override; // 107
  class function Version: Integer; override;     // 108
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
 DT_FREE        = 'FREE';
 TEMP_DT_FREE   = 'FREE_NEW';

 MAX_LIMIT: LongWord = 64000; // MAX_WORD использовать нельзя, т.к. в табл. USERS  уже имеется 65000

class function TUpgradeTo108.PrevVersion: Integer;
begin
 Result := 107;
end;

procedure fn_ChangeFreeTableStructure(var aStruct: TElemArray; aData: Pointer = nil);
const
 c_FieldName = 'Limit';
begin
 // изменение третьего поля
 with aStruct[2] do
 begin
  wLength := 0;
  wOffset := 0;
  cClass  := EC_FIELD;
  cType   := ET_DWRD;
  cKey    := EK_NOTKEY;
  mName   := c_FieldName;
 end;
end;

procedure TUpgradeTo108.ModifyBd;
begin
 with f_DbReformer do
 begin
  Log('Создание новой пустой таблицы FREE с полем Limit.');
  CopyTableStruct(MainTable(DT_FREE),
                  MainTable(TEMP_DT_FREE),
                  fn_ChangeFreeTableStructure);

  Log('Копирование данных из старой таблицы FREE в новую.');
  CopyData(MainTable(DT_FREE),
           MainTable(TEMP_DT_FREE));

  Log('Заполнение нового поля Limit таблицы FREE.');
  SetFieldValue(MainTable(TEMP_DT_FREE),
                3,
                MAX_LIMIT);

  Log('Удаление старой таблицы FREE.');
  htDropTable(PChar(MainTable(DT_FREE)), nil, nil);

  Log('Переименование новой таблицы FREE.');
  htTableRename(PChar(MainTable(TEMP_DT_FREE)),
                nil,
                nil,
                PChar(MainTable(DT_FREE)));
 end; // with
end;

class function TUpgradeTo108.Version: Integer;
begin
 Result := 108;
end;

procedure TUpgradeTo108.InitRestorableTableList;
begin
 inherited;
 with f_DbReformer do
  AddToRestorableList(MainTable(DT_FREE));
end;

end.

