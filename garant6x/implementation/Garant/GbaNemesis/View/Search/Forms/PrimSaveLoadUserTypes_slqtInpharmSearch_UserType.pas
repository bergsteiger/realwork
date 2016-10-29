unit PrimSaveLoadUserTypes_slqtInpharmSearch_UserType;
 {* ����� ������������� ������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimSaveLoadUserTypes_slqtInpharmSearch_UserType.pas"
// ���������: "UserType"
// ������� ������: "slqtInpharmSearch" MUID: (4BD5BC86008F)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , PrimSaveLoadUserTypes_slqtConsult_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
;

const
 {* ������������ ������ slqtInpharmSearchLocalConstants }
 str_slqtInpharmSearchCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'slqtInpharmSearchCaption'; rValue : '����� ������������� �������');
  {* ��������� ����������������� ���� "����� ������������� �������" }
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
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_slqtInpharmSearch = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� slqtInpharmSearch }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_slqtInpharmSearch
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_slqtInpharmSearch.GetInteger: Integer;
begin
 Result := slqtInpharmSearch;
end;//Tkw_FormUserType_slqtInpharmSearch.GetInteger

class function Tkw_FormUserType_slqtInpharmSearch.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::slqtInpharmSearch';
end;//Tkw_FormUserType_slqtInpharmSearch.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_slqtInpharmSearchCaption.Init;
 {* ������������� str_slqtInpharmSearchCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_slqtInpharmSearch.RegisterInEngine;
 {* ����������� Tkw_FormUserType_slqtInpharmSearch }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.
