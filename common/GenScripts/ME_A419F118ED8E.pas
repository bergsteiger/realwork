unit TextLoad_ut_TextLoad_UserType;
 {* ����� ��� �������� ��������� }

// ������: "w:\common\components\gui\Garant\Daily\Forms\TextLoad_ut_TextLoad_UserType.pas"
// ���������: "UserType"

{$Include sdotDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmUserControls
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* ��������� ��� ���� ����� ut_TextLoad }
 ut_TextLoadName = 'ut_TextLoad';
  {* ��������� ������������� ����������������� ���� "����� ��� �������� ���������" }
 ut_TextLoad = TvcmUserType(0);
  {* ����� ��� �������� ��������� }
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

implementation

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_TextLoad = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� ut_TextLoad }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_ut_TextLoad
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_ut_TextLoad.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::ut_TextLoad';
end;//Tkw_FormUserType_ut_TextLoad.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_ut_TextLoad.GetInteger: Integer;
begin
 Result := ut_TextLoad;
end;//Tkw_FormUserType_ut_TextLoad.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_TextLoad.RegisterInEngine;
 {* ����������� Tkw_FormUserType_ut_TextLoad }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

end.
