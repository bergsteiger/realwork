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
;

const
 fm_FromWithPanelForm: TvcmFormDescriptor = (rFormID : (rName : 'FromWithPanelForm'; rID : 0); rFactory : nil);
  {* ������������� ����� TFromWithPanelForm }

type
 FromWithPanelFormDef = interface
  {* ������������� ����� FromWithPanel }
  ['{52A98A72-5DD1-4BDA-8FD3-152438D1B28D}']
 end;//FromWithPanelFormDef

 TFromWithPanelForm = {final} class(TvcmEntityForm, FromWithPanelFormDef)
  private
   f_WorkSpace: TvtPanel;
    {* ���� ��� �������� WorkSpace }
  protected
   procedure InitControls; override;
    {* ��������� ������������� ���������. ��� ���������� � �������� }
  public
   property WorkSpace: TvtPanel
    read f_WorkSpace;
 end;//TFromWithPanelForm
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

implementation

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 , l3StringIDEx
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , FromWithPanelKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* ������������ ������ ut_FromWithPanelLocalConstants }
 str_ut_FromWithPanelCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_FromWithPanelCaption'; rValue : 'FromWithPanel');
  {* ��������� ����������������� ���� "FromWithPanel" }

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

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TFromWithPanelForm);
 {* ����������� FromWithPanel }
{$IfEnd} // NOT Defined(NoScripts)
 fm_FromWithPanelForm.SetFactory(TFromWithPanelForm.Make);
 {* ����������� ������� ����� FromWithPanel }
 str_ut_FromWithPanelCaption.Init;
 {* ������������� str_ut_FromWithPanelCaption }
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

end.
