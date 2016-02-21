unit l3BaseRefInterfacedList;
 {* Список Tl3Base с интерфейсным представлением }

// Модуль: "w:\common\components\rtl\Garant\L3\l3BaseRefInterfacedList.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , l3ProtoObject
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
 , l3PureMixIns
;

type
 //_ItemType_ = Tl3ProtoObject;
 Il3CBaseList = interface
  ['{08465E92-C901-4CD1-81C0-9927BCCA72F1}']
  function pm_GetEmpty: Boolean;
  function pm_GetFirst: Tl3ProtoObject;
  function pm_GetLast: Tl3ProtoObject;
  function pm_GetItems(anIndex: Integer): Tl3ProtoObject;
  function pm_GetCount: Integer;
  property Empty: Boolean
   read pm_GetEmpty;
  property First: Tl3ProtoObject
   read pm_GetFirst;
   {* Первый элемент. }
  property Last: Tl3ProtoObject
   read pm_GetLast;
   {* Последний элемент. }
  property Items[anIndex: Integer]: Tl3ProtoObject
   read pm_GetItems;
   default;
  property Count: Integer
   read pm_GetCount;
   {* Число элементов. }
 end;//Il3CBaseList

 {$Define l3Items_NeedsSort}

 _ItemType_ = Tl3ProtoObject;
 _l3UncomparabeObjectRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
 Tl3BaseRefInterfacedList = class(_l3UncomparabeObjectRefList_, Il3CBaseList)
  {* Список Tl3Base с интерфейсным представлением }
  protected
   function pm_GetCount: Integer;
   procedure InitFields; override;
  public
   class function MakeI: Il3CBaseList; reintroduce;
 end;//Tl3BaseRefInterfacedList

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

{$If not Declared(_DataType_)}type _DataType_ = Tl3Ptr;{$IfEnd}

{$If not Declared(_FindDataType_)}type _FindDataType_ = Tl3ProtoObject;{$IfEnd}

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: Tl3ProtoObject;
 const aFrom: Tl3ProtoObject);
//#UC START# *47B2C42A0163_4A6D66010286_var*
//#UC END# *47B2C42A0163_4A6D66010286_var*
begin
//#UC START# *47B2C42A0163_4A6D66010286_impl*
 Assert(false);
//#UC END# *47B2C42A0163_4A6D66010286_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_4A6D66010286_var*
//#UC END# *47B99D4503A2_4A6D66010286_var*
begin
//#UC START# *47B99D4503A2_4A6D66010286_impl*
 {$IfDef l3Items_HasCustomSort}
 Assert(CI.rSortIndex = l3_siNative);
 {$EndIf l3Items_HasCustomSort}
 Result := Integer(CI.rA^) - Integer(CI.rB^);
//#UC END# *47B99D4503A2_4A6D66010286_impl*
end;//CompareExistingItems

type _Instance_R_ = Tl3BaseRefInterfacedList;

{$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}

class function Tl3BaseRefInterfacedList.MakeI: Il3CBaseList;
var
 l_Inst : Tl3BaseRefInterfacedList;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//Tl3BaseRefInterfacedList.MakeI

function Tl3BaseRefInterfacedList.pm_GetCount: Integer;
//#UC START# *4BB08B8902F2_4A6D66010286get_var*
//#UC END# *4BB08B8902F2_4A6D66010286get_var*
begin
//#UC START# *4BB08B8902F2_4A6D66010286get_impl*
 Result := Count;
//#UC END# *4BB08B8902F2_4A6D66010286get_impl*
end;//Tl3BaseRefInterfacedList.pm_GetCount

procedure Tl3BaseRefInterfacedList.InitFields;
//#UC START# *47A042E100E2_4A6D66010286_var*
//#UC END# *47A042E100E2_4A6D66010286_var*
begin
//#UC START# *47A042E100E2_4A6D66010286_impl*
 inherited;
 Sorted := true;
//#UC END# *47A042E100E2_4A6D66010286_impl*
end;//Tl3BaseRefInterfacedList.InitFields

end.
