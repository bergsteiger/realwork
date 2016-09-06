unit Document_Module;
 {* Документ }

// Модуль: "w:\common\components\SandBox\VCM\View\Document\Document_Module.pas"
// Стереотип: "VCMFormsPack"
// Элемент модели: "Document" MUID: (5216345D004A)
// Имя типа: "TDocumentModule"

{$Include w:\common\components\SandBox\VCM\sbDefine.inc}

interface

uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmModule
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TDocumentModule = class({$If NOT Defined(NoVCM)}
 TvcmModule
 {$IfEnd} // NOT Defined(NoVCM)
 )
  {* Документ }
 end;//TDocumentModule

implementation

uses
 l3ImplUses
 //#UC START# *5216345D004Aimpl_uses*
 //#UC END# *5216345D004Aimpl_uses*
;

{$If NOT Defined(NoVCM)}
{$IfEnd} // NOT Defined(NoVCM)
end.
