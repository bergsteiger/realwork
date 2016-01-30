unit PrimTreeAttributeSelect_astTaxesPublishSearch_UserType;
 {* ��� �� ������� � �������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\LiteSearch\Forms\PrimTreeAttributeSelect_astTaxesPublishSearch_UserType.pas"
// ���������: "UserType"

{$Include nsDefine.inc}

interface

uses
 l3IntfUses
 , PrimTreeAttributeSelect_astFirstLevel_UserType
 , PrimTreeAttributeSelect_astNone_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* ��������� ��� ���� ����� astTaxesPublishSearch }
 astTaxesPublishSearchName = 'astTaxesPublishSearch';
  {* ��������� ������������� ����������������� ���� "��� �� ������� � ��������" }
 astTaxesPublishSearch = TvcmUserType(astFirstLevel + 1);
  {* ��� �� ������� � �������� }

implementation

uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_astTaxesPublishSearch = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� astTaxesPublishSearch }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_astTaxesPublishSearch
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_astTaxesPublishSearch.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::astTaxesPublishSearch';
end;//Tkw_FormUserType_astTaxesPublishSearch.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_astTaxesPublishSearch.GetInteger: Integer;
begin
 Result := astTaxesPublishSearch;
end;//Tkw_FormUserType_astTaxesPublishSearch.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_astTaxesPublishSearch.RegisterInEngine;
 {* ����������� Tkw_FormUserType_astTaxesPublishSearch }
{$IfEnd} // NOT Defined(NoScripts)

end.
