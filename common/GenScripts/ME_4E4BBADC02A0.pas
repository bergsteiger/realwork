unit kwMakeChangeDoc;
 {* macros:MakeChangeDoc }

// Модуль: "w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwMakeChangeDoc.pas"
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
 TkwMakeChangeDoc = class(TtfwRegisterableWord)
  {* macros:MakeChangeDoc }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwMakeChangeDoc
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , arArchiTestAdapter2
;

procedure TkwMakeChangeDoc.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4E4BBADC02A0_var*
//#UC END# *4DAEEDE10285_4E4BBADC02A0_var*
begin
//#UC START# *4DAEEDE10285_4E4BBADC02A0_impl*
 ArMakeChangeDoc;
//#UC END# *4DAEEDE10285_4E4BBADC02A0_impl*
end;//TkwMakeChangeDoc.DoDoIt

class function TkwMakeChangeDoc.GetWordNameForRegister: AnsiString;
begin
 Result := 'macros:MakeChangeDoc';
end;//TkwMakeChangeDoc.GetWordNameForRegister

initialization
 TkwMakeChangeDoc.RegisterInEngine;
 {* Регистрация TkwMakeChangeDoc }
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

end.
