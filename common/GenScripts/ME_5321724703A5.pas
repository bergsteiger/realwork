unit kwIsPreviewInProgress;

// Модуль: "w:\archi\source\projects\Everest\Lite\7.0\Express\EverestTestSupport\kwIsPreviewInProgress.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "IsPreviewInProgress" MUID: (5321724703A5)
// Имя типа: "TkwIsPreviewInProgress"

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwIsPreviewInProgress = {final} class(TtfwRegisterableWord)
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwIsPreviewInProgress
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , EverestLiteAdapter
;

procedure TkwIsPreviewInProgress.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_5321724703A5_var*
//#UC END# *4DAEEDE10285_5321724703A5_var*
begin
//#UC START# *4DAEEDE10285_5321724703A5_impl*
 aCtx.rEngine.PushBool(IsPreviewInProcess);
//#UC END# *4DAEEDE10285_5321724703A5_impl*
end;//TkwIsPreviewInProgress.DoDoIt

class function TkwIsPreviewInProgress.GetWordNameForRegister: AnsiString;
begin
 Result := 'IsPreviewInProgress';
end;//TkwIsPreviewInProgress.GetWordNameForRegister

initialization
 TkwIsPreviewInProgress.RegisterInEngine;
 {* Регистрация IsPreviewInProgress }
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

end.
