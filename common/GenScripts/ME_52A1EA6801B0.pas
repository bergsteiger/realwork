unit NOT_FINISHED_vcmComponent;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Components\NOT_FINISHED_vcmComponent.pas"
// Стереотип: "SimpleClass"

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
;
{$IfEnd} // NOT Defined(NoVCM)

end.
