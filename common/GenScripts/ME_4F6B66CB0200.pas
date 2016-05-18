unit Parent_Form;

// Модуль: "w:\common\components\gui\Garant\VCM\View\ParentAndChild\Forms\Parent_Form.pas"
// Стереотип: "VCMFinalContainer"
// Элемент модели: "Parent" MUID: (4F6B66CB0200)
// Имя типа: "TParentForm"

{$Include w:\common\components\gui\f1LikeAppDefine.inc}

interface

uses
 l3IntfUses
 , PrimParent_Form
 , F1Like_FormDefinitions_Controls
;

type
 TParentForm = {final} class(TPrimParentForm, ParentFormDef)
 end;//TParentForm

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , ParentKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TParentForm);
 {* Регистрация Parent }
{$IfEnd} // NOT Defined(NoScripts)
 fm_ParentForm.SetFactory(TParentForm.Make);
 {* Регистрация фабрики формы Parent }

end.
