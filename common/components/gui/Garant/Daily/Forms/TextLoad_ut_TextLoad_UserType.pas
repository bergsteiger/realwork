unit TextLoad_ut_TextLoad_UserType;
 {* ����� ��� �������� ��������� }

// ������: "w:\common\components\gui\Garant\Daily\Forms\TextLoad_ut_TextLoad_UserType.pas"
// ���������: "UserType"
// ������� ������: "ut_TextLoad" MUID: (A419F118ED8E)

{$Include w:\common\components\gui\sdotDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmUserControls
 , l3StringIDEx
;

const
 {* ������������ ������ ut_TextLoadLocalConstants }
 str_ut_TextLoadCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_TextLoadCaption'; rValue : '����� ��� �������� ���������');
  {* ��������� ����������������� ���� "����� ��� �������� ���������" }
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
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_ut_TextLoad = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� ut_TextLoad }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_ut_TextLoad
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_ut_TextLoad.GetInteger: Integer;
begin
 Result := ut_TextLoad;
end;//Tkw_FormUserType_ut_TextLoad.GetInteger

class function Tkw_FormUserType_ut_TextLoad.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::ut_TextLoad';
end;//Tkw_FormUserType_ut_TextLoad.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_ut_TextLoadCaption.Init;
 {* ������������� str_ut_TextLoadCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_TextLoad.RegisterInEngine;
 {* ����������� Tkw_FormUserType_ut_TextLoad }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

end.
