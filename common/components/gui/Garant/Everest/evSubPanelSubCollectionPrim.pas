unit evSubPanelSubCollectionPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/evSubPanelSubCollectionPrim.pas"
// Начат: 26.02.2010 16:55
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::SubPanel::TevSubPanelSubCollectionPrim
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  Classes
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  ,
  l3ProtoDataContainer,
  evSubPanelSubArray,
  l3Types,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except
  ;

type
 _ItemType_ = TevSubPanelSubArray;
 _l3UncomparabeObjectRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
 TevSubPanelSubCollectionPrim = {abstract} class(_l3UncomparabeObjectRefList_)
 private
 // private fields
   f_Owner : TWinControl;
    {* Поле для свойства Owner}
 public
 // public methods
   constructor Create(anOwner: TWinControl); reintroduce;
 public
 // public properties
   property Owner: TWinControl
     read f_Owner;
 end;//TevSubPanelSubCollectionPrim

implementation

uses
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;

// start class TevSubPanelSubCollectionPrim

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If defined(l3Items_NeedsAssignItem) AND not defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
  const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_4B87D2A7029B_var*
//#UC END# *47B2C42A0163_4B87D2A7029B_var*
begin
//#UC START# *47B2C42A0163_4B87D2A7029B_impl*
 Assert(false);
//#UC END# *47B2C42A0163_4B87D2A7029B_impl*
end;//AssignItem
{$IfEnd} //l3Items_NeedsAssignItem AND not l3Items_NoSort

function CompareExistingItems(const CI: CompareItemsRec): Integer;
//#UC START# *47B99D4503A2_4B87D2A7029B_var*
//#UC END# *47B99D4503A2_4B87D2A7029B_var*
begin
//#UC START# *47B99D4503A2_4B87D2A7029B_impl*
 {$IfDef l3Items_HasCustomSort}
 Assert(CI.rSortIndex = l3_siNative);
 {$EndIf l3Items_HasCustomSort}
 Result := CI.rA.Handle - CI.rB.Handle;
//#UC END# *47B99D4503A2_4B87D2A7029B_impl*
end;//CompareExistingItems

type _Instance_R_ = TevSubPanelSubCollectionPrim;

{$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}

// start class TevSubPanelSubCollectionPrim

constructor TevSubPanelSubCollectionPrim.Create(anOwner: TWinControl);
//#UC START# *4B87ECA700CD_4B87D2A7029B_var*
//#UC END# *4B87ECA700CD_4B87D2A7029B_var*
begin
//#UC START# *4B87ECA700CD_4B87D2A7029B_impl*
 MakeSorted;
 f_Owner := anOwner;
//#UC END# *4B87ECA700CD_4B87D2A7029B_impl*
end;//TevSubPanelSubCollectionPrim.Create

end.