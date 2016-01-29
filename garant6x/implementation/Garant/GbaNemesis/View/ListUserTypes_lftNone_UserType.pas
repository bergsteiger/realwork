unit ListUserTypes_lftNone_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/ListUserTypes_lftNone_UserType.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Base Operations::View::Base Forms::ListUserTypes::lftNone
//
// ������
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
   { ��������� ��� ���� ����� lftNone }
  lftNoneName = 'lftNone';
   { ��������� ������������� ����������������� ���� "������" }
  lftNone = TvcmUserType(0);
   { ������ }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_lftNone = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� lftNone }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_lftNone
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_lftNone

class function Tkw_FormUserType_lftNone.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::lftNone';
end;//Tkw_FormUserType_lftNone.GetWordNameForRegister

function Tkw_FormUserType_lftNone.GetInteger: Integer;
 {-}
begin
 Result := lftNone;
end;//Tkw_FormUserType_lftNone.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_lftNone
 Tkw_FormUserType_lftNone.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.