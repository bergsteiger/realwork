unit nsAttributeTreeFilters;
 {* Коллеги, это что? }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Data\Search\nsAttributeTreeFilters.pas"
// Стереотип: "SimpleClass"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , l3TreeFilters
 , bsInterfaces
 , nsTypes
 , l3TreeInterfaces
;

type
 TnsAttributeTreeFilters = class(Tl3TreeFilters, InsAttributeTreeFilters)
  {* Коллеги, это что? }
  private
   f_FilterType: TnsFilterType;
  protected
   function pm_GetFilterType: TnsFilterType;
   function SetFilterType(aType: TnsFilterType): InsAttributeTreeFilters;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(const aSource: Il3TreeFilters); override;
 end;//TnsAttributeTreeFilters

implementation

uses
 l3ImplUses
 , SysUtils
;

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
 {* Функция очистки полей объекта. }
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
