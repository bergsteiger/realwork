unit PrimMainMenuNew_utMainMenuNew_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/MainMenu/Forms/PrimMainMenuNew_utMainMenuNew_UserType.pas"
// �����: 29.12.2008 17:43
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 ������������ ��������::MainMenu::View::MainMenu::PrimMainMenuNew::utMainMenuNew
//
// �������� ����
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
   { ��������� ��� ���� ����� utMainMenuNew }
  utMainMenuNewName = 'utMainMenuNew';
   { ��������� ������������� ����������������� ���� "�������� ����" }
  utMainMenuNew = TvcmUserType(0);
   { �������� ���� }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_utMainMenuNew = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� utMainMenuNew }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_utMainMenuNew
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_utMainMenuNew

class function Tkw_FormUserType_utMainMenuNew.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::utMainMenuNew';
end;//Tkw_FormUserType_utMainMenuNew.GetWordNameForRegister

function Tkw_FormUserType_utMainMenuNew.GetInteger: Integer;
 {-}
begin
 Result := utMainMenuNew;
end;//Tkw_FormUserType_utMainMenuNew.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_utMainMenuNew
 Tkw_FormUserType_utMainMenuNew.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.