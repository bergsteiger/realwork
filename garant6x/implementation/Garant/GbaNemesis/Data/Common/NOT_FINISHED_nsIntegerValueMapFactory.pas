unit NOT_FINISHED_nsIntegerValueMapFactory;

// ћодуль: "w:\garant6x\implementation\Garant\GbaNemesis\Data\Common\NOT_FINISHED_nsIntegerValueMapFactory.pas"
// —тереотип: "UtilityPack"
// Ёлемент модели: "nsIntegerValueMapFactory" MUID: (4AD5BA0F0231)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , L10nInterfaces
 , l3Interfaces
 , afwInterfaces
;

type
 TnsIntegerValueMapFactory = class
  private
   function MakeMap(const aID: TnsValueMapID): InsValueMap;
 end;//TnsIntegerValueMapFactory

 TnsIntegerValueMap = class(InsStringsSource, InsIntegerValueMap)
  protected
   function pm_GetMapID: Tl3ValueMapID;
   procedure GetDisplayNames(const aList: Il3StringsEx);
    {* заполн€ет список значени€ми "UI-строка" }
   function MapSize: Integer;
    {* количество элементов в мапе. }
   function DisplayNameToValue(const aDisplayName: Il3CString): Integer;
   function ValueToDisplayName(aValue: Integer): Il3CString;
   procedure FillStrings(const aStrings: IafwStrings);
 end;//TnsIntegerValueMap

implementation

uses
 l3ImplUses
 //#UC START# *4AD5BA0F0231impl_uses*
 //#UC END# *4AD5BA0F0231impl_uses*
;

function TnsIntegerValueMapFactory.MakeMap(const aID: TnsValueMapID): InsValueMap;
//#UC START# *4AD5BA4000DF_4AD5BA260390_var*
//#UC END# *4AD5BA4000DF_4AD5BA260390_var*
begin
//#UC START# *4AD5BA4000DF_4AD5BA260390_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AD5BA4000DF_4AD5BA260390_impl*
end;//TnsIntegerValueMapFactory.MakeMap

function TnsIntegerValueMap.pm_GetMapID: Tl3ValueMapID;
//#UC START# *46A5EFE602DE_4AD5BB9B0344get_var*
//#UC END# *46A5EFE602DE_4AD5BB9B0344get_var*
begin
//#UC START# *46A5EFE602DE_4AD5BB9B0344get_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5EFE602DE_4AD5BB9B0344get_impl*
end;//TnsIntegerValueMap.pm_GetMapID

procedure TnsIntegerValueMap.GetDisplayNames(const aList: Il3StringsEx);
 {* заполн€ет список значени€ми "UI-строка" }
//#UC START# *46A5F0130365_4AD5BB9B0344_var*
//#UC END# *46A5F0130365_4AD5BB9B0344_var*
begin
//#UC START# *46A5F0130365_4AD5BB9B0344_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5F0130365_4AD5BB9B0344_impl*
end;//TnsIntegerValueMap.GetDisplayNames

function TnsIntegerValueMap.MapSize: Integer;
 {* количество элементов в мапе. }
//#UC START# *46A5F03800A2_4AD5BB9B0344_var*
//#UC END# *46A5F03800A2_4AD5BB9B0344_var*
begin
//#UC START# *46A5F03800A2_4AD5BB9B0344_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5F03800A2_4AD5BB9B0344_impl*
end;//TnsIntegerValueMap.MapSize

function TnsIntegerValueMap.DisplayNameToValue(const aDisplayName: Il3CString): Integer;
//#UC START# *46A5FCF900E0_4AD5BB9B0344_var*
//#UC END# *46A5FCF900E0_4AD5BB9B0344_var*
begin
//#UC START# *46A5FCF900E0_4AD5BB9B0344_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5FCF900E0_4AD5BB9B0344_impl*
end;//TnsIntegerValueMap.DisplayNameToValue

function TnsIntegerValueMap.ValueToDisplayName(aValue: Integer): Il3CString;
//#UC START# *46A5FD1B000D_4AD5BB9B0344_var*
//#UC END# *46A5FD1B000D_4AD5BB9B0344_var*
begin
//#UC START# *46A5FD1B000D_4AD5BB9B0344_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5FD1B000D_4AD5BB9B0344_impl*
end;//TnsIntegerValueMap.ValueToDisplayName

procedure TnsIntegerValueMap.FillStrings(const aStrings: IafwStrings);
//#UC START# *473D93290004_4AD5BB9B0344_var*
//#UC END# *473D93290004_4AD5BB9B0344_var*
begin
//#UC START# *473D93290004_4AD5BB9B0344_impl*
 !!! Needs to be implemented !!!
//#UC END# *473D93290004_4AD5BB9B0344_impl*
end;//TnsIntegerValueMap.FillStrings

end.
