unit vcmInternalConst;
 {* Внутренние константы }

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\vcmInternalConst.pas"
// Стереотип: "Interfaces"

{$Include vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmBaseTypes
 , vcmExternalInterfaces
 , vcmUserControls
;

const
 {* Идентификаторы форм }
 fm_Any: TvcmFormID = (rName : ''; rID : 0);

type
 // vcmToolbarOpTypes

 // vcm_AllOperationOptions

 // vcm_ComboOperations

 // vcm_ComboBoxOperations

 // vcm_UseCaptionFromOperation

 // vcmOperationsWithIcon

 // vcm_InternalOperations

 // vcm_HiddenOperations

 // vcm_SimpleOperations

 // vcmVisualOperations

 // vcm_NotContainedForm

 // vcm_omExecutes
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(NoVCM)

end.
