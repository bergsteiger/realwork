unit PrimTreeAttributeSelect_astTaxesPublishSearch_UserType;
 {* ��� �� ������� � �������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\LiteSearch\Forms\PrimTreeAttributeSelect_astTaxesPublishSearch_UserType.pas"
// ���������: "UserType"
// ������� ������: "astTaxesPublishSearch" MUID: (4BD6F992021A)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , PrimTreeAttributeSelect_astFirstLevel_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
;

const
 {* ������������ ������ astTaxesPublishSearchLocalConstants }
 str_astTaxesPublishSearchCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'astTaxesPublishSearchCaption'; rValue : '��� �� ������� � ��������');
  {* ��������� ����������������� ���� "��� �� ������� � ��������" }
 {* ��������� ��� ���� ����� astTaxesPublishSearch }
 astTaxesPublishSearchName = 'astTaxesPublishSearch';
  {* ��������� ������������� ����������������� ���� "��� �� ������� � ��������" }
 astTaxesPublishSearch = TvcmUserType(astFirstLevel + 1);
  {* ��� �� ������� � �������� }

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_astTaxesPublishSearch = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� astTaxesPublishSearch }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_astTaxesPublishSearch
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_astTaxesPublishSearch.GetInteger: Integer;
begin
 Result := astTaxesPublishSearch;
end;//Tkw_FormUserType_astTaxesPublishSearch.GetInteger

class function Tkw_FormUserType_astTaxesPublishSearch.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::astTaxesPublishSearch';
end;//Tkw_FormUserType_astTaxesPublishSearch.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_astTaxesPublishSearchCaption.Init;
 {* ������������� str_astTaxesPublishSearchCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_astTaxesPublishSearch.RegisterInEngine;
 {* ����������� Tkw_FormUserType_astTaxesPublishSearch }
{$IfEnd} // NOT Defined(NoScripts)

end.
