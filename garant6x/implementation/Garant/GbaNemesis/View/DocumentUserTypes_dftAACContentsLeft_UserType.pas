unit DocumentUserTypes_dftAACContentsLeft_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/DocumentUserTypes_dftAACContentsLeft_UserType.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Base Operations::View::Base Forms::DocumentUserTypes::dftAACContentsLeft
//
// ����� ����� ���������� ������������ �������
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
  DocumentUserTypes_dftAACRight_UserType
  ;

const
   { ��������� ��� ���� ����� dftAACContentsLeft }
  dftAACContentsLeftName = 'dftAACContentsLeft';
   { ��������� ������������� ����������������� ���� "����� ����� ���������� ������������ �������" }
  dftAACContentsLeft = TvcmUserType(dftAACRight + 1);
   { ����� ����� ���������� ������������ ������� }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_dftAACContentsLeft = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� dftAACContentsLeft }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_dftAACContentsLeft
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_dftAACContentsLeft

class function Tkw_FormUserType_dftAACContentsLeft.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::dftAACContentsLeft';
end;//Tkw_FormUserType_dftAACContentsLeft.GetWordNameForRegister

function Tkw_FormUserType_dftAACContentsLeft.GetInteger: Integer;
 {-}
begin
 Result := dftAACContentsLeft;
end;//Tkw_FormUserType_dftAACContentsLeft.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_dftAACContentsLeft
 Tkw_FormUserType_dftAACContentsLeft.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.