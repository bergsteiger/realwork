unit fsInternetAgent;
 {* ������ ���� ��� ���������� ��������-����� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\InternetAgent\fsInternetAgent.pas"
// ���������: "VCMFormSetFactory"
// ������� ������: "InternetAgent" MUID: (49F586610347)
// ��� ����: "Tfs_InternetAgent"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmFormSetFactory
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmFormSetFactoryPrim
 {$IfEnd} // NOT Defined(NoVCM)
 , InternetAgent_Form
 , InternetAgentInterfaces
;

type
 Tfs_InternetAgent = {final} class({$If NOT Defined(NoVCM)}
 TvcmFormSetFactory
 {$IfEnd} // NOT Defined(NoVCM)
 )
  {* ������ ���� ��� ���������� ��������-����� }
  protected
   procedure InitFields; override;
   {$If NOT Defined(NoVCM)}
   class function GetInstance: TvcmFormSetFactoryPrim; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   function InternetAgentParentNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* ���������� OnNeedMakeForm ��� InternetAgent }
   class function Instance: Tfs_InternetAgent;
    {* ����� ��������� ���������� ���������� Tfs_InternetAgent }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
 end;//Tfs_InternetAgent
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3StringIDEx
 , SysUtils
 , l3Base
;

{$If NOT Defined(NoVCM)}
var g_Tfs_InternetAgent: Tfs_InternetAgent = nil;
 {* ��������� ���������� Tfs_InternetAgent }

const
 {* ������������ ������ InternetAgentCaptionLocalConstants }
 str_fsInternetAgentCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'fsInternetAgentCaption'; rValue : '��������-�����');
  {* ��������� ������� ������ ���� "InternetAgent" }

procedure Tfs_InternetAgentFree;
 {* ����� ������������ ���������� ���������� Tfs_InternetAgent }
begin
 l3Free(g_Tfs_InternetAgent);
end;//Tfs_InternetAgentFree

function Tfs_InternetAgent.InternetAgentParentNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* ���������� OnNeedMakeForm ��� InternetAgent }
var
 l_UseCase : IsdsInternetAgent;
begin
 if Supports(aDataSource, IsdsInternetAgent, l_UseCase) then
  try
   aNew := l_UseCase.MainViewArea;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_InternetAgent.InternetAgentParentNeedMakeForm

class function Tfs_InternetAgent.Instance: Tfs_InternetAgent;
 {* ����� ��������� ���������� ���������� Tfs_InternetAgent }
begin
 if (g_Tfs_InternetAgent = nil) then
 begin
  l3System.AddExitProc(Tfs_InternetAgentFree);
  g_Tfs_InternetAgent := Create;
 end;
 Result := g_Tfs_InternetAgent;
end;//Tfs_InternetAgent.Instance

class function Tfs_InternetAgent.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_Tfs_InternetAgent <> nil;
end;//Tfs_InternetAgent.Exists

procedure Tfs_InternetAgent.InitFields;
begin
 inherited;
 with AddZone('InternetAgent', vcm_ztParent, fm_InternetAgentForm) do
 begin
  UserType := 0;
  OnNeedMakeForm := InternetAgentParentNeedMakeForm;
 end;
 Caption := str_fsInternetAgentCaption.AsCStr;
 OwnerForm := 0;
end;//Tfs_InternetAgent.InitFields

class function Tfs_InternetAgent.GetInstance: TvcmFormSetFactoryPrim;
begin
 Result := Self.Instance;
end;//Tfs_InternetAgent.GetInstance

initialization
 str_fsInternetAgentCaption.Init;
 {* ������������� str_fsInternetAgentCaption }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
