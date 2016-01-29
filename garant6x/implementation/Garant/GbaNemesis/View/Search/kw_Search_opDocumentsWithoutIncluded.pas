unit kw_Search_opDocumentsWithoutIncluded;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Search/kw_Search_opDocumentsWithoutIncluded.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> F1 Основные прецеденты::Search::View::Search::Tkw_Search_opDocumentsWithoutIncluded
//
// Слово словаря для вызова операции модуля Search.DocumentsWithoutIncluded (Поиск)
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
 Tkw_Search_opDocumentsWithoutIncluded = {final scriptword} class(TtfwModuleOperationWord)
  {* Слово словаря для вызова операции модуля Search.DocumentsWithoutIncluded (Поиск) }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   {$If not defined(NoScripts) AND not defined(NoVCM)}
   class function GetModuleOperationCode: TvcmMOPID; override;
   {$IfEnd} //not NoScripts AND not NoVCM
 end;//Tkw_Search_opDocumentsWithoutIncluded
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_Search_opDocumentsWithoutIncluded

class function Tkw_Search_opDocumentsWithoutIncluded.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'моп::Поиск_DocumentsWithoutIncluded';
end;//Tkw_Search_opDocumentsWithoutIncluded.GetWordNameForRegister

{$If not defined(NoScripts) AND not defined(NoVCM)}
class function Tkw_Search_opDocumentsWithoutIncluded.GetModuleOperationCode: TvcmMOPID;
 {-}
begin
 Result := TdmStdRes.mod_opcode_Search_DocumentsWithoutIncluded;
end;//Tkw_Search_opDocumentsWithoutIncluded.GetModuleOperationCode
{$IfEnd} //not NoScripts AND not NoVCM

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Search_opDocumentsWithoutIncluded
 Tkw_Search_opDocumentsWithoutIncluded.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.