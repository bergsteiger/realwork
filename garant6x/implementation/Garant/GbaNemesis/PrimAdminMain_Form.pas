unit PrimAdminMain_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\PrimAdminMain_Form.pas"
// Стереотип: "VCMMainForm"
// Элемент модели: "PrimAdminMain" MUID: (4AA518EB039C)
// Имя типа: "TPrimAdminMainForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If Defined(Admin)}
uses
 l3IntfUses
 , PrimMainOptions_Form
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 _AdminAndMonitoringsMainForm_Parent_ = TPrimMainOptionsForm;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\AdminAndMonitoringsMainForm.imp.pas}
 TPrimAdminMainForm = class(_AdminAndMonitoringsMainForm_)
  protected
   {$If NOT Defined(NoVCM)}
   procedure DoInit(aFromHistory: Boolean); override;
    {* Инициализация формы. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure MakeControls; override;
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TPrimAdminMainForm
{$IfEnd} // Defined(Admin)

implementation

{$If Defined(Admin)}
uses
 l3ImplUses
 , Admin_Services
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmSettings
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , PrimAdminMain_utEmptyMainWindow_UserType
 //#UC START# *4AA518EB039Cimpl_uses*
 //#UC END# *4AA518EB039Cimpl_uses*
;

type _Instance_R_ = TPrimAdminMainForm;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\AdminAndMonitoringsMainForm.imp.pas}

{$If NOT Defined(NoVCM)}
procedure TPrimAdminMainForm.DoInit(aFromHistory: Boolean);
 {* Инициализация формы. Для перекрытия в потомках }
//#UC START# *49803F5503AA_4AA518EB039C_var*
//#UC END# *49803F5503AA_4AA518EB039C_var*
begin
//#UC START# *49803F5503AA_4AA518EB039C_impl*
 inherited;
 TAdminService.Instance.OpenUserList(Self);
//#UC END# *49803F5503AA_4AA518EB039C_impl*
end;//TPrimAdminMainForm.DoInit
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimAdminMainForm.MakeControls;
begin
 inherited;
 with AddUsertype(utEmptyMainWindowName,
  str_utEmptyMainWindowCaption,
  str_utEmptyMainWindowSettingsCaption,
  True,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(utEmptyMainWindowName
end;//TPrimAdminMainForm.MakeControls
{$IfEnd} // NOT Defined(NoVCM)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimAdminMainForm);
 {* Регистрация PrimAdminMain }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(Admin)

end.
