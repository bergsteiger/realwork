unit UpgradeTo104;
// Изменение значений полей ShortName и FullName таблицы FILE по след. алгоритму:
//   если поле содержит подстроку "(снято с контроля)", то тогда
//   эта самая подстрока должна быть отрезана.

{ $Id: UpgradeTo104.pas,v 1.9 2015/02/10 08:04:16 fireton Exp $ }
// $Log: UpgradeTo104.pas,v $
// Revision 1.9  2015/02/10 08:04:16  fireton
// - исправляем несобирающееся
//
// Revision 1.8  2011/12/12 14:02:52  fireton
// - DbReformer и DbInfo переехали в DT
//
// Revision 1.7  2007/12/03 14:00:54  fireton
// - отвязываем updater от имен таблиц dt_const и проводим профилактику подобных злоупотреблений
//
// Revision 1.6  2007/08/14 14:31:48  lulin
// - оптимизируем перемещение блоков памяти.
//
// Revision 1.5  2004/05/25 15:41:49  step
// new: classes TDocBaseUpgrade, TAdminBaseUpgrade
//
// Revision 1.4  2004/05/07 17:37:48  step
// куча мелких исправлений
//
// Revision 1.3  2004/03/23 14:05:51  step
// bug fix
//
// Revision 1.2  2004/03/10 14:34:05  step
// поиск подстроки БЕЗ учета регистра
//
// Revision 1.1  2004/03/09 18:40:03  step
// добавлен update № 104 (изменение полей табл. FILE)
//

interface

uses
 DbUpgrade;

type

 TUpgradeTo104 = class(TDocBaseUpgrade)
 protected
  procedure ModifyBd; override;
  procedure InitRestorableTableList; override;
 public
  class function PrevVersion: Integer; override; // 103
  class function Version: Integer; override;     // 104
 end;

implementation

uses
 Ht_Dll,
 Ht_Const,
 SysUtils,
 l3Base,
 l3Chars,
 DT_DbReformer,
 StrUtils;

{$INCLUDE nodt_const.inc} 

const
 TABLE        = 'FILE001';
 SEARCH_SUBSTR = '(снято с контроля)';

class function TUpgradeTo104.PrevVersion: Integer;
begin
 Result := 103;
end;

function fn_RecalcField(gRecNo: LongInt;
                        fpRecord: Pointer;
                        fpUser: Pointer): Boolean; pascal;
var
 l_Found: PChar;
begin
 l_Found := SearchBuf(PChar(fpRecord) + PFieldData(fpUser)^.Offset,
                      PFieldData(fpUser)^.Length,
                      0,
                      0,
                      SEARCH_SUBSTR,
                      [soDown]);

 if l_Found <> nil then
 begin
  // сдвигаем хвост влево (затирая найденную подстроку)
  //   количество сдвигаемых байт = (длина поля) - ((отступ найденной подстроки) + (длина подстроки))
  l3Move((l_Found + Length(SEARCH_SUBSTR))^,
       l_Found^,
       PFieldData(fpUser)^.Length - (l_Found - (PChar(fpRecord) + PFieldData(fpUser)^.Offset)) - Length(SEARCH_SUBSTR));
  // добиваем пробелами то место, где только что был хвост (последние Length(SEARCH_SUBSTR) байт)
  l3FillChar((PChar(fpRecord) + PFieldData(fpUser)^.Offset + PFieldData(fpUser)^.Length - Length(SEARCH_SUBSTR))^,
           Length(SEARCH_SUBSTR),
           Ord(cc_HardSpace));
 end;

 Result := True;
end;

procedure TUpgradeTo104.ModifyBd;
begin
 with f_DbReformer do
 begin
  Log('Исправление значений поля FILE.SHORTNAME: удаление подстрок "(снято с контроля)"');
  RecalcStrField(FamilyTable(TABLE), 2, @fn_RecalcField, PChar('*' + SEARCH_SUBSTR + '*'));

  Log('Исправление значений поля FILE.FULLNAME: удаление подстрок "(снято с контроля)"');
  RecalcStrField(FamilyTable(TABLE), 3, @fn_RecalcField, PChar('*' + SEARCH_SUBSTR + '*'));
 end; // with
end;

class function TUpgradeTo104.Version: Integer;
begin
 Result := 104;
end;

procedure TUpgradeTo104.InitRestorableTableList;
begin
 inherited;
 with f_DbReformer do
  AddToRestorableList(FamilyTable(TABLE));
end;

end.

