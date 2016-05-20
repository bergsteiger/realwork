unit CompInfo_Form;
 {* ���������� � ��������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\CompInfo_Form.pas"
// ���������: "VCMFinalForm"
// ������� ������: "CompInfo" MUID: (4ABB769903BF)
// ��� ����: "TenCompInfo"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimCompInfo_Form
 , Common_FormDefinitions_Controls
 {$If NOT Defined(NoVCM)}
 , vcmEntities
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TenCompInfo = {final} class(TPrimCompInfoForm, CompInfoFormDef)
  {* ���������� � ��������� }
   Entities : TvcmEntities;
  protected
   {$If NOT Defined(NoVCM)}
   procedure MakeControls; override;
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TenCompInfo
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3StringIDEx
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , l3MessageID
 , CompInfo_ut_CompInfo_UserType
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , CompInfoKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 {$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
 , vcmTabbedContainerFormDispatcher
 {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)
;

const
 {* ������������ ������ ut_CompInfoLocalConstants }
 str_ut_CompInfoCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_CompInfoCaption'; rValue : '���������� � ���������');
  {* ��������� ����������������� ���� "���������� � ���������" }

{$R *.DFM}

{$If NOT Defined(NoVCM)}
procedure TenCompInfo.MakeControls;
begin
 inherited;
 with AddUsertype(ut_CompInfoName,
  str_ut_CompInfoCaption,
  str_ut_CompInfoCaption,
  False,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(ut_CompInfoName
end;//TenCompInfo.MakeControls
{$IfEnd} // NOT Defined(NoVCM)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TenCompInfo);
 {* ����������� CompInfo }
{$IfEnd} // NOT Defined(NoScripts)
 fm_enCompInfo.SetFactory(TenCompInfo.Make);
 {* ����������� ������� ����� CompInfo }
 str_ut_CompInfoCaption.Init;
 {* ������������� str_ut_CompInfoCaption }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
