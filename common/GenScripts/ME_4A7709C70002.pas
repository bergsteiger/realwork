unit Text_Form;
 {* Текст документа }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\Forms\Text_Form.pas"
// Стереотип: "VCMFinalContainer"
// Элемент модели: "Text" MUID: (4A7709C70002)
// Имя типа: "TTextForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , ExTextOptions_Form
 , Common_FormDefinitions_Controls
 {$If NOT Defined(NoVCM)}
 , vcmEntities
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TTextForm = {final} class(TExTextOptionsForm, TextFormDef)
  {* Текст документа }
   Entities : TvcmEntities;
 end;//TTextForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , TextKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
;

{$R *.DFM}

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TTextForm);
 {* Регистрация Text }
{$IfEnd} // NOT Defined(NoScripts)
 fm_TextForm.SetFactory(TTextForm.Make);
 {* Регистрация фабрики формы Text }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
