unit PrimSaveLoadUserTypes_slqtFilters_UserType;
 {* �������� �������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimSaveLoadUserTypes_slqtFilters_UserType.pas"
// ���������: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , PrimSaveLoadUserTypes_slqtPublishSource_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* ��������� ��� ���� ����� slqtFilters }
 slqtFiltersName = 'slqtFilters';
  {* ��������� ������������� ����������������� ���� "�������� ��������" }
 slqtFilters = TvcmUserType(slqtPublishSource + 1);
  {* �������� �������� }
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_slqtFilters = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� slqtFilters }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_slqtFilters
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_slqtFilters.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::slqtFilters';
end;//Tkw_FormUserType_slqtFilters.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_slqtFilters.GetInteger: Integer;
begin
 Result := slqtFilters;
end;//Tkw_FormUserType_slqtFilters.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_slqtFilters.RegisterInEngine;
 {* ����������� Tkw_FormUserType_slqtFilters }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.
