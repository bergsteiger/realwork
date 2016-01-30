unit PrimFoldersOptions_Form;
 {* ��� ��������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Folders\Forms\PrimFoldersOptions_Form.pas"
// ���������: "VCMContainer"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimFolders_Form
;

type
 TPrimFoldersOptionsForm = class(TPrimFoldersForm)
  {* ��� ��������� }
  public
   procedure Append; override;
    {* �������� }
   {$If NOT Defined(NoVCM)}
   procedure Ok; override;
    {* OK }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Cancel; override;
    {* ������ }
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TPrimFoldersOptionsForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

procedure TPrimFoldersOptionsForm.Append;
 {* �������� }
//#UC START# *4A98000500BA_4C7E5E980303_var*
//#UC END# *4A98000500BA_4C7E5E980303_var*
begin
//#UC START# *4A98000500BA_4C7E5E980303_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A98000500BA_4C7E5E980303_impl*
end;//TPrimFoldersOptionsForm.Append

{$If NOT Defined(NoVCM)}
procedure TPrimFoldersOptionsForm.Ok;
 {* OK }
//#UC START# *4C762A1501FC_4C7E5E980303_var*
//#UC END# *4C762A1501FC_4C7E5E980303_var*
begin
//#UC START# *4C762A1501FC_4C7E5E980303_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C762A1501FC_4C7E5E980303_impl*
end;//TPrimFoldersOptionsForm.Ok
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimFoldersOptionsForm.Cancel;
 {* ������ }
//#UC START# *4C762AB601E1_4C7E5E980303_var*
//#UC END# *4C762AB601E1_4C7E5E980303_var*
begin
//#UC START# *4C762AB601E1_4C7E5E980303_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C762AB601E1_4C7E5E980303_impl*
end;//TPrimFoldersOptionsForm.Cancel
{$IfEnd} // NOT Defined(NoVCM)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimFoldersOptionsForm);
 {* ����������� PrimFoldersOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
