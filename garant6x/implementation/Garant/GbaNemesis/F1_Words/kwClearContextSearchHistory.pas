unit kwClearContextSearchHistory;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "F1 Words"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/F1_Words/kwClearContextSearchHistory.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> F1 Поддержка тестов::F1 Words::Words::ClearContextSearchHistory
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
  tfwRegisterableWord
  {$If not defined(Admin)}
  ,
  ContextHistoryInterfaces
  {$IfEnd} //not Admin
  ,
  tfwScriptingInterfaces
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
type
 TkwClearContextSearchHistory = {abstract scriptword} class(TtfwRegisterableWord)
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // protected methods
   function GetContextHistoryKind: TnsContextHistoryKind; virtual; abstract;
 end;//TkwClearContextSearchHistory
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  Classes
  {$If not defined(Admin)}
  ,
  BaseSearchInterfaces
  {$IfEnd} //not Admin
  
  {$If not defined(Admin)}
  ,
  nsContextHistory
  {$IfEnd} //not Admin
  
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class TkwClearContextSearchHistory

procedure TkwClearContextSearchHistory.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_53B12A56032C_var*
//#UC END# *4DAEEDE10285_53B12A56032C_var*
begin
//#UC START# *4DAEEDE10285_53B12A56032C_impl*
 NsGetContextHistory(GetContextHistoryKind).Clear;
//#UC END# *4DAEEDE10285_53B12A56032C_impl*
end;//TkwClearContextSearchHistory.DoDoIt

{$IfEnd} //not NoScripts

end.