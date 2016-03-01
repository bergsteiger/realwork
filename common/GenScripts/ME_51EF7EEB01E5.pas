unit vcmUserTypeDescr;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Visual\vcmUserTypeDescr.pas"
// Стереотип: "UtilityPack"

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
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

type
 TvcmUserTypeDescr = object
  public
   SettingsCaption: AnsiString;
   FormClass: TClass;
   IsCustomizationInternal: Boolean;
  public
   function EQ(const anOther: TvcmUserTypeDescr): Boolean;
 end;//TvcmUserTypeDescr

 _ItemType_ = TvcmUserTypeDescr;
 _l3RecordWithEQList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3RecordWithEQList.imp.pas}
 TvcmUserTypeDescrList = class(_l3RecordWithEQList_)
 end;//TvcmUserTypeDescrList
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , vcmInterfaces
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

function TvcmUserTypeDescr.EQ(const anOther: TvcmUserTypeDescr): Boolean;
//#UC START# *51EF904803AE_51EF7F380042_var*
//#UC END# *51EF904803AE_51EF7F380042_var*
begin
//#UC START# *51EF904803AE_51EF7F380042_impl*
 Result := (AnsiSameStr(SettingsCaption, anOther.SettingsCaption)) AND
  (FormClass = anOther.FormClass);
//#UC END# *51EF904803AE_51EF7F380042_impl*
end;//TvcmUserTypeDescr.EQ

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_51EF80BE0105_var*
//#UC END# *47B2C42A0163_51EF80BE0105_var*
begin
//#UC START# *47B2C42A0163_51EF80BE0105_impl*
 
//#UC END# *47B2C42A0163_51EF80BE0105_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_51EF80BE0105_var*
//#UC END# *47B99D4503A2_51EF80BE0105_var*
begin
//#UC START# *47B99D4503A2_51EF80BE0105_impl*
 Result := -1;
//#UC END# *47B99D4503A2_51EF80BE0105_impl*
end;//CompareExistingItems

type _Instance_R_ = TvcmUserTypeDescrList;

{$Include w:\common\components\rtl\Garant\L3\l3RecordWithEQList.imp.pas}
{$IfEnd} // NOT Defined(NoVCM)

end.
