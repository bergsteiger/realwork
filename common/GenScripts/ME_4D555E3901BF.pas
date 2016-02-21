unit vgGradientPoint;

// Модуль: "w:\common\components\rtl\external\VGScene\vgGradientPoint.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\external\VGScene\vg_define.inc}

interface

{$If NOT Defined(NoVGScene)}
uses
 l3IntfUses
 , vgCustomGradientPoint
;

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
{$IfEnd} // NOT Defined(NoVGScene)

implementation

{$If NOT Defined(NoVGScene)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

//#UC START# *4D555E3901BFimpl*
//#UC END# *4D555E3901BFimpl*

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvgGradientPoint);
 {* Регистрация TvgGradientPoint }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVGScene)

end.
