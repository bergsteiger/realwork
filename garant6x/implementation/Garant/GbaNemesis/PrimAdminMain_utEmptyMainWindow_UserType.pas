unit PrimAdminMain_utEmptyMainWindow_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/PrimAdminMain_utEmptyMainWindow_UserType.pas"
// �����: 07.09.2009 18:30
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 �������������::Admin$Shell::AdminApp::PrimAdminMain::utEmptyMainWindow
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

{$If defined(Admin)}
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
   { ��������� ��� ���� ����� utEmptyMainWindow }
  utEmptyMainWindowName = 'utEmptyMainWindow';
   { ��������� ������������� ����������������� ���� "������� ����" }
  utEmptyMainWindow = TvcmUserType(0);
   { ������� ���� }
{$IfEnd} //Admin

implementation

{$If defined(Admin)}
{$If defined(Admin) AND not defined(NoScripts)}
type
  Tkw_FormUserType_utEmptyMainWindow = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� utEmptyMainWindow }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_utEmptyMainWindow
{$IfEnd} //Admin AND not NoScripts

{$If defined(Admin) AND not defined(NoScripts)}

// start class Tkw_FormUserType_utEmptyMainWindow

class function Tkw_FormUserType_utEmptyMainWindow.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::utEmptyMainWindow';
end;//Tkw_FormUserType_utEmptyMainWindow.GetWordNameForRegister

function Tkw_FormUserType_utEmptyMainWindow.GetInteger: Integer;
 {-}
begin
 Result := utEmptyMainWindow;
end;//Tkw_FormUserType_utEmptyMainWindow.GetInteger

{$IfEnd} //Admin AND not NoScripts
{$IfEnd} //Admin

initialization
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_utEmptyMainWindow
 Tkw_FormUserType_utEmptyMainWindow.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts

end.