unit PrimFoldersInfo_Form;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Folders\Forms\PrimFoldersInfo_Form.pas"
// ���������: "VCMContainer"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmContainerForm
 {$IfEnd} // NOT Defined(NoVCM)
 , Folders_Strange_Controls
 , vtPanel
 , l3StringIDEx
;

type
 // Child

 TPrimFoldersInfoForm = class(TvcmContainerForm)
  private
   f_ChildZone: TvtPanel;
    {* ���� ��� �������� ChildZone }
  protected
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* ��������� ������������� ���������. ��� ���������� � �������� }
   {$IfEnd} // NOT Defined(NoVCM)
  public
   procedure Close; override;
   procedure SetState; override;
  public
   property ChildZone: TvtPanel
    read f_ChildZone;
 end;//TPrimFoldersInfoForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , nsFolders
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* ������������ ������ utFoldersInfoContainerLocalConstants }
 str_utFoldersInfoContainerCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utFoldersInfoContainerCaption'; rValue : '�������� ����� (��������� ������)');
  {* ��������� ����������������� ���� "�������� ����� (��������� ������)" }

procedure TPrimFoldersInfoForm.Close;
//#UC START# *4AE9BF890271_4AE9BEEF0229_var*
//#UC END# *4AE9BF890271_4AE9BEEF0229_var*
begin
//#UC START# *4AE9BF890271_4AE9BEEF0229_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AE9BF890271_4AE9BEEF0229_impl*
end;//TPrimFoldersInfoForm.Close

procedure TPrimFoldersInfoForm.SetState;
//#UC START# *4AE9C01201BA_4AE9BEEF0229_var*
//#UC END# *4AE9C01201BA_4AE9BEEF0229_var*
begin
//#UC START# *4AE9C01201BA_4AE9BEEF0229_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AE9C01201BA_4AE9BEEF0229_impl*
end;//TPrimFoldersInfoForm.SetState

{$If NOT Defined(NoVCM)}
procedure TPrimFoldersInfoForm.InitControls;
 {* ��������� ������������� ���������. ��� ���������� � �������� }
//#UC START# *4A8E8F2E0195_4AE9BEEF0229_var*
//#UC END# *4A8E8F2E0195_4AE9BEEF0229_var*
begin
//#UC START# *4A8E8F2E0195_4AE9BEEF0229_impl*
 inherited;
 with ChildZone do
 begin
  Align := alClient;
  BevelOuter := bvNone;
 end;
//#UC END# *4A8E8F2E0195_4AE9BEEF0229_impl*
end;//TPrimFoldersInfoForm.InitControls
{$IfEnd} // NOT Defined(NoVCM)

initialization
 str_utFoldersInfoContainerCaption.Init;
 {* ������������� str_utFoldersInfoContainerCaption }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimFoldersInfoForm);
 {* ����������� PrimFoldersInfo }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
