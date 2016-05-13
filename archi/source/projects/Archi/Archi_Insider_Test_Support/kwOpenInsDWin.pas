unit kwOpenInsDWin;

// Модуль: "w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwOpenInsDWin.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "TkwOpenInsDWin" MUID: (4E2448BD014D)

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwOpenInsDWin = class(TtfwRegisterableWord)
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
 end;//TkwOpenInsDWin
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , arArchiTestsAdapter
;

class function TkwOpenInsDWin.GetWordNameForRegister: AnsiString;
begin
 Result := 'редактор_словарей';
end;//TkwOpenInsDWin.GetWordNameForRegister

procedure TkwOpenInsDWin.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4E2448BD014D_var*
//#UC END# *4DAEEDE10285_4E2448BD014D_var*
begin
//#UC START# *4DAEEDE10285_4E2448BD014D_impl*
 AcOpenInsDWin;
//#UC END# *4DAEEDE10285_4E2448BD014D_impl*
end;//TkwOpenInsDWin.DoDoIt

initialization
 TkwOpenInsDWin.RegisterInEngine;
 {* Регистрация TkwOpenInsDWin }
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

end.
