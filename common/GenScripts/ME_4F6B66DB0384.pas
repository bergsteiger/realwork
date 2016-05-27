unit Child_Form;

// Модуль: "w:\common\components\gui\Garant\VCM\View\ParentAndChild\Forms\Child_Form.pas"
// Стереотип: "VCMFinalContainer"
// Элемент модели: "Child" MUID: (4F6B66DB0384)
// Имя типа: "TChildForm"

{$Include w:\common\components\gui\f1LikeAppDefine.inc}

interface

uses
 l3IntfUses
 , PrimChild_Form
 , F1Like_FormDefinitions_Controls
 {$If NOT Defined(NoVCM)}
 , vcmEntities
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TChildForm = {final} class(TPrimChildForm, ChildFormDef)
   Entities : TvcmEntities;
 end;//TChildForm

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , ChildKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
;

{$R *.DFM}

initialization
 fm_ChildForm.SetFactory(TChildForm.Make);
 {* Регистрация фабрики формы Child }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TChildForm);
 {* Регистрация Child }
{$IfEnd} // NOT Defined(NoScripts)

end.
