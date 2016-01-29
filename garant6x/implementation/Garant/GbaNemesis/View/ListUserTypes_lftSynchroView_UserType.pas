unit ListUserTypes_lftSynchroView_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/ListUserTypes_lftSynchroView_UserType.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Base Operations::View::Base Forms::ListUserTypes::lftSynchroView
//
// ���������� �������� (������ �� ���������, ������ �� ��������)
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
  ,
  ListUserTypes_lftCorrespondent_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { ��������� ��� ���� ����� lftSynchroView }
  lftSynchroViewName = 'lftSynchroView';
   { ��������� ������������� ����������������� ���� "���������� �������� (������ �� ���������, ������ �� ��������)" }
  lftSynchroView = TvcmUserType(lftCorrespondent + 1);
   { ���������� �������� (������ �� ���������, ������ �� ��������) }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_lftSynchroView = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� lftSynchroView }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_lftSynchroView
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_lftSynchroView

class function Tkw_FormUserType_lftSynchroView.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::lftSynchroView';
end;//Tkw_FormUserType_lftSynchroView.GetWordNameForRegister

function Tkw_FormUserType_lftSynchroView.GetInteger: Integer;
 {-}
begin
 Result := lftSynchroView;
end;//Tkw_FormUserType_lftSynchroView.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_lftSynchroView
 Tkw_FormUserType_lftSynchroView.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.