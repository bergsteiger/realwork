unit kw_Inpharm_opMedicMainMenu;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Inpharm/kw_Inpharm_opMedicMainMenu.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> F1 ���������� ��������::Inpharm::View::Inpharm::Tkw_Inpharm_opMedicMainMenu
//
// ����� ������� ��� ������ �������� ������ Inpharm.MedicMainMenu$Op (������ �������� ���� ������)
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
 Tkw_Inpharm_opMedicMainMenu = {final scriptword} class(TtfwModuleOperationWord)
  {* ����� ������� ��� ������ �������� ������ Inpharm.MedicMainMenu$Op (������ �������� ���� ������) }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   {$If not defined(NoScripts) AND not defined(NoVCM)}
   class function GetModuleOperationCode: TvcmMOPID; override;
   {$IfEnd} //not NoScripts AND not NoVCM
 end;//Tkw_Inpharm_opMedicMainMenu
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_Inpharm_opMedicMainMenu

class function Tkw_Inpharm_opMedicMainMenu.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���::������_��������_����_������';
end;//Tkw_Inpharm_opMedicMainMenu.GetWordNameForRegister

{$If not defined(NoScripts) AND not defined(NoVCM)}
class function Tkw_Inpharm_opMedicMainMenu.GetModuleOperationCode: TvcmMOPID;
 {-}
begin
 Result := TdmStdRes.mod_opcode_Inpharm_MedicMainMenu;
end;//Tkw_Inpharm_opMedicMainMenu.GetModuleOperationCode
{$IfEnd} //not NoScripts AND not NoVCM

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_Inpharm_opMedicMainMenu
 Tkw_Inpharm_opMedicMainMenu.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.