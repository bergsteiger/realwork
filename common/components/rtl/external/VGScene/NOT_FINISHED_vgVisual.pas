unit NOT_FINISHED_vgVisual;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VGScene"
// Модуль: "w:/common/components/rtl/external/VGScene/NOT_FINISHED_vgVisual.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VGScene::Impl::TvgVisual
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include ..\VGScene\vg_define.inc}

interface

{$If not defined(NoVGScene)}
uses
  vgVisualObject,
  vgPersistent
  ;
{$IfEnd} //not NoVGScene

{$If not defined(NoVGScene)}
type
 TvgVisual = class(TvgPersistent)
 protected
 // property methods
   function pm_GetVisualObject: TvgVisualObject;
   procedure pm_SetVisualObject(aValue: TvgVisualObject);
 public
 // public properties
   property VisualObject: TvgVisualObject
     read pm_GetVisualObject
     write pm_SetVisualObject;
 end;//TvgVisual
{$IfEnd} //not NoVGScene

implementation

{$If not defined(NoVGScene)}

// start class TvgVisual

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

{$IfEnd} //not NoVGScene

end.