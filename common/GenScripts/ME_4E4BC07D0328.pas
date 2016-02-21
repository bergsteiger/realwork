unit kwInsertDocChanges;
 {* macros:InsertDocChanges }

// Модуль: "w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwInsertDocChanges.pas"
// Стереотип: "ScriptKeyword"

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwInsertDocChanges = class(TtfwRegisterableWord)
  {* macros:InsertDocChanges }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwInsertDocChanges
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , arArchiTestAdapter2
;

procedure TkwInsertDocChanges.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4E4BC07D0328_var*
//#UC END# *4DAEEDE10285_4E4BC07D0328_var*
begin
//#UC START# *4DAEEDE10285_4E4BC07D0328_impl*
 ArInsertDocChanges;
//#UC END# *4DAEEDE10285_4E4BC07D0328_impl*
end;//TkwInsertDocChanges.DoDoIt

class function TkwInsertDocChanges.GetWordNameForRegister: AnsiString;
begin
 Result := 'macros:InsertDocChanges';
end;//TkwInsertDocChanges.GetWordNameForRegister

initialization
 TkwInsertDocChanges.RegisterInEngine;
 {* Регистрация TkwInsertDocChanges }
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

end.
