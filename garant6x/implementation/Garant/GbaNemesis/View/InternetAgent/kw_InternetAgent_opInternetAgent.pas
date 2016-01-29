unit kw_InternetAgent_opInternetAgent;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/InternetAgent/kw_InternetAgent_opInternetAgent.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> F1 ���������� ��������::InternetAgent::View::InternetAgent::Tkw_InternetAgent_opInternetAgent
//
// ����� ������� ��� ������ �������� ������ InternetAgent.InternetAgent (��������-����� �������
// ������)
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
uses
  Classes
  {$If not defined(NoScripts) AND not defined(NoVCM)}
  ,
  tfwModuleOperationWord
  {$IfEnd} //not NoScripts AND not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmExternalInterfaces
  {$IfEnd} //not NoVCM
  
  ;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts


implementation

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
uses
  SysUtils
  {$If not defined(NoVCM)}
  ,
  StdRes
  {$IfEnd} //not NoVCM
  
  ;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
 Tkw_InternetAgent_opInternetAgent = {final scriptword} class(TtfwModuleOperationWord)
  {* ����� ������� ��� ������ �������� ������ InternetAgent.InternetAgent (��������-����� ������� ������) }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   {$If not defined(NoScripts) AND not defined(NoVCM)}
   class function GetModuleOperationCode: TvcmMOPID; override;
   {$IfEnd} //not NoScripts AND not NoVCM
 end;//Tkw_InternetAgent_opInternetAgent
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_InternetAgent_opInternetAgent

class function Tkw_InternetAgent_opInternetAgent.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���::��������-�����_�������_������';
end;//Tkw_InternetAgent_opInternetAgent.GetWordNameForRegister

{$If not defined(NoScripts) AND not defined(NoVCM)}
class function Tkw_InternetAgent_opInternetAgent.GetModuleOperationCode: TvcmMOPID;
 {-}
begin
 Result := TdmStdRes.mod_opcode_InternetAgent_InternetAgent;
end;//Tkw_InternetAgent_opInternetAgent.GetModuleOperationCode
{$IfEnd} //not NoScripts AND not NoVCM

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_InternetAgent_opInternetAgent
 Tkw_InternetAgent_opInternetAgent.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.