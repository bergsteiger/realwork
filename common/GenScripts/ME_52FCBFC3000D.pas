unit l3ObjectWithHandleRefListPrim;

// Модуль: "w:\common\components\rtl\Garant\L3\l3ObjectWithHandleRefListPrim.pas"
// Стереотип: "SimpleClass"

{$Include l3Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , l3ProtoObjectWithHandle
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = Tl3ProtoObjectWithHandle;
 _l3UncomparabeObjectRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
 Tl3ObjectWithHandleRefListPrim = class(_l3UncomparabeObjectRefList_)
  protected
   {$If NOT Defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
    {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
 end;//Tl3ObjectWithHandleRefListPrim

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
//#UC START# *47B2C42A0163_52FCBFC3000D_var*
//#UC END# *47B2C42A0163_52FCBFC3000D_var*
begin
//#UC START# *47B2C42A0163_52FCBFC3000D_impl*
 Assert(false);
//#UC END# *47B2C42A0163_52FCBFC3000D_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_52FCBFC3000D_var*
//#UC END# *47B99D4503A2_52FCBFC3000D_var*
begin
//#UC START# *47B99D4503A2_52FCBFC3000D_impl*
 Result := CI.rA.CompareWith(CI.rB^);
//#UC END# *47B99D4503A2_52FCBFC3000D_impl*
end;//CompareExistingItems

type _Instance_R_ = Tl3ObjectWithHandleRefListPrim;

{$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}

{$If NOT Defined(DesignTimeLibrary)}
class function Tl3ObjectWithHandleRefListPrim.IsCacheable: Boolean;
 {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
//#UC START# *47A6FEE600FC_52FCBFC3000D_var*
//#UC END# *47A6FEE600FC_52FCBFC3000D_var*
begin
//#UC START# *47A6FEE600FC_52FCBFC3000D_impl*
 Result := true;
//#UC END# *47A6FEE600FC_52FCBFC3000D_impl*
end;//Tl3ObjectWithHandleRefListPrim.IsCacheable
{$IfEnd} // NOT Defined(DesignTimeLibrary)

end.
