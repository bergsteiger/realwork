unit daFieldDescriptionListPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DA"
// Модуль: "w:/common/components/rtl/Garant/DA/daFieldDescriptionListPrim.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::DA::DataScheme::TdaFieldDescriptionListPrim
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\DA\daDefine.inc}

interface

uses
  l3ProtoDataContainer,
  daInterfaces,
  l3Types,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except,
  Classes
  ;

 {$Define l3Items_NeedsBeforeFreeItem}

type
 _ItemType_ = IdaFieldDescription;
 _l3InterfaceRefListPrim_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefListPrim.imp.pas}
 TdaFieldDescriptionListPrim = class(_l3InterfaceRefListPrim_)
 protected
 // overridden protected methods
   {$If defined(l3Items_NeedsBeforeFreeItem)}
   procedure BeforeFreeItem(var aPlace: _ItemType_); override;
     {* Нотификация потомкам об освобождении элемента списка }
   {$IfEnd} //l3Items_NeedsBeforeFreeItem
 end;//TdaFieldDescriptionListPrim

implementation

uses
  SysUtils,
  l3Base,
  l3MinMax,
  RTLConsts
  ;

// start class TdaFieldDescriptionListPrim

{$If defined(l3Items_NeedsAssignItem) AND not defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
  const aFrom: _ItemType_); forward;
{$IfEnd} //l3Items_NeedsAssignItem AND not l3Items_NoSort


function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If not defined(l3Items_IsAtomic)}
function IsSameItems(const A: _ItemType_;
  const B: _ItemType_): Boolean;
//#UC START# *47B07CF403D0_5538E9AE0163_var*
//#UC END# *47B07CF403D0_5538E9AE0163_var*
begin
//#UC START# *47B07CF403D0_5538E9AE0163_impl*
 Result := AnsiSameText(A.SQLName, B.SQLName);
//#UC END# *47B07CF403D0_5538E9AE0163_impl*
end;//IsSameItems
{$IfEnd} //not l3Items_IsAtomic

{$If defined(l3Items_NeedsAssignItem) AND not defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
  const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_5538E9AE0163_var*
//#UC END# *47B2C42A0163_5538E9AE0163_var*
begin
//#UC START# *47B2C42A0163_5538E9AE0163_impl*
 Assert(False);
//#UC END# *47B2C42A0163_5538E9AE0163_impl*
end;//AssignItem
{$IfEnd} //l3Items_NeedsAssignItem AND not l3Items_NoSort

function CompareExistingItems(const CI: CompareItemsRec): Integer;
//#UC START# *47B99D4503A2_5538E9AE0163_var*
//#UC END# *47B99D4503A2_5538E9AE0163_var*
begin
//#UC START# *47B99D4503A2_5538E9AE0163_impl*
 Result := AnsiCompareText(CI.rA.SQLName, CI.rB.SQLName);
//#UC END# *47B99D4503A2_5538E9AE0163_impl*
end;//CompareExistingItems

type _Instance_R_ = TdaFieldDescriptionListPrim;

{$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefListPrim.imp.pas}

// start class TdaFieldDescriptionListPrim

{$If defined(l3Items_NeedsBeforeFreeItem)}
procedure TdaFieldDescriptionListPrim.BeforeFreeItem(var aPlace: _ItemType_);
//#UC START# *4B87FCF8038B_5538E9AE0163_var*
//#UC END# *4B87FCF8038B_5538E9AE0163_var*
begin
//#UC START# *4B87FCF8038B_5538E9AE0163_impl*
 aPlace.BindToTable;
//#UC END# *4B87FCF8038B_5538E9AE0163_impl*
end;//TdaFieldDescriptionListPrim.BeforeFreeItem
{$IfEnd} //l3Items_NeedsBeforeFreeItem

end.