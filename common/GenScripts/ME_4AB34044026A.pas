unit NOT_FINISHED_vcmModulesCollection;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Components\NOT_FINISHED_vcmModulesCollection.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
;

type
 RvcmModulesCollection = class of TvcmModulesCollection;

 TvcmModulesCollection = class
 end;//TvcmModulesCollection
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(NoVCM)

end.
