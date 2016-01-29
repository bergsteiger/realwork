unit BaloonWarningUserTypes_remListFiltered_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/BaloonWarningUserTypes_remListFiltered_UserType.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Base Operations::View::Base Forms::BaloonWarningUserTypes::remListFiltered
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
  BaloonWarningUserTypes_remListModified_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  BaloonWarningUserTypes_Fake_UserType
  ;

const
   { ��������� ��� ���� ����� remListFiltered }
  remListFilteredName = 'remListFiltered';
   { ��������� ������������� ����������������� ���� "" }
  remListFiltered = TvcmUserType(remListModified + 1);
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_remListFiltered = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� remListFiltered }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_remListFiltered
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_remListFiltered

class function Tkw_FormUserType_remListFiltered.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::remListFiltered';
end;//Tkw_FormUserType_remListFiltered.GetWordNameForRegister

function Tkw_FormUserType_remListFiltered.GetInteger: Integer;
 {-}
begin
 Result := remListFiltered;
end;//Tkw_FormUserType_remListFiltered.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_remListFiltered
 Tkw_FormUserType_remListFiltered.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.