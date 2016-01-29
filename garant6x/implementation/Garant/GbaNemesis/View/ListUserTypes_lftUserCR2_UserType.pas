unit ListUserTypes_lftUserCR2_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/ListUserTypes_lftUserCR2_UserType.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Base Operations::View::Base Forms::ListUserTypes::lftUserCR2
//
// ������������� ������� ��������� ���������� 2
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
  ListUserTypes_lftUserCR1_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { ��������� ��� ���� ����� lftUserCR2 }
  lftUserCR2Name = 'lftUserCR2';
   { ��������� ������������� ����������������� ���� "������������� ������� ��������� ���������� 2" }
  lftUserCR2 = TvcmUserType(lftUserCR1 + 1);
   { ������������� ������� ��������� ���������� 2 }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_lftUserCR2 = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� lftUserCR2 }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_lftUserCR2
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_lftUserCR2

class function Tkw_FormUserType_lftUserCR2.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::lftUserCR2';
end;//Tkw_FormUserType_lftUserCR2.GetWordNameForRegister

function Tkw_FormUserType_lftUserCR2.GetInteger: Integer;
 {-}
begin
 Result := lftUserCR2;
end;//Tkw_FormUserType_lftUserCR2.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_lftUserCR2
 Tkw_FormUserType_lftUserCR2.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.