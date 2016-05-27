unit ChangesBetweenEditons_Form;
 {* Изменения в документе }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\ChangesBetweenEditons\Forms\ChangesBetweenEditons_Form.pas"
// Стереотип: "VCMFinalForm"
// Элемент модели: "ChangesBetweenEditons" MUID: (4DDCD6800267)
// Имя типа: "TChangesBetweenEditonsForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimChangesBetweenEditons_Form
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmEntities
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 fm_ChangesBetweenEditonsForm: TvcmFormDescriptor = (rFormID : (rName : 'ChangesBetweenEditonsForm'; rID : 0); rFactory : nil);
  {* Идентификатор формы TChangesBetweenEditonsForm }

type
 TChangesBetweenEditonsForm = class;

 ChangesBetweenEditonsFormDef = interface
  {* Идентификатор формы ChangesBetweenEditons }
  ['{E8402096-B641-4FAE-B341-69369D1BB399}']
 end;//ChangesBetweenEditonsFormDef

 TChangesBetweenEditonsForm = {final} class(TPrimChangesBetweenEditonsForm, ChangesBetweenEditonsFormDef)
  {* Изменения в документе }
   Entities : TvcmEntities;
 end;//TChangesBetweenEditonsForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , ChangesBetweenEditonsKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
;

{$R *.DFM}

initialization
 fm_ChangesBetweenEditonsForm.SetFactory(TChangesBetweenEditonsForm.Make);
 {* Регистрация фабрики формы ChangesBetweenEditons }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TChangesBetweenEditonsForm);
 {* Регистрация ChangesBetweenEditons }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
