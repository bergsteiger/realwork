unit kwClearDocumentContextSearchHistory;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "F1 Words"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/F1_Words/kwClearDocumentContextSearchHistory.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> F1 Поддержка тестов::F1 Words::Words::ClearDocumentContextSearchHistory
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\GbaNemesis\nsDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  kwClearContextSearchHistory
  {$If not defined(Admin)}
  ,
  ContextHistoryInterfaces
  {$IfEnd} //not Admin
  
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
type
 TkwClearDocumentContextSearchHistory = {final scriptword} class(TkwClearContextSearchHistory)
 protected
 // realized methods
   function GetContextHistoryKind: TnsContextHistoryKind; override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwClearDocumentContextSearchHistory
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}

// start class TkwClearDocumentContextSearchHistory

function TkwClearDocumentContextSearchHistory.GetContextHistoryKind: TnsContextHistoryKind;
//#UC START# *53B12AEE01A2_53B12B8A03DC_var*
//#UC END# *53B12AEE01A2_53B12B8A03DC_var*
begin
//#UC START# *53B12AEE01A2_53B12B8A03DC_impl*
 Result := ns_chkDocument;
//#UC END# *53B12AEE01A2_53B12B8A03DC_impl*
end;//TkwClearDocumentContextSearchHistory.GetContextHistoryKind

class function TkwClearDocumentContextSearchHistory.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'ClearDocumentContextSearchHistory';
end;//TkwClearDocumentContextSearchHistory.GetWordNameForRegister

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// Регистрация ClearDocumentContextSearchHistory
 TkwClearDocumentContextSearchHistory.RegisterInEngine;
{$IfEnd} //not NoScripts

end.