unit NemesisMain_utMainWindow_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/NemesisMain_utMainWindow_UserType.pas"
// �����: 29.12.2008 16:25
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 �������� ��� �����������::F1 Without Usecases::View::PrimNemesis::NemesisMain::utMainWindow
//
// ������� ����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
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
   { ��������� ��� ���� ����� utMainWindow }
  utMainWindowName = 'utMainWindow';
   { ��������� ������������� ����������������� ���� "������� ����" }
  utMainWindow = TvcmUserType(0);
   { ������� ���� }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_utMainWindow = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� utMainWindow }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_utMainWindow
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_utMainWindow

class function Tkw_FormUserType_utMainWindow.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::utMainWindow';
end;//Tkw_FormUserType_utMainWindow.GetWordNameForRegister

function Tkw_FormUserType_utMainWindow.GetInteger: Integer;
 {-}
begin
 Result := utMainWindow;
end;//Tkw_FormUserType_utMainWindow.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_utMainWindow
 Tkw_FormUserType_utMainWindow.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.