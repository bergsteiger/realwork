unit msmModelElementListFactoryPrim;

// Модуль: "w:\common\components\gui\Garant\msm\msmModelElementListFactoryPrim.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmModelElementListFactoryPrim" MUID: (57F4EE2203C9)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , msmModelElementList
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
 , SyncObjs
;

type
 _ItemType_ = TmsmModelElementList;
 _l3UncomparabeObjectRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
 _seCriticalSectionHolder_Parent_ = _l3UncomparabeObjectRefList_;
 {$Include w:\common\components\rtl\Garant\ScriptEngine\seCriticalSectionHolder.imp.pas}
 TmsmModelElementListFactoryPrim = class(_seCriticalSectionHolder_)
 end;//TmsmModelElementListFactoryPrim

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *57F4EE2203C9impl_uses*
 //#UC END# *57F4EE2203C9impl_uses*
;

{$If not Declared(_DataType_)}type _DataType_ = Tl3Ptr;{$IfEnd}

{$If not Declared(_FindDataType_)}type _FindDataType_ = _ItemType_;{$IfEnd}

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_57F4EE2203C9_var*
//#UC END# *47B2C42A0163_57F4EE2203C9_var*
begin
//#UC START# *47B2C42A0163_57F4EE2203C9_impl*
 !!! Needs to be implemented !!!
//#UC END# *47B2C42A0163_57F4EE2203C9_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_57F4EE2203C9_var*
//#UC END# *47B99D4503A2_57F4EE2203C9_var*
begin
//#UC START# *47B99D4503A2_57F4EE2203C9_impl*
 Result := CI.rA.Element.CompareListKey(CI.rB.Element);
//#UC END# *47B99D4503A2_57F4EE2203C9_impl*
end;//CompareExistingItems

type _Instance_R_ = TmsmModelElementListFactoryPrim;

{$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}

{$Include w:\common\components\rtl\Garant\ScriptEngine\seCriticalSectionHolder.imp.pas}

end.
