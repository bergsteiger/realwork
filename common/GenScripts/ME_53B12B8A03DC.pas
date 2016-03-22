unit kwClearDocumentContextSearchHistory;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\F1_Words\kwClearDocumentContextSearchHistory.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "ClearDocumentContextSearchHistory" MUID: (53B12B8A03DC)
// Имя типа: "TkwClearDocumentContextSearchHistory"

{$Include w:\garant6x\implementation\Garant\GbaNemesis\nsDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwClearContextSearchHistory
 {$If NOT Defined(Admin)}
 , ContextHistoryInterfaces
 {$IfEnd} // NOT Defined(Admin)
;

type
 TkwClearDocumentContextSearchHistory = {final} class(TkwClearContextSearchHistory)
  protected
   function GetContextHistoryKind: TnsContextHistoryKind; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwClearDocumentContextSearchHistory
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
;

function TkwClearDocumentContextSearchHistory.GetContextHistoryKind: TnsContextHistoryKind;
//#UC START# *53B12AEE01A2_53B12B8A03DC_var*
//#UC END# *53B12AEE01A2_53B12B8A03DC_var*
begin
//#UC START# *53B12AEE01A2_53B12B8A03DC_impl*
 Result := ns_chkDocument;
//#UC END# *53B12AEE01A2_53B12B8A03DC_impl*
end;//TkwClearDocumentContextSearchHistory.GetContextHistoryKind

class function TkwClearDocumentContextSearchHistory.GetWordNameForRegister: AnsiString;
begin
 Result := 'ClearDocumentContextSearchHistory';
end;//TkwClearDocumentContextSearchHistory.GetWordNameForRegister

initialization
 TkwClearDocumentContextSearchHistory.RegisterInEngine;
 {* Регистрация ClearDocumentContextSearchHistory }
{$IfEnd} // NOT Defined(NoScripts)

end.
