unit UpgradeTo101;
// 1. "Сжатие" таблицы DT#B (устранение дубликатов (Source+StartDate+EndDate+Number))
//    и замена старых DT#B.Id на новые.
//    Как следствие: пересчет полей DT#9.Source и полей LNK#B.DictId в соответствии
//                   с новыми DT#B.Id.
// 2. Добавление в таблицу LNK#B новых полей PAGES и COMENT.
// 3. Смена типа ключа у таблицы LNK#7: (DocId+DictId) должен быть уникальным


{ $Id: UpgradeTo101.pas,v 1.10 2011/12/12 14:02:52 fireton Exp $ }
// $Log: UpgradeTo101.pas,v $
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

type

 TUpgradeTo101 = class(TDocBaseUpgrade)
 protected
  procedure ModifyBd; override;
  procedure InitRestorableTableList; override;
 public
  class function PrevVersion: Integer; override; // 100
  class function Version: Integer; override;     // 101
 end;

implementation

uses
 SysUtils,
 Ht_Dll, Ht_Const,
 DT_DbReformer;

{$INCLUDE nodt_const.inc} 

class function TUpgradeTo101.PrevVersion: Integer;
begin
 Result := 100;
end;

procedure fn_AddUniqKeyToDtB(var aStruct: TElemArray; aData: Pointer = nil);
const
 c_FieldName = 'UniqKey';
var
 l_ElemNum: Integer;
begin
 // добавление уник. ключа
 SetLength(aStruct, Length(aStruct) + 1);
 l_ElemNum := Length(aStruct) - 1;
 with aStruct[l_ElemNum] do
 begin
  wLength := 4;
  wOffset := 2;
  cClass  := EC_GROUP;
  cType   := ET_CHAR;
  cKey    := EK_UNIQUE;
  //mName  - см. ниже
 end;
 htStringToChars(@aStruct[l_ElemNum].mName,
                 PChar(c_FieldName),
                 Length(c_FieldName));
end;

procedure fn_AddPagesComentToLnkB(var aStruct: TElemArray; aData: Pointer = nil);
const
 c_PagesFieldName = 'Pages';
 c_ComentFieldName = 'Coment';
var
 l_ElemNum: Integer;
begin
 SetLength(aStruct, Length(aStruct) + 2);

 // сдвиг последнего поля BothKey
 aStruct[4] := aStruct[2];
 FillChar(aStruct[2], SizeOf(aStruct[2]), 0);

 // добавление поля Pages
 l_ElemNum := 2;
 FillChar(aStruct[l_ElemNum], SizeOf(aStruct[l_ElemNum]), #0);
 with aStruct[l_ElemNum] do
 begin
  wLength := 128;
  wOffset := 0;
  cClass  := EC_FIELD;
  cType   := ET_CHAR;
  cKey    := EK_NOTKEY;
  mName   := c_PagesFieldName;
 end;

 // добавление поля Coment
 l_ElemNum := 3;
 FillChar(aStruct[l_ElemNum], SizeOf(aStruct[l_ElemNum]), #0);
 with aStruct[l_ElemNum] do
 begin
  wLength := 255;
  wOffset := 0;
  cClass  := EC_FIELD;
  cType   := ET_CHAR;
  cKey    := EK_NOTKEY;
  mName   := c_ComentFieldName;
 end;
end;

procedure TUpgradeTo101.ModifyBd;
var
 l_FieldNums: TFieldNums;
 l_EmptyInt: Integer;
begin
 with f_DbReformer do
 begin
  Log('Создание новой пустой таблицы DT#B с новым уникальным ключом');
  CopyTableStruct(FamilyTable('DT#B001'),
                  FamilyTable('DT#B_NEW'),
                  fn_AddUniqKeyToDtB);

  Log('Копирование уникальных записей из старой таблицы в новую');
  SetLength(l_FieldNums, 4);
  try
   // номера полей, определяющих уникальные записи
   l_FieldNums[0] := 2;
   l_FieldNums[1] := 3;
   l_FieldNums[2] := 4;
   l_FieldNums[3] := 5;
   CopyUniqData(FamilyTable('DT#B001'),
                FamilyTable('DT#B_NEW'),
                l_FieldNums);
  finally
   l_FieldNums := nil;
  end;

  Log('Вычисление новых значений поля DT#B.Id');
  RenumField(FamilyTable('DT#B_NEW'), 1);

  Log('Пересчет таблицы DT#9 по новым значениям DT#B.Id');
  l_EmptyInt := 0;
  RecalcReferences(FamilyTable('DT#9001'),
                   3,
                   @l_EmptyInt,
                   FamilyTable('DT#B001'),
                   FamilyTable('DT#B_NEW'),
                   1,
                   7);

  Log('Пересчет таблицы LNK#B по новым значениям DT#B.Id');
  l_EmptyInt := 0;
  RecalcReferences(FamilyTable('LNK#B001'),
                   2,
                   @l_EmptyInt,
                   FamilyTable('DT#B001'),
                   FamilyTable('DT#B_NEW'),
                   1,
                   7);

  Log('Создание новой пустой таблицы LNK#B с новыми полями: PAGES, COMENT');
  CopyTableStruct(FamilyTable('LNK#B001'),
                  FamilyTable('LNK#BNEW'),
                  fn_AddPagesComentToLnkB);

  Log('Копирование записей из старой таблицы LNK#B в новую');
  CopyData(FamilyTable('LNK#B001'),
           FamilyTable('LNK#BNEW'));

  Log('Удаление старой таблицы LNK#B');
  htDropTable(PChar(FamilyTable('LNK#B001')), nil, nil);

  Log('Переименование новой таблицы LNK#B');
  htTableRename(PChar(FamilyTable('LNK#BNEW')),
                nil,
                nil,
                PChar(FamilyTable('LNK#B001')));

  Log('Удаление старой таблицы DT#B');
  htDropTable(PChar(FamilyTable('DT#B001')), nil, nil);

  Log('Переименование новой таблицы DT#B');
  htTableRename(PChar(FamilyTable('DT#B_NEW')),
                nil,
                nil,
                PChar(FamilyTable('DT#B001')));

  Log('Смена типа ключа у таблицы LNK#7');
  htChangeKeyType(PChar(FamilyTable('LNK#7001')), nil, nil, 3, EK_UNIQUE, False, False);
 end; // with
end;

class function TUpgradeTo101.Version: Integer;
begin
 Result := 101;
end;

procedure TUpgradeTo101.InitRestorableTableList;
begin
 inherited;
 with f_DbReformer do
 begin
  AddToRestorableList(FamilyTable('DT#B001'));
  AddToRestorableList(FamilyTable('LNK#B001'));
  AddToRestorableList(FamilyTable('DT#9001'));
  AddToRestorableList(FamilyTable('LNK#7001'));
 end;
end;

end.




