unit ListUserTypes_lftSimilarDocumentsSynchroView_UserType;
 {* ���������� �������� (������� ���������) }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\ListUserTypes_lftSimilarDocumentsSynchroView_UserType.pas"
// ���������: "UserType"
// ������� ������: "lftSimilarDocumentsSynchroView" MUID: (4BD58A120226)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , ListUserTypes_lftSimilarDocuments_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 {* ��������� ��� ���� ����� lftSimilarDocumentsSynchroView }
 lftSimilarDocumentsSynchroViewName = 'lftSimilarDocumentsSynchroView';
  {* ��������� ������������� ����������������� ���� "���������� �������� (������� ���������)" }
 lftSimilarDocumentsSynchroView = TvcmUserType(lftSimilarDocuments + 1);
  {* ���������� �������� (������� ���������) }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_lftSimilarDocumentsSynchroView = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� lftSimilarDocumentsSynchroView }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_lftSimilarDocumentsSynchroView
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_lftSimilarDocumentsSynchroView.GetInteger: Integer;
begin
 Result := lftSimilarDocumentsSynchroView;
end;//Tkw_FormUserType_lftSimilarDocumentsSynchroView.GetInteger

class function Tkw_FormUserType_lftSimilarDocumentsSynchroView.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::lftSimilarDocumentsSynchroView';
end;//Tkw_FormUserType_lftSimilarDocumentsSynchroView.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_lftSimilarDocumentsSynchroView.RegisterInEngine;
 {* ����������� Tkw_FormUserType_lftSimilarDocumentsSynchroView }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
