unit nsLayeredTreeFilters;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Diction\nsLayeredTreeFilters.pas"
// Стереотип: "SimpleClass"

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
 TnsLayeredTreeFilters = class(Tl3TreeFilters, InsLayeredTreeFilters)
  private
   f_Layer: InsLayerFilter;
  protected
   function pm_GetLayer: InsLayerFilter;
   function SetLayer(const aFilter: InsLayerFilter): InsLayeredTreeFilters;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(const aSource: Il3TreeFilters); override;
 end;//TnsLayeredTreeFilters
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , SysUtils
 , nsLayerFilter
;

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
 {* Функция очистки полей объекта. }
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
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
