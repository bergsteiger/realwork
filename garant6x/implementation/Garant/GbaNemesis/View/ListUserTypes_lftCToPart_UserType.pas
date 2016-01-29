unit ListUserTypes_lftCToPart_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/ListUserTypes_lftCToPart_UserType.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Base Operations::View::Base Forms::ListUserTypes::lftCToPart
//
// ������ �� ��������
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
  ListUserTypes_lftSynchroView_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { ��������� ��� ���� ����� lftCToPart }
  lftCToPartName = 'lftCToPart';
   { ��������� ������������� ����������������� ���� "������ �� ��������" }
  lftCToPart = TvcmUserType(lftSynchroView + 1);
   { ������ �� �������� }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_lftCToPart = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� lftCToPart }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_lftCToPart
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_lftCToPart

class function Tkw_FormUserType_lftCToPart.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::lftCToPart';
end;//Tkw_FormUserType_lftCToPart.GetWordNameForRegister

function Tkw_FormUserType_lftCToPart.GetInteger: Integer;
 {-}
begin
 Result := lftCToPart;
end;//Tkw_FormUserType_lftCToPart.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_lftCToPart
 Tkw_FormUserType_lftCToPart.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.