unit DocumentWithFlashUserTypes_dwftMain_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/DocumentWithFlashUserTypes_dwftMain_UserType.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Base Operations::View::Base Forms::DocumentWithFlashUserTypes::dwftMain
//
// �����
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
   { ��������� ��� ���� ����� dwftMain }
  dwftMainName = 'dwftMain';
   { ��������� ������������� ����������������� ���� "�����" }
  dwftMain = TvcmUserType(0);
   { ����� }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_dwftMain = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� dwftMain }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_dwftMain
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_dwftMain

class function Tkw_FormUserType_dwftMain.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::dwftMain';
end;//Tkw_FormUserType_dwftMain.GetWordNameForRegister

function Tkw_FormUserType_dwftMain.GetInteger: Integer;
 {-}
begin
 Result := dwftMain;
end;//Tkw_FormUserType_dwftMain.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_dwftMain
 Tkw_FormUserType_dwftMain.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.