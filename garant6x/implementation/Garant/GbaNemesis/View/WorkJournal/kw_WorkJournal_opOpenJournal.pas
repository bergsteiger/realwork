unit kw_WorkJournal_opOpenJournal;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/WorkJournal/kw_WorkJournal_opOpenJournal.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> F1 Основные прецеденты::WorkJournal::View::WorkJournal::Tkw_WorkJournal_opOpenJournal
//
// Слово словаря для вызова операции модуля WorkJournal.OpenJournal (Журнал работы)
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
 Tkw_WorkJournal_opOpenJournal = {final scriptword} class(TtfwModuleOperationWord)
  {* Слово словаря для вызова операции модуля WorkJournal.OpenJournal (Журнал работы) }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   {$If not defined(NoScripts) AND not defined(NoVCM)}
   class function GetModuleOperationCode: TvcmMOPID; override;
   {$IfEnd} //not NoScripts AND not NoVCM
 end;//Tkw_WorkJournal_opOpenJournal
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_WorkJournal_opOpenJournal

class function Tkw_WorkJournal_opOpenJournal.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'моп::Журнал_работы_OpenJournal';
end;//Tkw_WorkJournal_opOpenJournal.GetWordNameForRegister

{$If not defined(NoScripts) AND not defined(NoVCM)}
class function Tkw_WorkJournal_opOpenJournal.GetModuleOperationCode: TvcmMOPID;
 {-}
begin
 Result := TdmStdRes.mod_opcode_WorkJournal_OpenJournal;
end;//Tkw_WorkJournal_opOpenJournal.GetModuleOperationCode
{$IfEnd} //not NoScripts AND not NoVCM

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_WorkJournal_opOpenJournal
 Tkw_WorkJournal_opOpenJournal.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.