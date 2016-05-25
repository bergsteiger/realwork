unit ProgressIndicator_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\ProgressIndicator_Form.pas"
// Стереотип: "VCMFinalForm"
// Элемент модели: "ProgressIndicator" MUID: (4A93F1CC01A8)
// Имя типа: "TefProgressIndicator"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimProgressIndicator_Form
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmEntities
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCL)}
 , ComCtrls
 {$IfEnd} // NOT Defined(NoVCL)
;

const
 fm_efProgressIndicator: TvcmFormDescriptor = (rFormID : (rName : 'efProgressIndicator'; rID : 0); rFactory : nil);
  {* Идентификатор формы TefProgressIndicator }

type
 TefProgressIndicator = class;

 ProgressIndicatorFormDef = interface
  {* Идентификатор формы ProgressIndicator }
  ['{83193317-8438-475F-9F0C-1C44F08B2DA4}']
 end;//ProgressIndicatorFormDef

 TefProgressIndicator = {final} class(TPrimProgressIndicatorForm, ProgressIndicatorFormDef)
   Entities : TvcmEntities;
   ProgressBar : TProgressBar;
 end;//TefProgressIndicator
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , ProgressIndicatorKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
;

{$R *.DFM}

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TefProgressIndicator);
 {* Регистрация ProgressIndicator }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
