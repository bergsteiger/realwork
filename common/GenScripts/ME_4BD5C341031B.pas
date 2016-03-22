unit PrimQueryCard_utqcAttributeSearch_UserType;
 {* ����� �� ���������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimQueryCard_utqcAttributeSearch_UserType.pas"
// ���������: "UserType"
// ������� ������: "utqcAttributeSearch" MUID: (4BD5C341031B)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 {* ��������� ��� ���� ����� utqcAttributeSearch }
 utqcAttributeSearchName = 'utqcAttributeSearch';
  {* ��������� ������������� ����������������� ���� "����� �� ����������" }
 utqcAttributeSearch = TvcmUserType(0);
  {* ����� �� ���������� }
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_utqcAttributeSearch = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� utqcAttributeSearch }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_utqcAttributeSearch
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_utqcAttributeSearch.GetInteger: Integer;
begin
 Result := utqcAttributeSearch;
end;//Tkw_FormUserType_utqcAttributeSearch.GetInteger

class function Tkw_FormUserType_utqcAttributeSearch.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::utqcAttributeSearch';
end;//Tkw_FormUserType_utqcAttributeSearch.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utqcAttributeSearch.RegisterInEngine;
 {* ����������� Tkw_FormUserType_utqcAttributeSearch }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.
