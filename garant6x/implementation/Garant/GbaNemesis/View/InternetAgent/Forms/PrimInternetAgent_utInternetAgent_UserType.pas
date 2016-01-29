unit PrimInternetAgent_utInternetAgent_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/InternetAgent/Forms/PrimInternetAgent_utInternetAgent_UserType.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 ���������� ��������::InternetAgent::View::InternetAgent::PrimInternetAgent::utInternetAgent
//
// ������� ������
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
   { ��������� ��� ���� ����� utInternetAgent }
  utInternetAgentName = 'utInternetAgent';
   { ��������� ������������� ����������������� ���� "������� ������" }
  utInternetAgent = TvcmUserType(0);
   { ������� ������ }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_utInternetAgent = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� utInternetAgent }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_utInternetAgent
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_utInternetAgent

class function Tkw_FormUserType_utInternetAgent.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::utInternetAgent';
end;//Tkw_FormUserType_utInternetAgent.GetWordNameForRegister

function Tkw_FormUserType_utInternetAgent.GetInteger: Integer;
 {-}
begin
 Result := utInternetAgent;
end;//Tkw_FormUserType_utInternetAgent.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_utInternetAgent
 Tkw_FormUserType_utInternetAgent.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.