unit DefineSearchDate_ut_DefineSearchDate_UserType;
 {* ���� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\DefineSearchDate_ut_DefineSearchDate_UserType.pas"
// ���������: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
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
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_DefineSearchDate = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� ut_DefineSearchDate }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_ut_DefineSearchDate
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_ut_DefineSearchDate.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::ut_DefineSearchDate';
end;//Tkw_FormUserType_ut_DefineSearchDate.GetWordNameForRegister

function Tkw_FormUserType_ut_DefineSearchDate.GetInteger: Integer;
begin
 Result := ut_DefineSearchDate;
end;//Tkw_FormUserType_ut_DefineSearchDate.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_DefineSearchDate.RegisterInEngine;
 {* ����������� Tkw_FormUserType_ut_DefineSearchDate }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
