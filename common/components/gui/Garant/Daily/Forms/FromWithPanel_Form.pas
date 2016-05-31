unit FromWithPanel_Form;

// ������: "w:\common\components\gui\Garant\Daily\Forms\FromWithPanel_Form.pas"
// ���������: "VCMForm"
// ������� ������: "FromWithPanel" MUID: (51D534260378)
// ��� ����: "TFromWithPanelForm"

{$Include w:\common\components\gui\sdotDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmEntityForm
 , vtPanel
 , vcmInterfaces
 , vcmEntities
;

const
 fm_FromWithPanelForm: TvcmFormDescriptor = (rFormID : (rName : 'FromWithPanelForm'; rID : 0); rFactory : nil);
  {* ������������� ����� TFromWithPanelForm }

type
 TFromWithPanelForm = class;

 FromWithPanelFormDef = interface
  {* ������������� ����� FromWithPanel }
  ['{52A98A72-5DD1-4BDA-8FD3-152438D1B28D}']
 end;//FromWithPanelFormDef

 TFromWithPanelForm = {final} class(TvcmEntityForm, FromWithPanelFormDef)
   Entities : TvcmEntities;
  private
   f_WorkSpace: TvtPanel;
  protected
   procedure InitControls; override;
    {* ��������� ������������� ���������. ��� ���������� � �������� }
   procedure MakeControls; override;
  public
   property WorkSpace: TvtPanel
    read f_WorkSpace;
 end;//TFromWithPanelForm
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

implementation

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , FromWithPanel_ut_FromWithPanel_UserType
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , FromWithPanelKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
;

{$R *.DFM}

procedure TFromWithPanelForm.InitControls;
 {* ��������� ������������� ���������. ��� ���������� � �������� }
//#UC START# *4A8E8F2E0195_51D534260378_var*
//#UC END# *4A8E8F2E0195_51D534260378_var*
begin
//#UC START# *4A8E8F2E0195_51D534260378_impl*
 inherited;
 f_WorkSpace.Align := alClient;
//#UC END# *4A8E8F2E0195_51D534260378_impl*
end;//TFromWithPanelForm.InitControls

procedure TFromWithPanelForm.MakeControls;
begin
 inherited;
 with AddUsertype(ut_FromWithPanelName,
  str_ut_FromWithPanelCaption,
  str_ut_FromWithPanelCaption,
  False,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(ut_FromWithPanelName
 f_WorkSpace := TvtPanel.Create(Self);
 f_WorkSpace.Name := 'WorkSpace';
 f_WorkSpace.Parent := Self;
end;//TFromWithPanelForm.MakeControls

initialization
 fm_FromWithPanelForm.SetFactory(TFromWithPanelForm.Make);
 {* ����������� ������� ����� FromWithPanel }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TFromWithPanelForm);
 {* ����������� FromWithPanel }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

end.
