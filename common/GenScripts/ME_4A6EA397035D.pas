unit ChatHistory_Form;
 {* История переписки }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Chat\Forms\ChatHistory_Form.pas"
// Стереотип: "VCMFinalForm"
// Элемент модели: "ChatHistory" MUID: (4A6EA397035D)
// Имя типа: "TChatHistoryForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , BaseHistoryWindow_Form
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmEntities
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 fm_ChatHistoryForm: TvcmFormDescriptor = (rFormID : (rName : 'ChatHistoryForm'; rID : 0); rFactory : nil);
  {* Идентификатор формы TChatHistoryForm }

type
 TChatHistoryForm = class;

 ChatHistoryFormDef = interface
  {* Идентификатор формы ChatHistory }
  ['{5B6E40C6-04D1-47E4-B97A-0C7AB1B3D1F9}']
 end;//ChatHistoryFormDef

 TChatHistoryForm = {final} class(TBaseHistoryWindowForm, ChatHistoryFormDef)
  {* История переписки }
   Entities : TvcmEntities;
 end;//TChatHistoryForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , ChatHistoryKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
;

{$R *.DFM}

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TChatHistoryForm);
 {* Регистрация ChatHistory }
{$IfEnd} // NOT Defined(NoScripts)
 fm_ChatHistoryForm.SetFactory(TChatHistoryForm.Make);
 {* Регистрация фабрики формы ChatHistory }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
