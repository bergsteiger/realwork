unit kwAddBlock;
 {* окно_редактора:установить_блок }

// ћодуль: "w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwAddBlock.pas"
// —тереотип: "ScriptKeyword"
// Ёлемент модели: "TkwAddBlock" MUID: (4EA94ED30365)

{$Include w:\archi\source\projects\Archi\arDefine.inc}

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
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
 end;//TkwAddBlock
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , arArchiTestsAdapter
 //#UC START# *4EA94ED30365impl_uses*
 //#UC END# *4EA94ED30365impl_uses*
;

class function TkwAddBlock.GetWordNameForRegister: AnsiString;
begin
 Result := 'окно_редактора:установить_блок';
end;//TkwAddBlock.GetWordNameForRegister

procedure TkwAddBlock.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4EA94ED30365_var*
//#UC END# *4DAEEDE10285_4EA94ED30365_var*
begin
//#UC START# *4DAEEDE10285_4EA94ED30365_impl*
 ArAddBlock
//#UC END# *4DAEEDE10285_4EA94ED30365_impl*
end;//TkwAddBlock.DoDoIt

initialization
 TkwAddBlock.RegisterInEngine;
 {* –егистраци€ TkwAddBlock }
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

end.
