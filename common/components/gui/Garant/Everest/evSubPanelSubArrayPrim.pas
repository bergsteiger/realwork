unit evSubPanelSubArrayPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/evSubPanelSubArrayPrim.pas"
// Начат: 26.02.2010 16:55
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::SubPanel::TevSubPanelSubArrayPrim
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  l3Types
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  ,
  l3ProtoDataContainer,
  evSubPanelSub,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except,
  Classes
  ;

 {$Define l3Items_FreeItem_NeedsList}

type
 _ItemType_ = TevSubPanelSub;
 _l3ObjectRefListPrim_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3ObjectRefListPrim.imp.pas}
 TevSubPanelSubArrayPrim = {abstract} class(_l3ObjectRefListPrim_)
 private
 // private fields
   f_Owner : TWinControl;
    {* Поле для свойства Owner}
   f_Handle : Tl3Handle;
    {* Поле для свойства Handle}
 protected
 // overridden protected methods
   {$If not defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
     {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} //not DesignTimeLibrary
 public
 // public methods
   constructor Create(anOwner: TWinControl;
     aHandle: Tl3Handle); reintroduce;
 public
 // public properties
   property Owner: TWinControl
     read f_Owner;
   property Handle: Tl3Handle
     read f_Handle;
 end;//TevSubPanelSubArrayPrim

implementation

uses
  evSubPanelTools,
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;

// start class TevSubPanelSubArrayPrim

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
//#UC START# *47B2C42A0163_4B87B62502C5_var*
//#UC END# *47B2C42A0163_4B87B62502C5_var*
begin
//#UC START# *47B2C42A0163_4B87B62502C5_impl*
 //aTo.Assign(aFrom);
 Assert(false);
//#UC END# *47B2C42A0163_4B87B62502C5_impl*
end;//AssignItem
{$IfEnd} //l3Items_NeedsAssignItem AND not l3Items_NoSort

procedure FillItem(var aPlace: _ItemType_;
  const anItem: _ItemType_
  {$If defined(l3Items_FillItem_NeedsList)}
  ;
  anItems: _l3Items_
  {$IfEnd} //l3Items_FillItem_NeedsList
  );
//#UC START# *47B935AF0066_4B87B62502C5_var*
//#UC END# *47B935AF0066_4B87B62502C5_var*
begin
//#UC START# *47B935AF0066_4B87B62502C5_impl*
 aPlace := anItem.Use;
//#UC END# *47B935AF0066_4B87B62502C5_impl*
end;//FillItem

procedure FreeItem(var aPlace: _ItemType_
  {$If defined(l3Items_FreeItem_NeedsList)}
  ;
  aList: _l3Items_
  {$IfEnd} //l3Items_FreeItem_NeedsList
  );
//#UC START# *47B94A5C006E_4B87B62502C5_var*
//#UC END# *47B94A5C006E_4B87B62502C5_var*
begin
//#UC START# *47B94A5C006E_4B87B62502C5_impl*
 with TevSubPanelSubArrayPrim(aList) do
  if (Owner <> nil) AND Owner.HandleAllocated then
   evInvalidateRect(Owner.Handle, aPlace.R);
 FreeAndNil(aPlace); 
//#UC END# *47B94A5C006E_4B87B62502C5_impl*
end;//FreeItem

function CompareExistingItems(const CI: CompareItemsRec): Integer;
//#UC START# *47B99D4503A2_4B87B62502C5_var*
//#UC END# *47B99D4503A2_4B87B62502C5_var*
begin
//#UC START# *47B99D4503A2_4B87B62502C5_impl*
 {$IfDef l3Items_HasCustomSort}
 Assert(CI.rSortIndex = l3_siNative);
 {$EndIf l3Items_HasCustomSort}
 Result := CI.rA.Handle - CI.rB.Handle;
//#UC END# *47B99D4503A2_4B87B62502C5_impl*
end;//CompareExistingItems

type _Instance_R_ = TevSubPanelSubArrayPrim;

{$Include w:\common\components\rtl\Garant\L3\l3ObjectRefListPrim.imp.pas}

// start class TevSubPanelSubArrayPrim

constructor TevSubPanelSubArrayPrim.Create(anOwner: TWinControl;
  aHandle: Tl3Handle);
//#UC START# *4B87EB47006B_4B87B62502C5_var*
//#UC END# *4B87EB47006B_4B87B62502C5_var*
begin
//#UC START# *4B87EB47006B_4B87B62502C5_impl*
 MakeSorted(l3_dupChange);
 f_Owner := anOwner;
 f_Handle := aHandle;
//#UC END# *4B87EB47006B_4B87B62502C5_impl*
end;//TevSubPanelSubArrayPrim.Create

{$If not defined(DesignTimeLibrary)}
class function TevSubPanelSubArrayPrim.IsCacheable: Boolean;
//#UC START# *47A6FEE600FC_4B87B62502C5_var*
//#UC END# *47A6FEE600FC_4B87B62502C5_var*
begin
//#UC START# *47A6FEE600FC_4B87B62502C5_impl*
 Result := true;
//#UC END# *47A6FEE600FC_4B87B62502C5_impl*
end;//TevSubPanelSubArrayPrim.IsCacheable
{$IfEnd} //not DesignTimeLibrary

end.