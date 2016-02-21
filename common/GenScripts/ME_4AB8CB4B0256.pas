unit NOT_FINISHED_vcmItems;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\NOT_FINISHED_vcmItems.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmStringList
;

type
 TvcmItems = class(TvcmStringList)
 end;//TvcmItems
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(NoVCM)

end.
