unit PrimFoldersElementInfoOptions_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Folders\Forms\PrimFoldersElementInfoOptions_Form.pas"
// Стереотип: "VCMForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimFoldersElementInfo_Form
 , Folders_Result_Controls
;

type
 TPrimFoldersElementInfoOptionsForm = class(TPrimFoldersElementInfoForm)
  public
   procedure Cancel; override;
    {* Отмена }
   procedure Ok; override;
    {* OK }
   procedure Append; override;
    {* Добавить }
 end;//TPrimFoldersElementInfoOptionsForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , BaseTreeSupportUnit
 , SysUtils
 , FoldersDomainInterfaces
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , Folders_Strange_Controls
 , FoldersUnit
 , eeInterfaces
 , nsFolders
 {$If NOT Defined(NoVCL)}
 , StdCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 , BaseTypesUnit
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

procedure TPrimFoldersElementInfoOptionsForm.Cancel;
 {* Отмена }
//#UC START# *4AFAEBEA0018_4C7E91560315_var*
//#UC END# *4AFAEBEA0018_4C7E91560315_var*
begin
//#UC START# *4AFAEBEA0018_4C7E91560315_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AFAEBEA0018_4C7E91560315_impl*
end;//TPrimFoldersElementInfoOptionsForm.Cancel

procedure TPrimFoldersElementInfoOptionsForm.Ok;
 {* OK }
//#UC START# *4C765D0002E2_4C7E91560315_var*
//#UC END# *4C765D0002E2_4C7E91560315_var*
begin
//#UC START# *4C765D0002E2_4C7E91560315_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C765D0002E2_4C7E91560315_impl*
end;//TPrimFoldersElementInfoOptionsForm.Ok

procedure TPrimFoldersElementInfoOptionsForm.Append;
 {* Добавить }
//#UC START# *4C7672F903BF_4C7E91560315_var*
//#UC END# *4C7672F903BF_4C7E91560315_var*
begin
//#UC START# *4C7672F903BF_4C7E91560315_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7672F903BF_4C7E91560315_impl*
end;//TPrimFoldersElementInfoOptionsForm.Append

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimFoldersElementInfoOptionsForm);
 {* Регистрация PrimFoldersElementInfoOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
