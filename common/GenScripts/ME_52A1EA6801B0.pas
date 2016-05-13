unit NOT_FINISHED_vcmComponent;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Components\NOT_FINISHED_vcmComponent.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TvcmComponent" MUID: (52A1EA6801B0)

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , l3InterfacedComponent
;

type
 TvcmComponent = class(Tl3InterfacedComponent)
 end;//TvcmComponent
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvcmComponent);
 {* Регистрация TvcmComponent }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

end.
