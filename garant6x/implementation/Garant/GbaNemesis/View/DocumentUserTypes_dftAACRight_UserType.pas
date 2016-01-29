unit DocumentUserTypes_dftAACRight_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/DocumentUserTypes_dftAACRight_UserType.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Base Operations::View::Base Forms::DocumentUserTypes::dftAACRight
//
// ������ ����� ������������ �������
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
  ,
  DocumentUserTypes_dftAACLeft_UserType
  ;

const
   { ��������� ��� ���� ����� dftAACRight }
  dftAACRightName = 'dftAACRight';
   { ��������� ������������� ����������������� ���� "������ ����� ������������ �������" }
  dftAACRight = TvcmUserType(dftAACLeft + 1);
   { ������ ����� ������������ ������� }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_dftAACRight = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� dftAACRight }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_dftAACRight
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_dftAACRight

class function Tkw_FormUserType_dftAACRight.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::dftAACRight';
end;//Tkw_FormUserType_dftAACRight.GetWordNameForRegister

function Tkw_FormUserType_dftAACRight.GetInteger: Integer;
 {-}
begin
 Result := dftAACRight;
end;//Tkw_FormUserType_dftAACRight.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_dftAACRight
 Tkw_FormUserType_dftAACRight.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.