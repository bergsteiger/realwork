unit PrimSaveLoadUserTypes_slqtInpharmSearch_UserType;
 {* ����� ������������� ������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimSaveLoadUserTypes_slqtInpharmSearch_UserType.pas"
// ���������: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , PrimSaveLoadUserTypes_slqtConsult_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* ��������� ��� ���� ����� slqtInpharmSearch }
 slqtInpharmSearchName = 'slqtInpharmSearch';
  {* ��������� ������������� ����������������� ���� "����� ������������� �������" }
 slqtInpharmSearch = TvcmUserType(slqtConsult + 1);
  {* ����� ������������� ������� }
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_slqtInpharmSearch = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� slqtInpharmSearch }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_slqtInpharmSearch
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_slqtInpharmSearch.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::slqtInpharmSearch';
end;//Tkw_FormUserType_slqtInpharmSearch.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_slqtInpharmSearch.GetInteger: Integer;
begin
 Result := slqtInpharmSearch;
end;//Tkw_FormUserType_slqtInpharmSearch.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_slqtInpharmSearch.RegisterInEngine;
 {* ����������� Tkw_FormUserType_slqtInpharmSearch }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.
