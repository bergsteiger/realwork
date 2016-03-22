unit kwPreview;

// Модуль: "w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwPreview.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "Preview" MUID: (530B30360258)
// Имя типа: "TkwPreview"

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwPreview = {final} class(TtfwRegisterableWord)
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwPreview
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , arArchiTestAdapter2
;

procedure TkwPreview.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_530B30360258_var*
//#UC END# *4DAEEDE10285_530B30360258_var*
begin
//#UC START# *4DAEEDE10285_530B30360258_impl*
 acMakePreview;
//#UC END# *4DAEEDE10285_530B30360258_impl*
end;//TkwPreview.DoDoIt

class function TkwPreview.GetWordNameForRegister: AnsiString;
begin
 Result := 'Preview';
end;//TkwPreview.GetWordNameForRegister

initialization
 TkwPreview.RegisterInEngine;
 {* Регистрация Preview }
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)

end.
