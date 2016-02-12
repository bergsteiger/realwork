unit l3FrameObjectList;
 {* Массив объектов отрисовки }

// Модуль: "w:\common\components\rtl\Garant\L3\l3FrameObjectList.pas"
// Стереотип: "SimpleClass"

{$Include l3Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , l3FrameObject
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = Tl3FrameObject;
 _l3UncomparabeObjectRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
 Tl3FrameObjectList = class(_l3UncomparabeObjectRefList_)
  {* Массив объектов отрисовки }
  protected
   {$If NOT Defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
    {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
 end;//Tl3FrameObjectList

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

{$If not Declared(_DataType_)}type _DataType_ = Tl3Ptr;{$IfEnd}

{$If not Declared(_FindDataType_)}type _FindDataType_ = _ItemType_;{$IfEnd}

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_48CA6C24020B_var*
//#UC END# *47B2C42A0163_48CA6C24020B_var*
begin
//#UC START# *47B2C42A0163_48CA6C24020B_impl*
 Assert(false);
//#UC END# *47B2C42A0163_48CA6C24020B_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_48CA6C24020B_var*
//#UC END# *47B99D4503A2_48CA6C24020B_var*
begin
//#UC START# *47B99D4503A2_48CA6C24020B_impl*
 Result := -1;
 Assert(false);
//#UC END# *47B99D4503A2_48CA6C24020B_impl*
end;//CompareExistingItems

type _Instance_R_ = Tl3FrameObjectList;

{$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}

{$If NOT Defined(DesignTimeLibrary)}
class function Tl3FrameObjectList.IsCacheable: Boolean;
 {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
//#UC START# *47A6FEE600FC_48CA6C24020B_var*
//#UC END# *47A6FEE600FC_48CA6C24020B_var*
begin
//#UC START# *47A6FEE600FC_48CA6C24020B_impl*
 Result := true;
//#UC END# *47A6FEE600FC_48CA6C24020B_impl*
end;//Tl3FrameObjectList.IsCacheable
{$IfEnd} // NOT Defined(DesignTimeLibrary)

end.
