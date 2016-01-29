unit nsMedicFirmListFilters;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Medic"
// Автор: Лукьянец Р.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Medic/nsMedicFirmListFilters.pas"
// Начат: 2008/03/21 11:36:49
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Встроенные продукты::Inpharm::Medic::Medic$Unit::TnsMedicFirmListFilters
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  bsInterfaces,
  l3TreeFilters,
  l3TreeInterfaces
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsMedicFirmListFilters = class(Tl3TreeFilters, InsMedicFirmListFilters)
 private
 // private fields
   f_Country : InsCountryFilter;
 protected
 // realized methods
   function pm_GetCountry: InsCountryFilter;
   function SetCountry(const aFilter: InsCountryFilter): InsMedicFirmListFilters;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // overridden public methods
   constructor Create(const aSource: Il3TreeFilters); override;
 end;//TnsMedicFirmListFilters
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  nsCountryFilter,
  SysUtils
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TnsMedicFirmListFilters

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

{$IfEnd} //not Admin AND not Monitorings

end.