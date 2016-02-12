unit FiltersUserTypes_utFilters_UserType;
 {* ������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\FiltersUserTypes_utFilters_UserType.pas"
// ���������: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* ��������� ��� ���� ����� utFilters }
 utFiltersName = 'utFilters';
  {* ��������� ������������� ����������������� ���� "�������" }
 utFilters = TvcmUserType(0);
  {* ������� }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utFilters = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� utFilters }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_utFilters
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_utFilters.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::utFilters';
end;//Tkw_FormUserType_utFilters.GetWordNameForRegister

function Tkw_FormUserType_utFilters.GetInteger: Integer;
begin
 Result := utFilters;
end;//Tkw_FormUserType_utFilters.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utFilters.RegisterInEngine;
 {* ����������� Tkw_FormUserType_utFilters }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
