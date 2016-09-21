unit kwClearConfig;

// Модуль: "w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwClearConfig.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "ClearConfig" MUID: (56A09E250064)
// Имя типа: "TkwClearConfig"

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwClearConfig = {final} class(TtfwRegisterableWord)
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
 end;//TkwClearConfig
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , arArchiTestAdapter2
 //#UC START# *56A09E250064impl_uses*
 //#UC END# *56A09E250064impl_uses*
;

class function TkwClearConfig.GetWordNameForRegister: AnsiString;
begin
 Result := 'ClearConfig';
end;//TkwClearConfig.GetWordNameForRegister

procedure TkwClearConfig.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_56A09E250064_var*
var
 l_DirName  : AnsiString;
 l_FileName : AnsiString;
//#UC END# *4DAEEDE10285_56A09E250064_var*
begin
//#UC START# *4DAEEDE10285_56A09E250064_impl*
 inherited;
 RunnerAssert(aCtx.rEngine.IsTopString, 'Не задано имя архива с базой!', aCtx);
 l_FileName := aCtx.rCaller.ResolveInputFilePath(aCtx.rEngine.PopDelphiString);
 AcClearConfig(l_FileName);
//#UC END# *4DAEEDE10285_56A09E250064_impl*
end;//TkwClearConfig.DoDoIt

initialization
 TkwClearConfig.RegisterInEngine;
 {* Регистрация ClearConfig }
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)

end.
