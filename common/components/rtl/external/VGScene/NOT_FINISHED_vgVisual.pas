unit NOT_FINISHED_vgVisual;

// Модуль: "w:\common\components\rtl\external\VGScene\NOT_FINISHED_vgVisual.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TvgVisual" MUID: (4D5EB9330192)

{$Include w:\common\components\rtl\external\VGScene\vg_define.inc}

interface

{$If NOT Defined(NoVGScene)}
uses
 l3IntfUses
 , vgPersistent
 , vgVisualObject
;

type
 TvgVisual = class(TvgPersistent)
  protected
   function pm_GetVisualObject: TvgVisualObject;
   procedure pm_SetVisualObject(aValue: TvgVisualObject);
  public
   property VisualObject: TvgVisualObject
    read pm_GetVisualObject
    write pm_SetVisualObject;
 end;//TvgVisual
{$IfEnd} // NOT Defined(NoVGScene)

implementation

{$If NOT Defined(NoVGScene)}
uses
 l3ImplUses
;

function TvgVisual.pm_GetVisualObject: TvgVisualObject;
//#UC START# *4D5EB94900A6_4D5EB9330192get_var*
//#UC END# *4D5EB94900A6_4D5EB9330192get_var*
begin
//#UC START# *4D5EB94900A6_4D5EB9330192get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D5EB94900A6_4D5EB9330192get_impl*
end;//TvgVisual.pm_GetVisualObject

procedure TvgVisual.pm_SetVisualObject(aValue: TvgVisualObject);
//#UC START# *4D5EB94900A6_4D5EB9330192set_var*
//#UC END# *4D5EB94900A6_4D5EB9330192set_var*
begin
//#UC START# *4D5EB94900A6_4D5EB9330192set_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D5EB94900A6_4D5EB9330192set_impl*
end;//TvgVisual.pm_SetVisualObject
{$IfEnd} // NOT Defined(NoVGScene)

end.
