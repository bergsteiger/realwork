unit Main_ut_Main_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/NewGen/Main_ut_Main_UserType.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> MDProcess$NewGen$Interface::NewGen::NewGen::Main::ut_Main
//
// �� ����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\NewGen\ngDefine.inc}

interface

{$If defined(NewGen)}
uses
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { ��������� ��� ���� ����� ut_Main }
  ut_MainName = 'ut_Main';
   { ��������� ������������� ����������������� ���� "�� ����" }
  ut_Main = TvcmUserType(0);
   { �� ���� }
{$IfEnd} //NewGen

implementation

{$If defined(NewGen)}
{$If defined(NewGen) AND not defined(NoScripts)}
type
  Tkw_FormUserType_ut_Main = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� ut_Main }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_ut_Main
{$IfEnd} //NewGen AND not NoScripts

{$If defined(NewGen) AND not defined(NoScripts)}

// start class Tkw_FormUserType_ut_Main

class function Tkw_FormUserType_ut_Main.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::ut_Main';
end;//Tkw_FormUserType_ut_Main.GetWordNameForRegister

function Tkw_FormUserType_ut_Main.GetInteger: Integer;
 {-}
begin
 Result := ut_Main;
end;//Tkw_FormUserType_ut_Main.GetInteger

{$IfEnd} //NewGen AND not NoScripts
{$IfEnd} //NewGen

initialization
{$If defined(NewGen) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_ut_Main
 Tkw_FormUserType_ut_Main.RegisterInEngine;
{$IfEnd} //NewGen AND not NoScripts

end.