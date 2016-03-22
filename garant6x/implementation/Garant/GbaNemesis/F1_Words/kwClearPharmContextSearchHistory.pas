unit kwClearPharmContextSearchHistory;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\F1_Words\kwClearPharmContextSearchHistory.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "ClearPharmContextSearchHistory" MUID: (53B12BB200FE)
// Имя типа: "TkwClearPharmContextSearchHistory"

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
 TkwClearPharmContextSearchHistory = {final} class(TkwClearContextSearchHistory)
  protected
   function GetContextHistoryKind: TnsContextHistoryKind; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwClearPharmContextSearchHistory
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
;

function TkwClearPharmContextSearchHistory.GetContextHistoryKind: TnsContextHistoryKind;
//#UC START# *53B12AEE01A2_53B12BB200FE_var*
//#UC END# *53B12AEE01A2_53B12BB200FE_var*
begin
//#UC START# *53B12AEE01A2_53B12BB200FE_impl*
 Result := ns_chkInpharm;
//#UC END# *53B12AEE01A2_53B12BB200FE_impl*
end;//TkwClearPharmContextSearchHistory.GetContextHistoryKind

class function TkwClearPharmContextSearchHistory.GetWordNameForRegister: AnsiString;
begin
 Result := 'ClearPharmContextSearchHistory';
end;//TkwClearPharmContextSearchHistory.GetWordNameForRegister

initialization
 TkwClearPharmContextSearchHistory.RegisterInEngine;
 {* Регистрация ClearPharmContextSearchHistory }
{$IfEnd} // NOT Defined(NoScripts)

end.
