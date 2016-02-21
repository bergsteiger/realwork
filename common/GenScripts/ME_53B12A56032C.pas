unit kwClearContextSearchHistory;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\F1_Words\kwClearContextSearchHistory.pas"
// Стереотип: "ScriptKeyword"

{$Include w:\garant6x\implementation\Garant\GbaNemesis\nsDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 {$If NOT Defined(Admin)}
 , ContextHistoryInterfaces
 {$IfEnd} // NOT Defined(Admin)
 , tfwScriptingInterfaces
;

type
 TkwClearContextSearchHistory = {abstract} class(TtfwRegisterableWord)
  protected
   function GetContextHistoryKind: TnsContextHistoryKind; virtual; abstract;
   procedure DoDoIt(const aCtx: TtfwContext); override;
 end;//TkwClearContextSearchHistory
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 {$If NOT Defined(Admin)}
 , BaseSearchInterfaces
 {$IfEnd} // NOT Defined(Admin)
 {$If NOT Defined(Admin)}
 , nsContextHistory
 {$IfEnd} // NOT Defined(Admin)
;

procedure TkwClearContextSearchHistory.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_53B12A56032C_var*
//#UC END# *4DAEEDE10285_53B12A56032C_var*
begin
//#UC START# *4DAEEDE10285_53B12A56032C_impl*
 NsGetContextHistory(GetContextHistoryKind).Clear;
//#UC END# *4DAEEDE10285_53B12A56032C_impl*
end;//TkwClearContextSearchHistory.DoDoIt
{$IfEnd} // NOT Defined(NoScripts)

end.
