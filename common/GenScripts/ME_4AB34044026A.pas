unit NOT_FINISHED_vcmModulesCollection;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Components\NOT_FINISHED_vcmModulesCollection.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TvcmModulesCollection" MUID: (4AB34044026A)

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
 {$If NOT Defined(NoScripts)}
 , tfwModuleOperationWordEx
 {$IfEnd} // NOT Defined(NoScripts)
;
{$IfEnd} // NOT Defined(NoVCM)

end.
