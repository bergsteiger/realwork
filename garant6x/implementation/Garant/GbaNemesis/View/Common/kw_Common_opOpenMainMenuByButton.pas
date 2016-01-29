unit kw_Common_opOpenMainMenuByButton;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Common/kw_Common_opOpenMainMenuByButton.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> F1 Core::Common::View::Common::Tkw_Common_opOpenMainMenuByButton
//
// Слово словаря для вызова операции модуля Common.OpenMainMenuByButton (Окна Основное меню системы
// ГАРАНТ)
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
 Tkw_Common_opOpenMainMenuByButton = {final scriptword} class(TtfwModuleOperationWord)
  {* Слово словаря для вызова операции модуля Common.OpenMainMenuByButton (Окна Основное меню системы ГАРАНТ) }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   {$If not defined(NoScripts) AND not defined(NoVCM)}
   class function GetModuleOperationCode: TvcmMOPID; override;
   {$IfEnd} //not NoScripts AND not NoVCM
 end;//Tkw_Common_opOpenMainMenuByButton
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_Common_opOpenMainMenuByButton

class function Tkw_Common_opOpenMainMenuByButton.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'моп::Окна_Основное_меню_системы_ГАРАНТ';
end;//Tkw_Common_opOpenMainMenuByButton.GetWordNameForRegister

{$If not defined(NoScripts) AND not defined(NoVCM)}
class function Tkw_Common_opOpenMainMenuByButton.GetModuleOperationCode: TvcmMOPID;
 {-}
begin
 Result := TdmStdRes.mod_opcode_Common_OpenMainMenuByButton;
end;//Tkw_Common_opOpenMainMenuByButton.GetModuleOperationCode
{$IfEnd} //not NoScripts AND not NoVCM

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Common_opOpenMainMenuByButton
 Tkw_Common_opOpenMainMenuByButton.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.