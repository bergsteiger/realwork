unit ListUserTypes_lftSimilarDocumentsToFragment_UserType;
 {* ������� � ��������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\ListUserTypes_lftSimilarDocumentsToFragment_UserType.pas"
// ���������: "UserType"
// ������� ������: "lftSimilarDocumentsToFragment" MUID: (5594F3A50378)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , ListUserTypes_lftRToPart_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 {* ��������� ��� ���� ����� lftSimilarDocumentsToFragment }
 lftSimilarDocumentsToFragmentName = 'lftSimilarDocumentsToFragment';
  {* ��������� ������������� ����������������� ���� "������� � ���������" }
 lftSimilarDocumentsToFragment = TvcmUserType(lftRToPart + 1);
  {* ������� � ��������� }
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
 Tkw_FormUserType_lftSimilarDocumentsToFragment = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� lftSimilarDocumentsToFragment }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_lftSimilarDocumentsToFragment
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_lftSimilarDocumentsToFragment.GetInteger: Integer;
begin
 Result := lftSimilarDocumentsToFragment;
end;//Tkw_FormUserType_lftSimilarDocumentsToFragment.GetInteger

class function Tkw_FormUserType_lftSimilarDocumentsToFragment.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::lftSimilarDocumentsToFragment';
end;//Tkw_FormUserType_lftSimilarDocumentsToFragment.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_lftSimilarDocumentsToFragment.RegisterInEngine;
 {* ����������� Tkw_FormUserType_lftSimilarDocumentsToFragment }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
