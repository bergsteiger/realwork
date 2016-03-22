unit arBelaPubList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "ar"
// Модуль: "w:/common/components/rtl/Garant/ar/arBelaPubList.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::ar::Belarus::TarBelaPubList
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\l3Define.inc}

interface

{$If not defined(Nemesis)}
uses
  l3Interfaces,
  l3Date,
  l3ProtoDataContainer,
  l3Memory,
  l3Types,
  l3Core,
  l3Except,
  Classes
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}
type
 TarBelaPubInfo = record
   rPubSource : Il3CString; // IST – источник публикации правового акта (код значение) (м);
   rDate : TStDate; // IDAT – дата издания источника публикации (M);
   rYear : Word; // YEAR – год публикации (M);
   rNum : Il3CString; // NUMB – номер источника публикации (M);
   rArticle : Il3CString; // IN – номер статьи (M). При отсутствии информации о номере статьи за идентификатором поля через пробел ставится символ «-» (минус);
 end;//TarBelaPubInfo

 ParBelaPubInfo = ^TarBelaPubInfo;

 _ItemType_ = TarBelaPubInfo;
 _l3RecordListPrim_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3RecordListPrim.imp.pas}
 TarBelaPubList = class(_l3RecordListPrim_)
 end;//TarBelaPubList
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
uses
  l3String,
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}

// start class TarBelaPubList

{$If defined(l3Items_NeedsAssignItem) AND not defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
  const aFrom: _ItemType_); forward;
{$IfEnd} //l3Items_NeedsAssignItem AND not l3Items_NoSort


function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If not defined(l3Items_IsAtomic)}
function IsSameItems(const A: _ItemType_;
  const B: _ItemType_): Boolean;
//#UC START# *47B07CF403D0_56AF378901B9_var*
//#UC END# *47B07CF403D0_56AF378901B9_var*
begin
//#UC START# *47B07CF403D0_56AF378901B9_impl*
 Result :=
   l3Same(A.rPubSource, B.rPubSource) and
   (A.rDate = B.rDate) and
   (A.rYear = B.rYear) and
   l3Same(A.rNum, B.rNum) and
   l3Same(A.rArticle, B.rArticle);
//#UC END# *47B07CF403D0_56AF378901B9_impl*
end;//IsSameItems
{$IfEnd} //not l3Items_IsAtomic

{$If defined(l3Items_NeedsAssignItem) AND not defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
  const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_56AF378901B9_var*
//#UC END# *47B2C42A0163_56AF378901B9_var*
begin
//#UC START# *47B2C42A0163_56AF378901B9_impl*
 Assert(False);
//#UC END# *47B2C42A0163_56AF378901B9_impl*
end;//AssignItem
{$IfEnd} //l3Items_NeedsAssignItem AND not l3Items_NoSort

function CompareExistingItems(const CI: CompareItemsRec): Integer;
//#UC START# *47B99D4503A2_56AF378901B9_var*
//#UC END# *47B99D4503A2_56AF378901B9_var*
begin
//#UC START# *47B99D4503A2_56AF378901B9_impl*
 Result := CI.rA.rDate - CI.rB.rDate;
 if Result = 0 then
  Result := l3Compare(CI.rA.rPubSource.AsWStr, CI.rB.rPubSource.AsWStr);
 if Result = 0 then
  Result := l3Compare(CI.rA.rNum.AsWStr, CI.rB.rNum.AsWStr);
 if Result = 0 then
  Result := l3Compare(CI.rA.rArticle.AsWStr, CI.rB.rArticle.AsWStr);
//#UC END# *47B99D4503A2_56AF378901B9_impl*
end;//CompareExistingItems

type _Instance_R_ = TarBelaPubList;

{$Include w:\common\components\rtl\Garant\L3\l3RecordListPrim.imp.pas}


{$IfEnd} //not Nemesis
end.