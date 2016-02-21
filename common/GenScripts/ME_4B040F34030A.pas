unit DocumentUserTypes_dftAutoreferatAfterSearch_UserType;
 {* �����. ����� ��������� ���������������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftAutoreferatAfterSearch_UserType.pas"
// ���������: "UserType"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentUserTypes_dftAnnotation_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 {* ��������� ��� ���� ����� dftAutoreferatAfterSearch }
 dftAutoreferatAfterSearchName = 'dftAutoreferatAfterSearch';
  {* ��������� ������������� ����������������� ���� "�����. ����� ��������� ����������������" }
 dftAutoreferatAfterSearch = TvcmUserType(dftAnnotation + 1);
  {* �����. ����� ��������� ���������������� }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftAutoreferatAfterSearch = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� dftAutoreferatAfterSearch }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_dftAutoreferatAfterSearch
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_dftAutoreferatAfterSearch.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::dftAutoreferatAfterSearch';
end;//Tkw_FormUserType_dftAutoreferatAfterSearch.GetWordNameForRegister

function Tkw_FormUserType_dftAutoreferatAfterSearch.GetInteger: Integer;
begin
 Result := dftAutoreferatAfterSearch;
end;//Tkw_FormUserType_dftAutoreferatAfterSearch.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftAutoreferatAfterSearch.RegisterInEngine;
 {* ����������� Tkw_FormUserType_dftAutoreferatAfterSearch }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
