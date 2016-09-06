unit vgCustomObject;

// Модуль: "w:\common\components\rtl\external\VGScene\vgCustomObject.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TvgCustomObject" MUID: (4D542078016E)

{$Include w:\common\components\rtl\external\VGScene\vg_define.inc}

interface

{$If NOT Defined(NoVGScene)}
uses
 l3IntfUses
 , vgComponent
;

type
 TvgCustomObject = {abstract} class(TvgComponent)
  protected
   function pm_GetIsVisual: Boolean; virtual; abstract;
  public
   property IsVisual: Boolean
    read pm_GetIsVisual;
 end;//TvgCustomObject
{$IfEnd} // NOT Defined(NoVGScene)

implementation

{$If NOT Defined(NoVGScene)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *4D542078016Eimpl_uses*
 //#UC END# *4D542078016Eimpl_uses*
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvgCustomObject);
 {* Регистрация TvgCustomObject }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVGScene)

end.
