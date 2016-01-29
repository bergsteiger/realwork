unit AttributesUserTypes_fAttributeSynchroView_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/AttributesUserTypes_fAttributeSynchroView_UserType.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Base Operations::View::Base Forms::AttributesUserTypes::fAttributeSynchroView
//
// ���������� � ��������� (���������� ��������)
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
  AttributesUserTypes_fDocAttribute_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { ��������� ��� ���� ����� fAttributeSynchroView }
  fAttributeSynchroViewName = 'fAttributeSynchroView';
   { ��������� ������������� ����������������� ���� "���������� � ��������� (���������� ��������)" }
  fAttributeSynchroView = TvcmUserType(fDocAttribute + 1);
   { ���������� � ��������� (���������� ��������) }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_fAttributeSynchroView = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� fAttributeSynchroView }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_fAttributeSynchroView
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_fAttributeSynchroView

class function Tkw_FormUserType_fAttributeSynchroView.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::fAttributeSynchroView';
end;//Tkw_FormUserType_fAttributeSynchroView.GetWordNameForRegister

function Tkw_FormUserType_fAttributeSynchroView.GetInteger: Integer;
 {-}
begin
 Result := fAttributeSynchroView;
end;//Tkw_FormUserType_fAttributeSynchroView.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_fAttributeSynchroView
 Tkw_FormUserType_fAttributeSynchroView.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.