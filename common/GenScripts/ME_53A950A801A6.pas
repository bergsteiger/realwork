unit PrimTreeAttributeSelect_astPharmPublishSearch_UserType;
 {* ��� �� �������� � ��������������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\LiteSearch\Forms\PrimTreeAttributeSelect_astPharmPublishSearch_UserType.pas"
// ���������: "UserType"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , PrimTreeAttributeSelect_astTaxesPublishSearch_UserType
 , PrimTreeAttributeSelect_astNone_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 {* ��������� ��� ���� ����� astPharmPublishSearch }
 astPharmPublishSearchName = 'astPharmPublishSearch';
  {* ��������� ������������� ����������������� ���� "��� �� �������� � ���������������" }
 astPharmPublishSearch = TvcmUserType(astTaxesPublishSearch + 1);
  {* ��� �� �������� � ��������������� }

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_astPharmPublishSearch = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� astPharmPublishSearch }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_astPharmPublishSearch
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_astPharmPublishSearch.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::astPharmPublishSearch';
end;//Tkw_FormUserType_astPharmPublishSearch.GetWordNameForRegister

function Tkw_FormUserType_astPharmPublishSearch.GetInteger: Integer;
begin
 Result := astPharmPublishSearch;
end;//Tkw_FormUserType_astPharmPublishSearch.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_astPharmPublishSearch.RegisterInEngine;
 {* ����������� Tkw_FormUserType_astPharmPublishSearch }
{$IfEnd} // NOT Defined(NoScripts)

end.
