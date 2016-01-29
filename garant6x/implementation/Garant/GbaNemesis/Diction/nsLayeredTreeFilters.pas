unit nsLayeredTreeFilters;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Diction"
// Автор: Лукьянец Р.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Diction/nsLayeredTreeFilters.pas"
// Начат: 2007/03/23 14:18:10
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Встроенные продукты::Diction::Diction::Diction$Unit::TnsLayeredTreeFilters
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
 TnsLayeredTreeFilters = class(Tl3TreeFilters, InsLayeredTreeFilters)
 private
 // private fields
   f_Layer : InsLayerFilter;
 protected
 // realized methods
   function pm_GetLayer: InsLayerFilter;
   function SetLayer(const aFilter: InsLayerFilter): InsLayeredTreeFilters;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // overridden public methods
   constructor Create(const aSource: Il3TreeFilters); override;
 end;//TnsLayeredTreeFilters
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  SysUtils,
  nsLayerFilter
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TnsLayeredTreeFilters

function TnsLayeredTreeFilters.pm_GetLayer: InsLayerFilter;
//#UC START# *4902079D02D4_49020B54001Aget_var*
//#UC END# *4902079D02D4_49020B54001Aget_var*
begin
//#UC START# *4902079D02D4_49020B54001Aget_impl*
 Result := f_Layer;
//#UC END# *4902079D02D4_49020B54001Aget_impl*
end;//TnsLayeredTreeFilters.pm_GetLayer

function TnsLayeredTreeFilters.SetLayer(const aFilter: InsLayerFilter): InsLayeredTreeFilters;
//#UC START# *490207AB002D_49020B54001A_var*
//#UC END# *490207AB002D_49020B54001A_var*
begin
//#UC START# *490207AB002D_49020B54001A_impl*
 f_Layer := aFilter;
 Result := Self;
//#UC END# *490207AB002D_49020B54001A_impl*
end;//TnsLayeredTreeFilters.SetLayer

procedure TnsLayeredTreeFilters.Cleanup;
//#UC START# *479731C50290_49020B54001A_var*
//#UC END# *479731C50290_49020B54001A_var*
begin
//#UC START# *479731C50290_49020B54001A_impl*
 f_Layer := nil;
 inherited;
//#UC END# *479731C50290_49020B54001A_impl*
end;//TnsLayeredTreeFilters.Cleanup

constructor TnsLayeredTreeFilters.Create(const aSource: Il3TreeFilters);
//#UC START# *48FF4F47010F_49020B54001A_var*
var
 l_Filter: InsLayeredTreeFilters;
//#UC END# *48FF4F47010F_49020B54001A_var*
begin
//#UC START# *48FF4F47010F_49020B54001A_impl*
 inherited;
 if Supports(aSource, InsLayeredTreeFilters, l_Filter) and Assigned(l_Filter.Layer) then
  f_Layer := TnsLayerFilter.Make(l_Filter.Layer.LayerID);
//#UC END# *48FF4F47010F_49020B54001A_impl*
end;//TnsLayeredTreeFilters.Create

{$IfEnd} //not Admin AND not Monitorings

end.