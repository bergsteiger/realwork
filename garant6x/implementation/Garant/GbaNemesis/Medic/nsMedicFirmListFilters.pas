unit nsMedicFirmListFilters;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Medic\nsMedicFirmListFilters.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsMedicFirmListFilters" MUID: (4901F0CF03B0)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3TreeFilters
 , bsInterfaces
 , l3TreeInterfaces
;

type
 TnsMedicFirmListFilters = class(Tl3TreeFilters, InsMedicFirmListFilters)
  private
   f_Country: InsCountryFilter;
  protected
   function pm_GetCountry: InsCountryFilter;
   function SetCountry(const aFilter: InsCountryFilter): InsMedicFirmListFilters;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(const aSource: Il3TreeFilters); override;
 end;//TnsMedicFirmListFilters
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , nsCountryFilter
 , SysUtils
;

function TnsMedicFirmListFilters.pm_GetCountry: InsCountryFilter;
//#UC START# *4901EEAD0242_4901F0CF03B0get_var*
//#UC END# *4901EEAD0242_4901F0CF03B0get_var*
begin
//#UC START# *4901EEAD0242_4901F0CF03B0get_impl*
 Result := f_Country;
//#UC END# *4901EEAD0242_4901F0CF03B0get_impl*
end;//TnsMedicFirmListFilters.pm_GetCountry

function TnsMedicFirmListFilters.SetCountry(const aFilter: InsCountryFilter): InsMedicFirmListFilters;
//#UC START# *4901EED201C4_4901F0CF03B0_var*
//#UC END# *4901EED201C4_4901F0CF03B0_var*
begin
//#UC START# *4901EED201C4_4901F0CF03B0_impl*
 f_Country := aFilter;
 Result := Self;
//#UC END# *4901EED201C4_4901F0CF03B0_impl*
end;//TnsMedicFirmListFilters.SetCountry

procedure TnsMedicFirmListFilters.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4901F0CF03B0_var*
//#UC END# *479731C50290_4901F0CF03B0_var*
begin
//#UC START# *479731C50290_4901F0CF03B0_impl*
 f_Country := nil;
 inherited;
//#UC END# *479731C50290_4901F0CF03B0_impl*
end;//TnsMedicFirmListFilters.Cleanup

constructor TnsMedicFirmListFilters.Create(const aSource: Il3TreeFilters);
//#UC START# *48FF4F47010F_4901F0CF03B0_var*
var
 l_Filter: InsMedicFirmListFilters;
//#UC END# *48FF4F47010F_4901F0CF03B0_var*
begin
//#UC START# *48FF4F47010F_4901F0CF03B0_impl*
 inherited Create(aSource);
 if Supports(aSource, InsMedicFirmListFilters, l_Filter) and Assigned(l_Filter.Country) then
  f_Country := TnsCountryFilter.Make(l_Filter.Country.Country);
//#UC END# *48FF4F47010F_4901F0CF03B0_impl*
end;//TnsMedicFirmListFilters.Create
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
