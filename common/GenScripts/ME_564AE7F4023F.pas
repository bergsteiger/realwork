unit NOT_FINISHED_vcmMainMenuBuilder;
 {* —ервис, предназначенный дл€ регистрации модулей и сущностей
и построени€ главного меню в любой нужный момент времени. }

// ћодуль: "w:\common\components\gui\Garant\VCM\implementation\Visual\NOT_FINISHED_vcmMainMenuBuilder.pas"
// —тереотип: "SimpleClass"

{$Include vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
;

type
 TvcmMainMenuBuilder = class
  {* —ервис, предназначенный дл€ регистрации модулей и сущностей
и построени€ главного меню в любой нужный момент времени. }
 end;//TvcmMainMenuBuilder
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , vcmEntityDefList
 , vcmModuleDefList
;
{$IfEnd} // NOT Defined(NoVCM)

end.
