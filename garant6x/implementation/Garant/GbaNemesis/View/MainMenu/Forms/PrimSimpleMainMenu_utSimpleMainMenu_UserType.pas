unit PrimSimpleMainMenu_utSimpleMainMenu_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/MainMenu/Forms/PrimSimpleMainMenu_utSimpleMainMenu_UserType.pas"
// �����: 29.12.2008 17:43
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 ������������ ��������::MainMenu::View::MainMenu::PrimSimpleMainMenu::utSimpleMainMenu
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
   { ��������� ��� ���� ����� utSimpleMainMenu }
  utSimpleMainMenuName = 'utSimpleMainMenu';
   { ��������� ������������� ����������������� ���� "�������� ����" }
  utSimpleMainMenu = TvcmUserType(0);
   { �������� ���� }

type
  Tkw_FormUserType_utSimpleMainMenu = class(TtfwInteger)
   {* ����� ������� ��� ���� ����� utSimpleMainMenu }
  protected
  // overridden protected methods
    {$If not defined(NoScripts)}
   function GetInteger: Integer; override;
    {$IfEnd} //not NoScripts
  end;//Tkw_FormUserType_utSimpleMainMenu
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
// start class Tkw_FormUserType_utSimpleMainMenu

{$If not defined(NoScripts)}
function Tkw_FormUserType_utSimpleMainMenu.GetInteger: Integer;
 {-}
begin
 Result := utSimpleMainMenu;
end;//Tkw_FormUserType_utSimpleMainMenu.GetInteger
{$IfEnd} //not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
// ����������� Tkw_FormUserType_utSimpleMainMenu
 Tkw_FormUserType_utSimpleMainMenu.Register('���_�����::utSimpleMainMenu');
{$IfEnd} //not Admin AND not Monitorings

end.