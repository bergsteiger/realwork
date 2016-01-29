unit kw_DocumentListFromFile_opOpenDocumentListFromFile;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/DocumentListFromFile/kw_DocumentListFromFile_opOpenDocumentListFromFile.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> F1 Интерфейсные элементы::DocumentListFromFile::View::DocumentListFromFile::Tkw_DocumentListFromFile_opOpenDocumentListFromFile
//
// Слово словаря для вызова операции модуля DocumentListFromFile.OpenDocumentListFromFile (Список
// документов из файла Открыть список документов из файла)
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
 Tkw_DocumentListFromFile_opOpenDocumentListFromFile = {final scriptword} class(TtfwModuleOperationWord)
  {* Слово словаря для вызова операции модуля DocumentListFromFile.OpenDocumentListFromFile (Список документов из файла Открыть список документов из файла) }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   {$If not defined(NoScripts) AND not defined(NoVCM)}
   class function GetModuleOperationCode: TvcmMOPID; override;
   {$IfEnd} //not NoScripts AND not NoVCM
 end;//Tkw_DocumentListFromFile_opOpenDocumentListFromFile
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_DocumentListFromFile_opOpenDocumentListFromFile

class function Tkw_DocumentListFromFile_opOpenDocumentListFromFile.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'моп::Список_документов_из_файла_Открыть_список_документов_из_файла';
end;//Tkw_DocumentListFromFile_opOpenDocumentListFromFile.GetWordNameForRegister

{$If not defined(NoScripts) AND not defined(NoVCM)}
class function Tkw_DocumentListFromFile_opOpenDocumentListFromFile.GetModuleOperationCode: TvcmMOPID;
 {-}
begin
 Result := TdmStdRes.mod_opcode_DocumentListFromFile_OpenDocumentListFromFile;
end;//Tkw_DocumentListFromFile_opOpenDocumentListFromFile.GetModuleOperationCode
{$IfEnd} //not NoScripts AND not NoVCM

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_DocumentListFromFile_opOpenDocumentListFromFile
 Tkw_DocumentListFromFile_opOpenDocumentListFromFile.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.