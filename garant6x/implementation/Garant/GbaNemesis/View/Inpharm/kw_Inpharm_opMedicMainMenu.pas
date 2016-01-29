unit kw_Inpharm_opMedicMainMenu;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Inpharm/kw_Inpharm_opMedicMainMenu.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> F1 Встроенные продукты::Inpharm::View::Inpharm::Tkw_Inpharm_opMedicMainMenu
//
// Слово словаря для вызова операции модуля Inpharm.MedicMainMenu$Op (Инфарм Основное меню ИнФарм)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

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
  {* Слово словаря для вызова операции модуля Inpharm.MedicMainMenu$Op (Инфарм Основное меню ИнФарм) }
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
 Result := 'моп::Инфарм_Основное_меню_ИнФарм';
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
// Регистрация Tkw_Inpharm_opMedicMainMenu
 Tkw_Inpharm_opMedicMainMenu.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.