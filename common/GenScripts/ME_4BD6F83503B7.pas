unit PrimAttributeSelect_utSingleSearch_UserType;
 {* ��������� ����� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\LiteSearch\Forms\PrimAttributeSelect_utSingleSearch_UserType.pas"
// ���������: "UserType"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , PrimAttributeSelect_utAttributeSelect_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 {* ��������� ��� ���� ����� utSingleSearch }
 utSingleSearchName = 'utSingleSearch';
  {* ��������� ������������� ����������������� ���� "��������� �����" }
 utSingleSearch = TvcmUserType(utAttributeSelect + 1);
  {* ��������� ����� }

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utSingleSearch = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� utSingleSearch }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_utSingleSearch
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_utSingleSearch.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::utSingleSearch';
end;//Tkw_FormUserType_utSingleSearch.GetWordNameForRegister

function Tkw_FormUserType_utSingleSearch.GetInteger: Integer;
begin
 Result := utSingleSearch;
end;//Tkw_FormUserType_utSingleSearch.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utSingleSearch.RegisterInEngine;
 {* ����������� Tkw_FormUserType_utSingleSearch }
{$IfEnd} // NOT Defined(NoScripts)

end.
