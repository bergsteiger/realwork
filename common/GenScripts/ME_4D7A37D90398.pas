unit PrimBaseSearch_BaseSearch_UserType;
 {* ������� ����� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\BaseSearch\Forms\PrimBaseSearch_BaseSearch_UserType.pas"
// ���������: "UserType"
// ������� ������: "BaseSearch" MUID: (4D7A37D90398)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 {* ��������� ��� ���� ����� BaseSearch }
 BaseSearchName = 'BaseSearch';
  {* ��������� ������������� ����������������� ���� "������� �����" }
 BaseSearch = TvcmUserType(0);
  {* ������� ����� }
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
 Tkw_FormUserType_BaseSearch = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� BaseSearch }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_BaseSearch
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_BaseSearch.GetInteger: Integer;
begin
 Result := BaseSearch;
end;//Tkw_FormUserType_BaseSearch.GetInteger

class function Tkw_FormUserType_BaseSearch.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::BaseSearch';
end;//Tkw_FormUserType_BaseSearch.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_BaseSearch.RegisterInEngine;
 {* ����������� Tkw_FormUserType_BaseSearch }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
