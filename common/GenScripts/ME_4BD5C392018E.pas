unit PrimQueryCard_utqcInpharmSearch_UserType;
 {* ����� ������������� ������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimQueryCard_utqcInpharmSearch_UserType.pas"
// ���������: "UserType"
// ������� ������: "utqcInpharmSearch" MUID: (4BD5C392018E)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , PrimQueryCard_utqcSendConsultation_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
;

const
 {* ������������ ������ utqcInpharmSearchLocalConstants }
 str_utqcInpharmSearchCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utqcInpharmSearchCaption'; rValue : '����� ������������� �������');
  {* ��������� ����������������� ���� "����� ������������� �������" }
 {* ��������� ��� ���� ����� utqcInpharmSearch }
 utqcInpharmSearchName = 'utqcInpharmSearch';
  {* ��������� ������������� ����������������� ���� "����� ������������� �������" }
 utqcInpharmSearch = TvcmUserType(utqcSendConsultation + 1);
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
 Tkw_FormUserType_utqcInpharmSearch = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� utqcInpharmSearch }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_utqcInpharmSearch
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_utqcInpharmSearch.GetInteger: Integer;
begin
 Result := utqcInpharmSearch;
end;//Tkw_FormUserType_utqcInpharmSearch.GetInteger

class function Tkw_FormUserType_utqcInpharmSearch.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::utqcInpharmSearch';
end;//Tkw_FormUserType_utqcInpharmSearch.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_utqcInpharmSearchCaption.Init;
 {* ������������� str_utqcInpharmSearchCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utqcInpharmSearch.RegisterInEngine;
 {* ����������� Tkw_FormUserType_utqcInpharmSearch }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.
