unit DocumentUserTypes_dftAutoreferat_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/DocumentUserTypes_dftAutoreferat_UserType.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Base Operations::View::Base Forms::DocumentUserTypes::dftAutoreferat
//
// �����. ��� ��������� �����
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
  DocumentUserTypes_dftMedDictEntry_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { ��������� ��� ���� ����� dftAutoreferat }
  dftAutoreferatName = 'dftAutoreferat';
   { ��������� ������������� ����������������� ���� "�����. ��� ��������� �����" }
  dftAutoreferat = TvcmUserType(dftMedDictEntry + 1);
   { �����. ��� ��������� ����� }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_dftAutoreferat = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� dftAutoreferat }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_dftAutoreferat
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_dftAutoreferat

class function Tkw_FormUserType_dftAutoreferat.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::dftAutoreferat';
end;//Tkw_FormUserType_dftAutoreferat.GetWordNameForRegister

function Tkw_FormUserType_dftAutoreferat.GetInteger: Integer;
 {-}
begin
 Result := dftAutoreferat;
end;//Tkw_FormUserType_dftAutoreferat.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_dftAutoreferat
 Tkw_FormUserType_dftAutoreferat.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.