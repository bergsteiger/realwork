unit ListUserTypes_lftRToPart_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/ListUserTypes_lftRToPart_UserType.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Base Operations::View::Base Forms::ListUserTypes::lftRToPart
//
// ������ �� ���������
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
  ListUserTypes_lftRespondent_UserType,
  ListUserTypes_lftDrugInternationalNameSynonymsSynchroForm_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { ��������� ��� ���� ����� lftRToPart }
  lftRToPartName = 'lftRToPart';
   { ��������� ������������� ����������������� ���� "������ �� ���������" }
  lftRToPart = TvcmUserType(lftDrugInternationalNameSynonymsSynchroForm + 1);
   { ������ �� ��������� }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_lftRToPart = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� lftRToPart }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_lftRToPart
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_lftRToPart

class function Tkw_FormUserType_lftRToPart.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::lftRToPart';
end;//Tkw_FormUserType_lftRToPart.GetWordNameForRegister

function Tkw_FormUserType_lftRToPart.GetInteger: Integer;
 {-}
begin
 Result := lftRToPart;
end;//Tkw_FormUserType_lftRToPart.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_lftRToPart
 Tkw_FormUserType_lftRToPart.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.