unit UpgradeTo102;
// 1. Добавление в таблицу DT#A нового поля ShName.

{ $Id: UpgradeTo102.pas,v 1.10 2011/12/12 14:02:52 fireton Exp $ }
// $Log: UpgradeTo102.pas,v $
// Revision 1.10  2011/12/12 14:02:52  fireton
// - DbReformer и DbInfo переехали в DT
//
// Revision 1.9  2007/12/03 14:00:54  fireton
// - отвязываем updater от имен таблиц dt_const и проводим профилактику подобных злоупотреблений
//
// Revision 1.8  2004/12/03 18:19:12  step
// добавлен параметр в функции типаTStructChangeProc
//
// Revision 1.7  2004/05/25 15:41:49  step
// new: classes TDocBaseUpgrade, TAdminBaseUpgrade
//
// Revision 1.6  2004/05/07 17:37:47  step
// куча мелких исправлений
//
// Revision 1.5  2004/03/09 18:40:03  step
// добавлен update № 104 (изменение полей табл. FILE)
//
// Revision 1.4  2004/03/05 09:08:50  step
// мелкие исправления
//
// Revision 1.3  2004/03/04 18:03:10  step
// исправлен алгоритм сохранения-восстановления
//
// Revision 1.2  2004/03/02 15:47:00  step
// куча мелких изменений
//
// Revision 1.1  2004/03/01 19:04:54  step
// Занесен в CVS
//

interface

uses
 DbUpgrade;

{$INCLUDE nodt_const.inc} 

type

 TUpgradeTo102 = class(TDocBaseUpgrade)
 protected
  procedure ModifyBd; override;
  procedure InitRestorableTableList; override;
 public
  class function PrevVersion: Integer; override; // 101
  class function Version: Integer; override;     // 102
 end;

implementation

uses
 Ht_Dll, Ht_Const,
 SysUtils,
 DT_DbReformer,
 l3FileUtils;

const
 DT_A        = 'DT#A001';
 TEMP_DT_A   = 'DT#A_NEW';

class function TUpgradeTo102.PrevVersion: Integer;
begin
 Result := 101;
end;

procedure fn_AddShNameToDtA(var aStruct: TElemArray; aData: Pointer = nil);
const
 c_FieldName = 'ShName';
begin
 SetLength(aStruct, Length(aStruct) + 1);

 // добавление поля ShName
 FillChar(aStruct[3], SizeOf(aStruct[3]), #0);
 with aStruct[3] do
 begin
  wLength := 50;
  wOffset := 0;
  cClass  := EC_FIELD;
  cType   := ET_CHAR;
  cKey    := EK_NOTKEY;
  mName   := c_FieldName;
 end;
end;

procedure TUpgradeTo102.ModifyBd;
begin
 with f_DbReformer do
 begin
  Log('Создание новой пустой таблицы DT#A с полем ShName');
  CopyTableStruct(FamilyTable(DT_A),
                  FamilyTable(TEMP_DT_A),
                  fn_AddShNameToDtA);

  Log('Копирование данных из старой таблицы в новую');
  CopyData(FamilyTable(DT_A),
           FamilyTable(TEMP_DT_A));

  Log('Удаление старой таблицы');
  htDropTable(PChar(FamilyTable(DT_A)), nil, nil);

  Log('Переименование новой таблицы');
  htTableRename(PChar(FamilyTable(TEMP_DT_A)),
                nil,
                nil,
                PChar(FamilyTable(DT_A)));
 end; // with
end;

class function TUpgradeTo102.Version: Integer;
begin
 Result := 102;
end;

procedure TUpgradeTo102.InitRestorableTableList;
begin
 inherited;
 with f_DbReformer do
  AddToRestorableList(FamilyTable(DT_A));
end;

end.

