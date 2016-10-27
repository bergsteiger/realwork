unit PrimSaveLoadUserTypes_slqtFilters_UserType;
 {* �������� �������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimSaveLoadUserTypes_slqtFilters_UserType.pas"
// ���������: "UserType"
// ������� ������: "slqtFilters" MUID: (4BD5BBC80391)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , PrimSaveLoadUserTypes_slqtPublishSource_UserType
 , l3StringIDEx
;

const
 {* ������������ ������ slqtFiltersLocalConstants }
 str_slqtFiltersCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'slqtFiltersCaption'; rValue : '�������� ��������');
  {* ��������� ����������������� ���� "�������� ��������" }
 {* ��������� ��� ���� ����� slqtFilters }
 slqtFiltersName = 'slqtFilters';
  {* ��������� ������������� ����������������� ���� "�������� ��������" }
 slqtFilters = TvcmUserType(slqtPublishSource + 1);
  {* �������� �������� }
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
 Tkw_FormUserType_slqtFilters = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� slqtFilters }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_slqtFilters
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_slqtFilters.GetInteger: Integer;
begin
 Result := slqtFilters;
end;//Tkw_FormUserType_slqtFilters.GetInteger

class function Tkw_FormUserType_slqtFilters.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::slqtFilters';
end;//Tkw_FormUserType_slqtFilters.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_slqtFiltersCaption.Init;
 {* ������������� str_slqtFiltersCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_slqtFilters.RegisterInEngine;
 {* ����������� Tkw_FormUserType_slqtFilters }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.
