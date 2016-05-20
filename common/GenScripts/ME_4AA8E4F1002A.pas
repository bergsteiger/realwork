unit Admin_Form;
 {* Администрирование пользователей }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Admin\Forms\Admin_Form.pas"
// Стереотип: "VCMFinalForm"
// Элемент модели: "AdminForm" MUID: (4AA8E4F1002A)
// Имя типа: "TcfAdminForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If Defined(Admin)}
uses
 l3IntfUses
 , PrimAdminOptions_Form
 , Admin_FormDefinitions_Controls
 {$If NOT Defined(NoVCM)}
 , vcmEntities
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TcfAdminForm = {final} class(TPrimAdminOptionsForm, AdminFormFormDef)
  {* Администрирование пользователей }
   Entities : TvcmEntities;
 end;//TcfAdminForm
{$IfEnd} // Defined(Admin)

implementation

{$If Defined(Admin)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , AdminFormKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
;

{$R *.DFM}

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TcfAdminForm);
 {* Регистрация AdminForm }
{$IfEnd} // NOT Defined(NoScripts)
 fm_cfAdminForm.SetFactory(TcfAdminForm.Make);
 {* Регистрация фабрики формы AdminForm }
{$IfEnd} // Defined(Admin)

end.
