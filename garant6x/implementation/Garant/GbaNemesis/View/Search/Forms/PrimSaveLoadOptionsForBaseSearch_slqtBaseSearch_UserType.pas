unit PrimSaveLoadOptionsForBaseSearch_slqtBaseSearch_UserType;
 {* ������� ����� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimSaveLoadOptionsForBaseSearch_slqtBaseSearch_UserType.pas"
// ���������: "UserType"
// ������� ������: "slqtBaseSearch" MUID: (4D7A26C701BE)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* ������������ ������ slqtBaseSearchLocalConstants }
 str_slqtBaseSearchCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'slqtBaseSearchCaption'; rValue : '������� �����');
  {* ��������� ����������������� ���� "������� �����" }
 {* ��������� ��� ���� ����� slqtBaseSearch }
 slqtBaseSearchName = 'slqtBaseSearch';
  {* ��������� ������������� ����������������� ���� "������� �����" }
 slqtBaseSearch = TvcmUserType(0);
  {* ������� ����� }
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
 Tkw_FormUserType_slqtBaseSearch = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� slqtBaseSearch }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_slqtBaseSearch
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_slqtBaseSearch.GetInteger: Integer;
begin
 Result := slqtBaseSearch;
end;//Tkw_FormUserType_slqtBaseSearch.GetInteger

class function Tkw_FormUserType_slqtBaseSearch.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::slqtBaseSearch';
end;//Tkw_FormUserType_slqtBaseSearch.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_slqtBaseSearchCaption.Init;
 {* ������������� str_slqtBaseSearchCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_slqtBaseSearch.RegisterInEngine;
 {* ����������� Tkw_FormUserType_slqtBaseSearch }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.
