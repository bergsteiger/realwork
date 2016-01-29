unit vgGradientPoint;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VGScene"
// Модуль: "w:/common/components/rtl/external/VGScene/vgGradientPoint.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VGScene::Impl::TvgGradientPoint
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\VGScene\vg_define.inc}

interface

{$If not defined(NoVGScene)}
uses
  vgCustomGradientPoint
  ;
{$IfEnd} //not NoVGScene

{$If not defined(NoVGScene)}
type
//#UC START# *4D555E3901BFci*
//#UC END# *4D555E3901BFci*
//#UC START# *4D555E3901BFcit*
//#UC END# *4D555E3901BFcit*
 TvgGradientPoint = class(TvgCustomGradientPoint)
//#UC START# *4D555E3901BFpubl*
  published
    property Color;
    property Offset;
//#UC END# *4D555E3901BFpubl*
 end;//TvgGradientPoint
{$IfEnd} //not NoVGScene

implementation

{$If not defined(NoVGScene)}
uses
  Classes
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  ;
{$IfEnd} //not NoVGScene

{$If not defined(NoVGScene)}


//#UC START# *4D555E3901BFimpl*
//#UC END# *4D555E3901BFimpl*

{$IfEnd} //not NoVGScene

initialization
{$If not defined(NoScripts) AND not defined(NoVGScene)}
// Регистрация TvgGradientPoint
 TtfwClassRef.Register(TvgGradientPoint);
{$IfEnd} //not NoScripts AND not NoVGScene

end.