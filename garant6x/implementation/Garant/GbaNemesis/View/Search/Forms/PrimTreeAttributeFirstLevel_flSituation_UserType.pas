unit PrimTreeAttributeFirstLevel_flSituation_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View$For F1 and Monitorings"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Search/Forms/PrimTreeAttributeFirstLevel_flSituation_UserType.pas"
// �����: 27.01.2009 11:33
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Common For Shell And Monitoring::Search::View$For F1 and Monitorings::Search$Presentation for F1 and Monitorings::PrimTreeAttributeFirstLevel::flSituation
//
// �������� ������� ������ (�������)
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin)}
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
   { ��������� ��� ���� ����� flSituation }
  flSituationName = 'flSituation';
   { ��������� ������������� ����������������� ���� "�������� ������� ������ (�������)" }
  flSituation = TvcmUserType(0);
   { �������� ������� ������ (�������) }
{$IfEnd} //not Admin

implementation

{$If not defined(Admin)}
{$If not defined(Admin) AND not defined(NoScripts)}
type
  Tkw_FormUserType_flSituation = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� flSituation }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_flSituation
{$IfEnd} //not Admin AND not NoScripts

{$If not defined(Admin) AND not defined(NoScripts)}

// start class Tkw_FormUserType_flSituation

class function Tkw_FormUserType_flSituation.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::flSituation';
end;//Tkw_FormUserType_flSituation.GetWordNameForRegister

function Tkw_FormUserType_flSituation.GetInteger: Integer;
 {-}
begin
 Result := flSituation;
end;//Tkw_FormUserType_flSituation.GetInteger

{$IfEnd} //not Admin AND not NoScripts
{$IfEnd} //not Admin

initialization
{$If not defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_flSituation
 Tkw_FormUserType_flSituation.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts

end.