unit ListUserTypes_lftUserCR1_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/ListUserTypes_lftUserCR1_UserType.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Base Operations::View::Base Forms::ListUserTypes::lftUserCR1
//
// ������������� ������� ��������� ���������� 1
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
  ListUserTypes_lftCToPart_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { ��������� ��� ���� ����� lftUserCR1 }
  lftUserCR1Name = 'lftUserCR1';
   { ��������� ������������� ����������������� ���� "������������� ������� ��������� ���������� 1" }
  lftUserCR1 = TvcmUserType(lftCToPart + 1);
   { ������������� ������� ��������� ���������� 1 }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_lftUserCR1 = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� lftUserCR1 }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_lftUserCR1
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_lftUserCR1

class function Tkw_FormUserType_lftUserCR1.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::lftUserCR1';
end;//Tkw_FormUserType_lftUserCR1.GetWordNameForRegister

function Tkw_FormUserType_lftUserCR1.GetInteger: Integer;
 {-}
begin
 Result := lftUserCR1;
end;//Tkw_FormUserType_lftUserCR1.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_lftUserCR1
 Tkw_FormUserType_lftUserCR1.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.