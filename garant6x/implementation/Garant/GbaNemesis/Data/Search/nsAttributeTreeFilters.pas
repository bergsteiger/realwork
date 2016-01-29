unit nsAttributeTreeFilters;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Data"
// Автор: Лукьянец Р.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Data/Search/nsAttributeTreeFilters.pas"
// Начат: 2007/03/29 06:43:22
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Базовые определения предметной области::LegalDomain::Data::Search::TnsAttributeTreeFilters
//
// Коллеги, это что?
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  bsInterfaces,
  l3TreeFilters,
  nsTypes,
  l3TreeInterfaces
  ;

type
 TnsAttributeTreeFilters = class(Tl3TreeFilters, InsAttributeTreeFilters)
  {* Коллеги, это что? }
 private
 // private fields
   f_FilterType : TnsFilterType;
 protected
 // realized methods
   function pm_GetFilterType: TnsFilterType;
   function SetFilterType(aType: TnsFilterType): InsAttributeTreeFilters;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // overridden public methods
   constructor Create(const aSource: Il3TreeFilters); override;
 end;//TnsAttributeTreeFilters

implementation

uses
  SysUtils
  ;

// start class TnsAttributeTreeFilters

function TnsAttributeTreeFilters.pm_GetFilterType: TnsFilterType;
//#UC START# *490201580363_490203C503ADget_var*
//#UC END# *490201580363_490203C503ADget_var*
begin
//#UC START# *490201580363_490203C503ADget_impl*
 Result := f_FilterType;
//#UC END# *490201580363_490203C503ADget_impl*
end;//TnsAttributeTreeFilters.pm_GetFilterType

function TnsAttributeTreeFilters.SetFilterType(aType: TnsFilterType): InsAttributeTreeFilters;
//#UC START# *4902019901A1_490203C503AD_var*
//#UC END# *4902019901A1_490203C503AD_var*
begin
//#UC START# *4902019901A1_490203C503AD_impl*
 f_FilterType := aType;
 Result := Self;
//#UC END# *4902019901A1_490203C503AD_impl*
end;//TnsAttributeTreeFilters.SetFilterType

procedure TnsAttributeTreeFilters.Cleanup;
//#UC START# *479731C50290_490203C503AD_var*
//#UC END# *479731C50290_490203C503AD_var*
begin
//#UC START# *479731C50290_490203C503AD_impl*
 f_FilterType := ns_ftNone;
 inherited;
//#UC END# *479731C50290_490203C503AD_impl*
end;//TnsAttributeTreeFilters.Cleanup

constructor TnsAttributeTreeFilters.Create(const aSource: Il3TreeFilters);
//#UC START# *48FF4F47010F_490203C503AD_var*
var
 l_Filter: InsAttributeTreeFilters;
//#UC END# *48FF4F47010F_490203C503AD_var*
begin
//#UC START# *48FF4F47010F_490203C503AD_impl*
 inherited;
 if Supports(aSource, InsAttributeTreeFilters, l_Filter) then
  f_FilterType := l_Filter.FilterType;
//#UC END# *48FF4F47010F_490203C503AD_impl*
end;//TnsAttributeTreeFilters.Create

end.