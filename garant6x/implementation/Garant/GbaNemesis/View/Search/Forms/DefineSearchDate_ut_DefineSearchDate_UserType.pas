unit DefineSearchDate_ut_DefineSearchDate_UserType;
 {* ���� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\DefineSearchDate_ut_DefineSearchDate_UserType.pas"
// ���������: "UserType"
// ������� ������: "ut_DefineSearchDate" MUID: (7C299D84FEC0)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* ������������ ������ ut_DefineSearchDateLocalConstants }
 str_ut_DefineSearchDateCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_DefineSearchDateCaption'; rValue : '����');
  {* ��������� ����������������� ���� "����" }
 {* ��������� ��� ���� ����� ut_DefineSearchDate }
 ut_DefineSearchDateName = 'ut_DefineSearchDate';
  {* ��������� ������������� ����������������� ���� "����" }
 ut_DefineSearchDate = TvcmUserType(0);
  {* ���� }
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
 Tkw_FormUserType_ut_DefineSearchDate = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� ut_DefineSearchDate }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_ut_DefineSearchDate
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_ut_DefineSearchDate.GetInteger: Integer;
begin
 Result := ut_DefineSearchDate;
end;//Tkw_FormUserType_ut_DefineSearchDate.GetInteger

class function Tkw_FormUserType_ut_DefineSearchDate.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::ut_DefineSearchDate';
end;//Tkw_FormUserType_ut_DefineSearchDate.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_ut_DefineSearchDateCaption.Init;
 {* ������������� str_ut_DefineSearchDateCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_DefineSearchDate.RegisterInEngine;
 {* ����������� Tkw_FormUserType_ut_DefineSearchDate }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
