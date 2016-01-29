unit UpgradeTo106;
// 1. Добавление в таблицу DocBase.FREE нового поля Limit ВЗАМЕН группы Unikey.

{ $Id: UpgradeTo106.pas,v 1.8 2015/02/10 08:04:16 fireton Exp $ }
// $Log: UpgradeTo106.pas,v $
// Revision 1.8  2015/02/10 08:04:16  fireton
// - исправляем несобирающееся
//
// Revision 1.7  2011/12/12 14:02:52  fireton
// - DbReformer и DbInfo переехали в DT
//
// Revision 1.6  2007/12/03 14:00:54  fireton
// - отвязываем updater от имен таблиц dt_const и проводим профилактику подобных злоупотреблений
//
// Revision 1.5  2004/12/03 18:19:12  step
// добавлен параметр в функции типаTStructChangeProc
//
// Revision 1.4  2004/05/26 09:01:50  step
// изменение структуры таблицы main.FREE
//
// Revision 1.3  2004/05/25 15:41:49  step
// new: classes TDocBaseUpgrade, TAdminBaseUpgrade
//
// Revision 1.2  2004/05/07 17:37:48  step
// куча мелких исправлений
//
// Revision 1.1  2004/04/20 09:46:07  step
// изменение табл. FREE (ver. 106)
//

interface

uses
 DbUpgrade;


type

 TUpgradeTo106 = class(TDocBaseUpgrade)
 protected
  procedure ModifyBd; override;
  procedure InitRestorableTableList; override;
 public
  class function PrevVersion: Integer; override; // 105
  class function Version: Integer; override;     // 106
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
 DT_FREE        = 'FREE001';
 TEMP_DT_FREE   = 'FREE_NEW';

 BIG_LIMIT:   LongWord = $FFFFFFFF{MAX_DWRD};
 SMALL_LIMIT: LongWord = $FFFF{MAX_WORD};
 TABLES_WITH_BIG_ID = 'FILE*|HLINK*|DT#7*|DT#9*|DT#B*';
 LIMIT_OFFSET = 12;

class function TUpgradeTo106.PrevVersion: Integer;
begin
 Result := 105;
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

function fn_SetBigLimit(gRecNo: LongInt;
                        fpRecord: Pointer;
                        fpUser: Pointer): Boolean; pascal;
begin
 PLongWord(PChar(fpRecord) + LIMIT_OFFSET)^ := BIG_LIMIT;
 Result := True;
end;

procedure TUpgradeTo106.ModifyBd;
begin
 with f_DbReformer do
 begin
  Log('Создание новой пустой таблицы FREE с полем Limit.');
  CopyTableStruct(FamilyTable(DT_FREE),
                  FamilyTable(TEMP_DT_FREE),
                  fn_ChangeFreeTableStructure);

  Log('Копирование данных из старой таблицы FREE в новую.');
  CopyData(FamilyTable(DT_FREE),
           FamilyTable(TEMP_DT_FREE));

  Log('Заполнение нового поля Limit таблицы FREE.');
  // сначала заполним все поля Limit значением SMALL_LIMIT
  SetFieldValue(FamilyTable(TEMP_DT_FREE),
                3,
                SMALL_LIMIT);

  // затем выборочно изменим поля Limit (новое значение BIG_LIMIT)
  RecalcStrField(FamilyTable(TEMP_DT_FREE),
                 1,
                 @fn_SetBigLimit,
                 PChar(TABLES_WITH_BIG_ID));

  Log('Удаление старой таблицы FREE.');
  htDropTable(PChar(FamilyTable(DT_FREE)), nil, nil);

  Log('Переименование новой таблицы FREE.');
  htTableRename(PChar(FamilyTable(TEMP_DT_FREE)),
                nil,
                nil,
                PChar(FamilyTable(DT_FREE)));
 end; // with
end;

class function TUpgradeTo106.Version: Integer;
begin
 Result := 106;
end;

procedure TUpgradeTo106.InitRestorableTableList;
begin
 inherited;
 with f_DbReformer do
  AddToRestorableList(FamilyTable(DT_FREE));
end;

end.

