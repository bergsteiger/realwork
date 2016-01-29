unit ncsPriorityMessageList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "cs"
// Модуль: "w:/common/components/rtl/Garant/cs/ncsPriorityMessageList.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::cs::Messages::TncsPriorityMessageList
//
// Список сортированый по приоритету и дате сообщения
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\cs\CsDefine.inc}

interface

{$If not defined(Nemesis)}
uses
  l3ProtoDataContainer,
  ncsMessage,
  l3Types,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except,
  Classes
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}
type
 _ItemType_ = TncsMessage;
 _l3UncomparabeObjectRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
 TncsPriorityMessageList = class(_l3UncomparabeObjectRefList_)
  {* Список сортированый по приоритету и дате сообщения }
 end;//TncsPriorityMessageList
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
uses
  Math,
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}

// start class TncsPriorityMessageList

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If defined(l3Items_NeedsAssignItem) AND not defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
  const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_544F977F036B_var*
//#UC END# *47B2C42A0163_544F977F036B_var*
begin
//#UC START# *47B2C42A0163_544F977F036B_impl*
 Assert(False);
//#UC END# *47B2C42A0163_544F977F036B_impl*
end;//AssignItem
{$IfEnd} //l3Items_NeedsAssignItem AND not l3Items_NoSort

function CompareExistingItems(const CI: CompareItemsRec): Integer;
//#UC START# *47B99D4503A2_544F977F036B_var*
//#UC END# *47B99D4503A2_544F977F036B_var*
begin
//#UC START# *47B99D4503A2_544F977F036B_impl*
 Assert(False);


{ if CI.rA.Priority > CI.rB.Priority then
  Result := 1
 else
  if CI.rA.Priority < CI.rB.Priority then
   Result := -1
  else}
   Result := Sign(CI.rA.TimeStamp - CI.rB.TimeStamp);
 if Result = 0 then
   Result := Sign(Ord(CI.rB.Kind) - Ord(CI.rA.Kind));
 if Result = 0 then
  Result := AnsiCompareText(CI.rA.MessageID, CI.rB.MessageID);
//#UC END# *47B99D4503A2_544F977F036B_impl*
end;//CompareExistingItems

type _Instance_R_ = TncsPriorityMessageList;

{$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}


{$IfEnd} //not Nemesis
end.