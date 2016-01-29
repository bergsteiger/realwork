unit vcmUserTypeDescr;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM$Visual"
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/Visual/vcmUserTypeDescr.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::VCM$Visual::Visual::vcmUserTypeDescr
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If not defined(NoVCM)}
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
 TvcmUserTypeDescr = {$IfDef XE4}record{$Else}object{$EndIf}
 public
   SettingsCaption : AnsiString;
   FormClass : TClass;
   IsCustomizationInternal : Boolean;
 public
    function EQ(const anOther: TvcmUserTypeDescr): Boolean;
 end;//TvcmUserTypeDescr

 _ItemType_ = TvcmUserTypeDescr;
 _l3RecordWithEQList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3RecordWithEQList.imp.pas}
 TvcmUserTypeDescrList = class(_l3RecordWithEQList_)
 end;//TvcmUserTypeDescrList
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}
uses
  vcmInterfaces,
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;

// start class TvcmUserTypeDescr

function TvcmUserTypeDescr.EQ(const anOther: TvcmUserTypeDescr): Boolean;
//#UC START# *51EF904803AE_51EF7F380042_var*
//#UC END# *51EF904803AE_51EF7F380042_var*
begin
//#UC START# *51EF904803AE_51EF7F380042_impl*
 Result := (AnsiSameStr(SettingsCaption, anOther.SettingsCaption)) AND
  (FormClass = anOther.FormClass);
//#UC END# *51EF904803AE_51EF7F380042_impl*
end;//TvcmUserTypeDescr.EQ
// start class TvcmUserTypeDescrList

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If defined(l3Items_NeedsAssignItem) AND not defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
  const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_51EF80BE0105_var*
//#UC END# *47B2C42A0163_51EF80BE0105_var*
begin
//#UC START# *47B2C42A0163_51EF80BE0105_impl*
 
//#UC END# *47B2C42A0163_51EF80BE0105_impl*
end;//AssignItem
{$IfEnd} //l3Items_NeedsAssignItem AND not l3Items_NoSort

function CompareExistingItems(const CI: CompareItemsRec): Integer;
//#UC START# *47B99D4503A2_51EF80BE0105_var*
//#UC END# *47B99D4503A2_51EF80BE0105_var*
begin
//#UC START# *47B99D4503A2_51EF80BE0105_impl*
 Result := -1;
//#UC END# *47B99D4503A2_51EF80BE0105_impl*
end;//CompareExistingItems

type _Instance_R_ = TvcmUserTypeDescrList;

{$Include w:\common\components\rtl\Garant\L3\l3RecordWithEQList.imp.pas}

{$IfEnd} //not NoVCM
end.