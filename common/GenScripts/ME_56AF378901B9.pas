unit arBelaPubList;

// ћодуль: "w:\common\components\rtl\Garant\ar\arBelaPubList.pas"
// —тереотип: "SimpleClass"

{$Include l3Define.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , l3ProtoDataContainer
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
 , l3Date
;

type
 ParBelaPubInfo = ^TarBelaPubInfo;

 TarBelaPubInfo = record
  rPubSource: Il3CString;
   {* IST Ц источник публикации правового акта (код значение) (м); }
  rDate: TStDate;
   {* IDAT Ц дата издани€ источника публикации (M); }
  rYear: Word;
   {* YEAR Ц год публикации (M); }
  rNum: Il3CString;
   {* NUMB Ц номер источника публикации (M); }
  rArticle: Il3CString;
   {* IN Ц номер статьи (M). ѕри отсутствии информации о номере статьи за идентификатором пол€ через пробел ставитс€ символ Ђ-ї (минус); }
 end;//TarBelaPubInfo

 _ItemType_ = TarBelaPubInfo;
 _l3RecordListPrim_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3RecordListPrim.imp.pas}
 TarBelaPubList = class(_l3RecordListPrim_)
 end;//TarBelaPubList
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , l3String
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_); forward;
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)
function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If NOT Defined(l3Items_IsAtomic)}
function IsSameItems(const A: _ItemType_;
 const B: _ItemType_): Boolean;
 {* —равнивает элементы списка }
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
{$IfEnd} // NOT Defined(l3Items_IsAtomic)

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_56AF378901B9_var*
//#UC END# *47B2C42A0163_56AF378901B9_var*
begin
//#UC START# *47B2C42A0163_56AF378901B9_impl*
 Assert(False);
//#UC END# *47B2C42A0163_56AF378901B9_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* —равнивает два существующих элемента. }
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
{$IfEnd} // NOT Defined(Nemesis)

end.
