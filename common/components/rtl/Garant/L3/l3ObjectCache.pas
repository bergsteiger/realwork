unit l3ObjectCache;
 {* Кеш объектов. }

// Модуль: "w:\common\components\rtl\Garant\L3\l3ObjectCache.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3SimpleDataContainer
 , l3ProtoDataContainer
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = Tl3ProtoDataContainer;
 _l3UncomparabeObjectRefList_Parent_ = Tl3SimpleDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
 Tl3ObjectCache = class(_l3UncomparabeObjectRefList_)
  {* Кеш объектов. }
  protected
   {$If NOT Defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
    {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
 end;//Tl3ObjectCache

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_4773DB430315_var*
//#UC END# *47B2C42A0163_4773DB430315_var*
begin
//#UC START# *47B2C42A0163_4773DB430315_impl*
 Assert(false);
//#UC END# *47B2C42A0163_4773DB430315_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_4773DB430315_var*
//#UC END# *47B99D4503A2_4773DB430315_var*
begin
//#UC START# *47B99D4503A2_4773DB430315_impl*
 {$IfDef l3Items_HasCustomSort}
 Assert(CI.rSortIndex = l3_siNative);
 {$EndIf l3Items_HasCustomSort}
 Result := Integer(CI.rA^) - Integer(CI.rB^);
//#UC END# *47B99D4503A2_4773DB430315_impl*
end;//CompareExistingItems

type _Instance_R_ = Tl3ObjectCache;

{$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}

{$If NOT Defined(DesignTimeLibrary)}
class function Tl3ObjectCache.IsCacheable: Boolean;
 {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
//#UC START# *47A6FEE600FC_4773DB430315_var*
//#UC END# *47A6FEE600FC_4773DB430315_var*
begin
//#UC START# *47A6FEE600FC_4773DB430315_impl*
 Result := false;
//#UC END# *47A6FEE600FC_4773DB430315_impl*
end;//Tl3ObjectCache.IsCacheable
{$IfEnd} // NOT Defined(DesignTimeLibrary)

end.
