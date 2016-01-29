unit DocumentUserTypes_dftAACLeft_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/DocumentUserTypes_dftAACLeft_UserType.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Base Operations::View::Base Forms::DocumentUserTypes::dftAACLeft
//
// ����� ����� ������������ �������
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
  DocumentUserTypes_dftDrugSynchroView_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { ��������� ��� ���� ����� dftAACLeft }
  dftAACLeftName = 'dftAACLeft';
   { ��������� ������������� ����������������� ���� "����� ����� ������������ �������" }
  dftAACLeft = TvcmUserType(dftDrugSynchroView + 1);
   { ����� ����� ������������ ������� }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_dftAACLeft = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� dftAACLeft }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_dftAACLeft
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_dftAACLeft

class function Tkw_FormUserType_dftAACLeft.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::dftAACLeft';
end;//Tkw_FormUserType_dftAACLeft.GetWordNameForRegister

function Tkw_FormUserType_dftAACLeft.GetInteger: Integer;
 {-}
begin
 Result := dftAACLeft;
end;//Tkw_FormUserType_dftAACLeft.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_dftAACLeft
 Tkw_FormUserType_dftAACLeft.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.