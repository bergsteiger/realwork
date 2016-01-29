unit evDefaultStylesFontSizesPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/evDefaultStylesFontSizesPrim.pas"
// Начат: 28.07.2011 18:48
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::StyleTable::TevDefaultStylesFontSizesPrim
//
// Размеры шрифтов для стилей по-умолчанию
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  l3ProtoDataContainer,
  l3Memory,
  l3Interfaces,
  l3Types,
  l3Core,
  l3Except,
  Classes
  ;

type
 TevDefaultStyleFontSize = {$IfDef XE4}record{$Else}object{$EndIf}
 public
   rStyleID : Integer;
   rFontSize : Integer;
 public
    function EQ(const anOther: TevDefaultStyleFontSize): Boolean;
 end;//TevDefaultStyleFontSize

 _ItemType_ = TevDefaultStyleFontSize;
 _l3RecordWithEQList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3RecordWithEQList.imp.pas}
 TevDefaultStylesFontSizesPrim = class(_l3RecordWithEQList_)
  {* Размеры шрифтов для стилей по-умолчанию }
 protected
 // overridden protected methods
   procedure InitFields; override;
 end;//TevDefaultStylesFontSizesPrim

function TevDefaultStyleFontSize_C(aStyleID: Integer;
     aFontSize: Integer): TevDefaultStyleFontSize;

implementation

uses
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;

// start class TevDefaultStylesFontSizesPrim

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If defined(l3Items_NeedsAssignItem) AND not defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
  const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_4E3173F50217_var*
//#UC END# *47B2C42A0163_4E3173F50217_var*
begin
//#UC START# *47B2C42A0163_4E3173F50217_impl*
 Assert(false);
//#UC END# *47B2C42A0163_4E3173F50217_impl*
end;//AssignItem
{$IfEnd} //l3Items_NeedsAssignItem AND not l3Items_NoSort

function CompareExistingItems(const CI: CompareItemsRec): Integer;
//#UC START# *47B99D4503A2_4E3173F50217_var*
//#UC END# *47B99D4503A2_4E3173F50217_var*
begin
//#UC START# *47B99D4503A2_4E3173F50217_impl*
 Result := CI.rA.rStyleID - CI.rB.rStyleID;
//#UC END# *47B99D4503A2_4E3173F50217_impl*
end;//CompareExistingItems

type _Instance_R_ = TevDefaultStylesFontSizesPrim;

{$Include w:\common\components\rtl\Garant\L3\l3RecordWithEQList.imp.pas}


function TevDefaultStyleFontSize_C(aStyleID: Integer;
        aFontSize: Integer): TevDefaultStyleFontSize;
//#UC START# *4E317595024E_4E3175000369_var*
//#UC END# *4E317595024E_4E3175000369_var*
begin
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *4E317595024E_4E3175000369_impl*
 Result.rStyleID := aStyleID;
 Result.rFontSize := aFontSize;
//#UC END# *4E317595024E_4E3175000369_impl*
end;//TevDefaultStyleFontSize.C

// start class TevDefaultStyleFontSize

function TevDefaultStyleFontSize.EQ(const anOther: TevDefaultStyleFontSize): Boolean;
//#UC START# *4E3175CA0048_4E3175000369_var*
//#UC END# *4E3175CA0048_4E3175000369_var*
begin
//#UC START# *4E3175CA0048_4E3175000369_impl*
 Result := (rStyleID = anOther.rStyleID);
//#UC END# *4E3175CA0048_4E3175000369_impl*
end;//TevDefaultStyleFontSize.EQ

procedure TevDefaultStylesFontSizesPrim.InitFields;
//#UC START# *47A042E100E2_4E3173F50217_var*
//#UC END# *47A042E100E2_4E3173F50217_var*
begin
//#UC START# *47A042E100E2_4E3173F50217_impl*
 inherited;
 Sorted := true;
//#UC END# *47A042E100E2_4E3173F50217_impl*
end;//TevDefaultStylesFontSizesPrim.InitFields

end.