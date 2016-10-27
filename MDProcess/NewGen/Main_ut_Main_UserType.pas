unit Main_ut_Main_UserType;
 {* �� ���� }

// ������: "w:\MDProcess\NewGen\Main_ut_Main_UserType.pas"
// ���������: "UserType"
// ������� ������: "ut_Main" MUID: (A8FD32960190)

{$Include w:\MDProcess\NewGen\ngDefine.inc}

interface

{$If Defined(NewGen)}
uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* ������������ ������ ut_MainLocalConstants }
 str_ut_MainCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_MainCaption'; rValue : '�� ����');
  {* ��������� ����������������� ���� "�� ����" }
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
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_ut_Main = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� ut_Main }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_ut_Main
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_ut_Main.GetInteger: Integer;
begin
 Result := ut_Main;
end;//Tkw_FormUserType_ut_Main.GetInteger

class function Tkw_FormUserType_ut_Main.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::ut_Main';
end;//Tkw_FormUserType_ut_Main.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_ut_MainCaption.Init;
 {* ������������� str_ut_MainCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_Main.RegisterInEngine;
 {* ����������� Tkw_FormUserType_ut_Main }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(NewGen)

end.
