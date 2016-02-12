unit nevShapePrim;
 {* Информация об отрисованном объекте }

// Модуль: "w:\common\components\gui\Garant\Everest\new\nevShapePrim.pas"
// Стереотип: "SimpleClass"

{$Include evDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

 {$Define l3Items_NoChanging}

 {$Define l3Items_NoSort}

type
 _ItemType_ = Tl3ProtoDataContainer;
 _l3ObjectRefListPrim_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3ObjectRefListPrim.imp.pas}
 _l3OpenArray_Parent_ = _l3ObjectRefListPrim_;
 {$Include w:\common\components\rtl\Garant\L3\l3OpenArray.imp.pas}
 TnevShapePrim = class(_l3OpenArray_)
  {* Информация об отрисованном объекте }
  protected
   {$If NOT Defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
    {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
  public
   procedure CleanupRefs; virtual; abstract;
    {* Очищает ссылки на сторонние объекты }
 end;//TnevShapePrim

implementation

uses
 l3ImplUses
 , nevShapesPainted
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

{$If not Declared(_DataType_)}type _DataType_ = Tl3Ptr;{$IfEnd}

{$If not Declared(_FindDataType_)}type _FindDataType_ = _ItemType_;{$IfEnd}

procedure FillItem(var aPlace: _ItemType_;
 const anItem: _ItemType_
{$If Defined(l3Items_FillItem_NeedsList)}
;
 anItems: _l3Items_
{$IfEnd} // Defined(l3Items_FillItem_NeedsList)
); forward;

procedure FreeItem(var aPlace: _ItemType_
{$If Defined(l3Items_FreeItem_NeedsList)}
;
 aList: _l3Items_
{$IfEnd} // Defined(l3Items_FreeItem_NeedsList)
); forward;

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_4B8693630365_var*
//#UC END# *47B2C42A0163_4B8693630365_var*
begin
//#UC START# *47B2C42A0163_4B8693630365_impl*
 Assert(false);
//#UC END# *47B2C42A0163_4B8693630365_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

procedure FillItem(var aPlace: _ItemType_;
 const anItem: _ItemType_
{$If Defined(l3Items_FillItem_NeedsList)};
 anItems: _l3Items_
{$IfEnd} // Defined(l3Items_FillItem_NeedsList)
);
 {* Заполняет элемент списка. }
//#UC START# *47B935AF0066_4B8693630365_var*
//#UC END# *47B935AF0066_4B8693630365_var*
begin
//#UC START# *47B935AF0066_4B8693630365_impl*
 aPlace := anItem.Use;
//#UC END# *47B935AF0066_4B8693630365_impl*
end;//FillItem

procedure FreeItem(var aPlace: _ItemType_
{$If Defined(l3Items_FreeItem_NeedsList)};
 aList: _l3Items_
{$IfEnd} // Defined(l3Items_FreeItem_NeedsList)
);
 {* Очищает элемент списка }
//#UC START# *47B94A5C006E_4B8693630365_var*
//#UC END# *47B94A5C006E_4B8693630365_var*
begin
//#UC START# *47B94A5C006E_4B8693630365_impl*
 if (aPlace <> nil) then
  TnevShapePrim(aPlace).CleanupRefs;
 FreeAndNil(aPlace);
//#UC END# *47B94A5C006E_4B8693630365_impl*
end;//FreeItem

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_4B8693630365_var*
//#UC END# *47B99D4503A2_4B8693630365_var*
begin
//#UC START# *47B99D4503A2_4B8693630365_impl*
 Result := -1;
 Assert(false);
//#UC END# *47B99D4503A2_4B8693630365_impl*
end;//CompareExistingItems

type _Instance_R_ = TnevShapePrim;

{$Include w:\common\components\rtl\Garant\L3\l3ObjectRefListPrim.imp.pas}

{$Include w:\common\components\rtl\Garant\L3\l3OpenArray.imp.pas}

{$If NOT Defined(DesignTimeLibrary)}
class function TnevShapePrim.IsCacheable: Boolean;
 {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
//#UC START# *47A6FEE600FC_4B8693630365_var*
//#UC END# *47A6FEE600FC_4B8693630365_var*
begin
//#UC START# *47A6FEE600FC_4B8693630365_impl*
 Result := true;
//#UC END# *47A6FEE600FC_4B8693630365_impl*
end;//TnevShapePrim.IsCacheable
{$IfEnd} // NOT Defined(DesignTimeLibrary)

end.
