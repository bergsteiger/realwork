unit kwCompiledWordWorkerEx;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwCompiledWordWorkerEx.pas"
// Стереотип: "SimpleClass"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwCompiledWordWorker
 , tfwScriptingInterfaces
 , tfwAnonimousWord
;

type
 _tfwOtherWordRunner_Parent_ = TkwCompiledWordWorker;
 {$Include w:\common\components\rtl\Garant\ScriptEngine\tfwOtherWordRunner.imp.pas}
 TkwCompiledWordWorkerEx = class(_tfwOtherWordRunner_)
  private
   f_WordToRun: TtfwWord;
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   function GetWordToRun: TtfwAnonimousWord; override;
   function pm_GetResultTypeInfo(const aCtx: TtfwContext): TtfwWordInfo; override;
  public
   constructor Create(aWordToPush: TtfwWord;
    aWordToRun: TtfwWord;
    const aCtx: TtfwContext); override;
 end;//TkwCompiledWordWorkerEx
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwWordWorker
;

{$Include w:\common\components\rtl\Garant\ScriptEngine\tfwOtherWordRunner.imp.pas}

procedure TkwCompiledWordWorkerEx.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_5512E3740036_var*
//#UC END# *4DAEEDE10285_5512E3740036_var*
begin
//#UC START# *4DAEEDE10285_5512E3740036_impl*
 aCtx.rEngine.PushObj(WordToWork);
 RunOther(aCtx);
//#UC END# *4DAEEDE10285_5512E3740036_impl*
end;//TkwCompiledWordWorkerEx.DoDoIt

function TkwCompiledWordWorkerEx.GetWordToRun: TtfwAnonimousWord;
//#UC START# *55630CB40207_5512E3740036_var*
//#UC END# *55630CB40207_5512E3740036_var*
begin
//#UC START# *55630CB40207_5512E3740036_impl*
 Result := (f_WordToRun As TtfwAnonimousWord);
//#UC END# *55630CB40207_5512E3740036_impl*
end;//TkwCompiledWordWorkerEx.GetWordToRun

constructor TkwCompiledWordWorkerEx.Create(aWordToPush: TtfwWord;
 aWordToRun: TtfwWord;
 const aCtx: TtfwContext);
//#UC START# *4DCBB0CD028D_5512E3740036_var*
//#UC END# *4DCBB0CD028D_5512E3740036_var*
begin
//#UC START# *4DCBB0CD028D_5512E3740036_impl*
 f_WordToRun := aWordToRun;
 inherited Create(aWordToPush, aWordToRun, aCtx);
//#UC END# *4DCBB0CD028D_5512E3740036_impl*
end;//TkwCompiledWordWorkerEx.Create

function TkwCompiledWordWorkerEx.pm_GetResultTypeInfo(const aCtx: TtfwContext): TtfwWordInfo;
//#UC START# *52CFC11603C8_5512E3740036get_var*
//#UC END# *52CFC11603C8_5512E3740036get_var*
begin
//#UC START# *52CFC11603C8_5512E3740036get_impl*
 Result := f_WordToRun.ResultTypeInfo[aCtx];
//#UC END# *52CFC11603C8_5512E3740036get_impl*
end;//TkwCompiledWordWorkerEx.pm_GetResultTypeInfo

initialization
 TkwCompiledWordWorkerEx.RegisterClass;
 {* Регистрация TkwCompiledWordWorkerEx }
{$IfEnd} // NOT Defined(NoScripts)

end.
