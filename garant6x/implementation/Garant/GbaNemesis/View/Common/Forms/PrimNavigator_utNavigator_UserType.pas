unit PrimNavigator_utNavigator_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Common/Forms/PrimNavigator_utNavigator_UserType.pas"
// �����: 02.11.2009 16:45
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Common::View::Common::PrimNavigator::utNavigator
//
// ����
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
   { ��������� ��� ���� ����� utNavigator }
  utNavigatorName = 'utNavigator';
   { ��������� ������������� ����������������� ���� "����" }
  utNavigator = TvcmUserType(0);
   { ���� }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_utNavigator = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� utNavigator }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_utNavigator
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_utNavigator

class function Tkw_FormUserType_utNavigator.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::utNavigator';
end;//Tkw_FormUserType_utNavigator.GetWordNameForRegister

function Tkw_FormUserType_utNavigator.GetInteger: Integer;
 {-}
begin
 Result := utNavigator;
end;//Tkw_FormUserType_utNavigator.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_utNavigator
 Tkw_FormUserType_utNavigator.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.