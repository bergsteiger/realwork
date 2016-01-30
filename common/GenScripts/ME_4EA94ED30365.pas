unit kwAddBlock;
 {* окно_редактора:установить_блок }

// ћодуль: "w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwAddBlock.pas"
// —тереотип: "ScriptKeyword"

{$Include arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwAddBlock = class(TtfwRegisterableWord)
  {* окно_редактора:установить_блок }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwAddBlock
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , arArchiTestsAdapter
;

procedure TkwAddBlock.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4EA94ED30365_var*
//#UC END# *4DAEEDE10285_4EA94ED30365_var*
begin
//#UC START# *4DAEEDE10285_4EA94ED30365_impl*
 ArAddBlock
//#UC END# *4DAEEDE10285_4EA94ED30365_impl*
end;//TkwAddBlock.DoDoIt

class function TkwAddBlock.GetWordNameForRegister: AnsiString;
begin
 Result := 'окно_редактора:установить_блок';
end;//TkwAddBlock.GetWordNameForRegister

initialization
 TkwAddBlock.RegisterInEngine;
 {* –егистраци€ TkwAddBlock }
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

end.
