unit DocumentUserTypes_dftAACContentsRight_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/DocumentUserTypes_dftAACContentsRight_UserType.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Base Operations::View::Base Forms::DocumentUserTypes::dftAACContentsRight
//
// ������ ����� ���������� ������������ �������
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
  DocumentUserTypes_dftAACContentsLeft_UserType
  ;

const
   { ��������� ��� ���� ����� dftAACContentsRight }
  dftAACContentsRightName = 'dftAACContentsRight';
   { ��������� ������������� ����������������� ���� "������ ����� ���������� ������������ �������" }
  dftAACContentsRight = TvcmUserType(dftAACContentsLeft + 1);
   { ������ ����� ���������� ������������ ������� }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_dftAACContentsRight = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� dftAACContentsRight }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_dftAACContentsRight
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_dftAACContentsRight

class function Tkw_FormUserType_dftAACContentsRight.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::dftAACContentsRight';
end;//Tkw_FormUserType_dftAACContentsRight.GetWordNameForRegister

function Tkw_FormUserType_dftAACContentsRight.GetInteger: Integer;
 {-}
begin
 Result := dftAACContentsRight;
end;//Tkw_FormUserType_dftAACContentsRight.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_dftAACContentsRight
 Tkw_FormUserType_dftAACContentsRight.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.