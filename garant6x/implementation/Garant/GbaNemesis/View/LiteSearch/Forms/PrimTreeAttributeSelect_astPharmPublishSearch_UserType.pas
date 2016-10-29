unit PrimTreeAttributeSelect_astPharmPublishSearch_UserType;
 {* ��� �� �������� � ��������������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\LiteSearch\Forms\PrimTreeAttributeSelect_astPharmPublishSearch_UserType.pas"
// ���������: "UserType"
// ������� ������: "astPharmPublishSearch" MUID: (53A950A801A6)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , PrimTreeAttributeSelect_astTaxesPublishSearch_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
;

const
 {* ������������ ������ astPharmPublishSearchLocalConstants }
 str_astPharmPublishSearchCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'astPharmPublishSearchCaption'; rValue : '��� �� �������� � ���������������');
  {* ��������� ����������������� ���� "��� �� �������� � ���������������" }
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

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_astPharmPublishSearch = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� astPharmPublishSearch }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_astPharmPublishSearch
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_astPharmPublishSearch.GetInteger: Integer;
begin
 Result := astPharmPublishSearch;
end;//Tkw_FormUserType_astPharmPublishSearch.GetInteger

class function Tkw_FormUserType_astPharmPublishSearch.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::astPharmPublishSearch';
end;//Tkw_FormUserType_astPharmPublishSearch.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_astPharmPublishSearchCaption.Init;
 {* ������������� str_astPharmPublishSearchCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_astPharmPublishSearch.RegisterInEngine;
 {* ����������� Tkw_FormUserType_astPharmPublishSearch }
{$IfEnd} // NOT Defined(NoScripts)

end.
