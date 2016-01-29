unit SynchroViewUserTypes_svSynchroView_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/SynchroViewUserTypes_svSynchroView_UserType.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Base Operations::View::Base Forms::SynchroViewUserTypes::svSynchroView
//
// ���������� ��������
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
   { ��������� ��� ���� ����� svSynchroView }
  svSynchroViewName = 'svSynchroView';
   { ��������� ������������� ����������������� ���� "���������� ��������" }
  svSynchroView = TvcmUserType(0);
   { ���������� �������� }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_svSynchroView = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� svSynchroView }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_svSynchroView
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_svSynchroView

class function Tkw_FormUserType_svSynchroView.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::svSynchroView';
end;//Tkw_FormUserType_svSynchroView.GetWordNameForRegister

function Tkw_FormUserType_svSynchroView.GetInteger: Integer;
 {-}
begin
 Result := svSynchroView;
end;//Tkw_FormUserType_svSynchroView.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_svSynchroView
 Tkw_FormUserType_svSynchroView.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.