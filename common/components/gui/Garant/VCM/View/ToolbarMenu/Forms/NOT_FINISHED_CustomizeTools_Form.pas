unit NOT_FINISHED_CustomizeTools_Form;

// ������: "w:\common\components\gui\Garant\VCM\View\ToolbarMenu\Forms\NOT_FINISHED_CustomizeTools_Form.pas"
// ���������: "VCMFinalForm"
// ������� ������: "CustomizeTools" MUID: (4C8E42D40131)
// ��� ����: "TCustomizeToolsForm"

{$Include w:\common\components\gui\sdoDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , PrimCustomizeTools_Form
 , vcmEntities
;

type
 TCustomizeToolsForm = {final} class(TPrimCustomizeToolsForm)
   Entities : TvcmEntities;
  protected
   procedure MakeControls; override;
 end;//TCustomizeToolsForm
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , l3StringIDEx
 {$If Defined(Nemesis)}
 , eeShortCutEdit
 {$IfEnd} // Defined(Nemesis)
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , vcmInterfaces
 , CustomizeTools_ut_CustomizeTools_UserType
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , CustomizeToolsKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
;

const
 {* ������������ ������ ut_CustomizeToolsLocalConstants }
 str_ut_CustomizeToolsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_CustomizeToolsCaption'; rValue : 'CustomizeTools');
  {* ��������� ����������������� ���� "CustomizeTools" }

{$R *.DFM}

procedure TCustomizeToolsForm.MakeControls;
begin
 inherited;
 with AddUsertype(ut_CustomizeToolsName,
  str_ut_CustomizeToolsCaption,
  str_ut_CustomizeToolsCaption,
  False,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(ut_CustomizeToolsName
end;//TCustomizeToolsForm.MakeControls

initialization
 str_ut_CustomizeToolsCaption.Init;
 {* ������������� str_ut_CustomizeToolsCaption }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TCustomizeToolsForm);
 {* ����������� CustomizeTools }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

end.
