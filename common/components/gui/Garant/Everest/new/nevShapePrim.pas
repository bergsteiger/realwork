unit nevShapePrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/new/nevShapePrim.pas"
// Начат: 25.02.2010 18:12
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::Views::TnevShapePrim
//
// Информация об отрисованном объекте
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
  l3ProtoDataContainer,
  l3Types,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except,
  Classes
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
 // overridden protected methods
   {$If not defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
     {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} //not DesignTimeLibrary
 public
 // public methods
   procedure CleanupRefs; virtual; abstract;
     {* Очищает ссылки на сторонние объекты }
 end;//TnevShapePrim

implementation

uses
  nevShapesPainted,
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;

// start class TnevShapePrim

procedure FillItem(var aPlace: _ItemType_;
  const anItem: _ItemType_
  {$If defined(l3Items_FillItem_NeedsList)}
  ;
  anItems: _l3Items_
  {$IfEnd} //l3Items_FillItem_NeedsList
  ); forward;

procedure FreeItem(var aPlace: _ItemType_
  {$If defined(l3Items_FreeItem_NeedsList)}
  ;
  aList: _l3Items_
  {$IfEnd} //l3Items_FreeItem_NeedsList
  ); forward;

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If defined(l3Items_NeedsAssignItem) AND not defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
  const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_4B8693630365_var*
//#UC END# *47B2C42A0163_4B8693630365_var*
begin
//#UC START# *47B2C42A0163_4B8693630365_impl*
 Assert(false);
//#UC END# *47B2C42A0163_4B8693630365_impl*
end;//AssignItem
{$IfEnd} //l3Items_NeedsAssignItem AND not l3Items_NoSort

procedure FillItem(var aPlace: _ItemType_;
  const anItem: _ItemType_
  {$If defined(l3Items_FillItem_NeedsList)}
  ;
  anItems: _l3Items_
  {$IfEnd} //l3Items_FillItem_NeedsList
  );
//#UC START# *47B935AF0066_4B8693630365_var*
//#UC END# *47B935AF0066_4B8693630365_var*
begin
//#UC START# *47B935AF0066_4B8693630365_impl*
 aPlace := anItem.Use;
//#UC END# *47B935AF0066_4B8693630365_impl*
end;//FillItem

procedure FreeItem(var aPlace: _ItemType_
  {$If defined(l3Items_FreeItem_NeedsList)}
  ;
  aList: _l3Items_
  {$IfEnd} //l3Items_FreeItem_NeedsList
  );
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

// start class TnevShapePrim

{$If not defined(DesignTimeLibrary)}
class function TnevShapePrim.IsCacheable: Boolean;
//#UC START# *47A6FEE600FC_4B8693630365_var*
//#UC END# *47A6FEE600FC_4B8693630365_var*
begin
//#UC START# *47A6FEE600FC_4B8693630365_impl*
 Result := true;
//#UC END# *47A6FEE600FC_4B8693630365_impl*
end;//TnevShapePrim.IsCacheable
{$IfEnd} //not DesignTimeLibrary

end.