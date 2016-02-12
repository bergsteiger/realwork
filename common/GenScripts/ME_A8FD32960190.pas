unit Main_ut_Main_UserType;
 {* �� ���� }

// ������: "w:\MDProcess\NewGen\Main_ut_Main_UserType.pas"
// ���������: "UserType"

{$Include ngDefine.inc}

interface

{$If Defined(NewGen)}
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
 {* ��������� ��� ���� ����� ut_Main }
 ut_MainName = 'ut_Main';
  {* ��������� ������������� ����������������� ���� "�� ����" }
 ut_Main = TvcmUserType(0);
  {* �� ���� }
{$IfEnd} // Defined(NewGen)

implementation

{$If Defined(NewGen)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_Main = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� ut_Main }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_ut_Main
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_ut_Main.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::ut_Main';
end;//Tkw_FormUserType_ut_Main.GetWordNameForRegister

function Tkw_FormUserType_ut_Main.GetInteger: Integer;
begin
 Result := ut_Main;
end;//Tkw_FormUserType_ut_Main.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_Main.RegisterInEngine;
 {* ����������� Tkw_FormUserType_ut_Main }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(NewGen)

end.
