unit kw_Document_opOpenDocOnNumber;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Document/kw_Document_opOpenDocOnNumber.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> F1 Работа с документом и списком документов::Document::View::Document::Tkw_Document_opOpenDocOnNumber
//
// Слово словаря для вызова операции модуля Document.OpenDocOnNumber (Документ Открыть документ по
// номеру)
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
 Tkw_Document_opOpenDocOnNumber = {final scriptword} class(TtfwModuleOperationWord)
  {* Слово словаря для вызова операции модуля Document.OpenDocOnNumber (Документ Открыть документ по номеру) }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   {$If not defined(NoScripts) AND not defined(NoVCM)}
   class function GetModuleOperationCode: TvcmMOPID; override;
   {$IfEnd} //not NoScripts AND not NoVCM
 end;//Tkw_Document_opOpenDocOnNumber
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_Document_opOpenDocOnNumber

class function Tkw_Document_opOpenDocOnNumber.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'моп::Документ_Открыть_документ_по_номеру';
end;//Tkw_Document_opOpenDocOnNumber.GetWordNameForRegister

{$If not defined(NoScripts) AND not defined(NoVCM)}
class function Tkw_Document_opOpenDocOnNumber.GetModuleOperationCode: TvcmMOPID;
 {-}
begin
 Result := TdmStdRes.mod_opcode_Document_OpenDocOnNumber;
end;//Tkw_Document_opOpenDocOnNumber.GetModuleOperationCode
{$IfEnd} //not NoScripts AND not NoVCM

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Document_opOpenDocOnNumber
 Tkw_Document_opOpenDocOnNumber.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.