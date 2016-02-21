unit kwWaitChoice;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwWaitChoice.pas"
// Стереотип: "ScriptKeyword"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 _afwImpurity_Parent_ = TtfwRegisterableWord;
 {$Include w:\common\components\rtl\Garant\ScriptEngine\afwImpurity.imp.pas}
 TkwWaitChoice = {final} class(_afwImpurity_)
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwWaitChoice
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
 , l3BatchService
 , Controls
;

{$Include w:\common\components\rtl\Garant\ScriptEngine\afwImpurity.imp.pas}

procedure TkwWaitChoice.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4FFFF8520204_var*
//#UC END# *4DAEEDE10285_4FFFF8520204_var*
begin
//#UC START# *4DAEEDE10285_4FFFF8520204_impl*
 Tl3BatchService.Instance.PushAnswer(-aCtx.rEngine.PopInt);
//#UC END# *4DAEEDE10285_4FFFF8520204_impl*
end;//TkwWaitChoice.DoDoIt

class function TkwWaitChoice.GetWordNameForRegister: AnsiString;
begin
 Result := 'wait:Choice';
end;//TkwWaitChoice.GetWordNameForRegister

initialization
 TkwWaitChoice.RegisterInEngine;
 {* Регистрация wait_Choice }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
