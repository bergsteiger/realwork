unit kw_Monitorings_opOpenNewsLine;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Search/kw_Monitorings_opOpenNewsLine.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> F1 Пользовательские сервисы::Autoreferat::View::Search::Tkw_Monitorings_opOpenNewsLine
//
// Слово словаря для вызова операции модуля Monitorings.OpenNewsLine (Мониторинги Новостная лента)
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
 Tkw_Monitorings_opOpenNewsLine = {final scriptword} class(TtfwModuleOperationWord)
  {* Слово словаря для вызова операции модуля Monitorings.OpenNewsLine (Мониторинги Новостная лента) }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   {$If not defined(NoScripts) AND not defined(NoVCM)}
   class function GetModuleOperationCode: TvcmMOPID; override;
   {$IfEnd} //not NoScripts AND not NoVCM
 end;//Tkw_Monitorings_opOpenNewsLine
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_Monitorings_opOpenNewsLine

class function Tkw_Monitorings_opOpenNewsLine.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'моп::Мониторинги_Новостная_лента';
end;//Tkw_Monitorings_opOpenNewsLine.GetWordNameForRegister

{$If not defined(NoScripts) AND not defined(NoVCM)}
class function Tkw_Monitorings_opOpenNewsLine.GetModuleOperationCode: TvcmMOPID;
 {-}
begin
 Result := TdmStdRes.mod_opcode_Monitorings_OpenNewsLine;
end;//Tkw_Monitorings_opOpenNewsLine.GetModuleOperationCode
{$IfEnd} //not NoScripts AND not NoVCM

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Monitorings_opOpenNewsLine
 Tkw_Monitorings_opOpenNewsLine.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.