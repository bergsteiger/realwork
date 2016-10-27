unit FiltersUserTypes_utFilters_UserType;
 {* ������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\FiltersUserTypes_utFilters_UserType.pas"
// ���������: "UserType"
// ������� ������: "utFilters" MUID: (4BD729B70260)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* ������������ ������ utFiltersLocalConstants }
 str_utFiltersCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utFiltersCaption'; rValue : '�������');
  {* ��������� ����������������� ���� "�������" }
 str_utFiltersSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utFiltersSettingsCaption'; rValue : '������� (�������)');
  {* ��������� ����������������� ���� "�������" ��� ��������� ������� ������������ }
 {* ��������� ��� ���� ����� utFilters }
 utFiltersName = 'utFilters';
  {* ��������� ������������� ����������������� ���� "�������" }
 utFilters = TvcmUserType(0);
  {* ������� }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_utFilters = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� utFilters }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_utFilters
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_utFilters.GetInteger: Integer;
begin
 Result := utFilters;
end;//Tkw_FormUserType_utFilters.GetInteger

class function Tkw_FormUserType_utFilters.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::utFilters';
end;//Tkw_FormUserType_utFilters.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_utFiltersCaption.Init;
 {* ������������� str_utFiltersCaption }
 str_utFiltersSettingsCaption.Init;
 {* ������������� str_utFiltersSettingsCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utFilters.RegisterInEngine;
 {* ����������� Tkw_FormUserType_utFilters }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
