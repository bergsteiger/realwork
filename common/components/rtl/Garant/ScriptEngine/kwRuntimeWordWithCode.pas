unit kwRuntimeWordWithCode;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwRuntimeWordWithCode.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwCompiledWordPrim
 , tfwWordRefList
 , tfwScriptingInterfaces
;

type
 _tfwCodeCompiler_Parent_ = TkwCompiledWordPrim;
 {$Include w:\common\components\rtl\Garant\ScriptEngine\tfwCodeCompiler.imp.pas}
 TkwRuntimeWordWithCode = {abstract} class(_tfwCodeCompiler_)
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function GetNewWordDefinitor: TtfwWord; override;
   procedure DoCompileInParameterPopCode(const aContext: TtfwContext;
    aParameterToPop: TtfwWord;
    aCheckCode: Boolean); override;
  public
   function GetCode(const aCtx: TtfwContext): TtfwWordRefList; override;
   function GetKeywordFinder(const aCtx: TtfwContext): TtfwWord; override;
 end;//TkwRuntimeWordWithCode
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , SysUtils
 , kwForwardDeclarationHolder
;

{$Include w:\common\components\rtl\Garant\ScriptEngine\tfwCodeCompiler.imp.pas}

procedure TkwRuntimeWordWithCode.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_52D55D7B0178_var*
//#UC END# *479731C50290_52D55D7B0178_var*
begin
//#UC START# *479731C50290_52D55D7B0178_impl*
 inherited;
//#UC END# *479731C50290_52D55D7B0178_impl*
end;//TkwRuntimeWordWithCode.Cleanup

function TkwRuntimeWordWithCode.GetCode(const aCtx: TtfwContext): TtfwWordRefList;
//#UC START# *52D41C7F027B_52D55D7B0178_var*
//#UC END# *52D41C7F027B_52D55D7B0178_var*
begin
//#UC START# *52D41C7F027B_52D55D7B0178_impl*
 Result := Code;
//#UC END# *52D41C7F027B_52D55D7B0178_impl*
end;//TkwRuntimeWordWithCode.GetCode

function TkwRuntimeWordWithCode.GetNewWordDefinitor: TtfwWord;
//#UC START# *52D56341033B_52D55D7B0178_var*
//#UC END# *52D56341033B_52D55D7B0178_var*
begin
//#UC START# *52D56341033B_52D55D7B0178_impl*
 if (f_PrevFinder = nil) then
  Result := nil
 else
  Result := f_PrevFinder.NewWordDefinitor;
//#UC END# *52D56341033B_52D55D7B0178_impl*
end;//TkwRuntimeWordWithCode.GetNewWordDefinitor

function TkwRuntimeWordWithCode.GetKeywordFinder(const aCtx: TtfwContext): TtfwWord;
//#UC START# *52D5637A031E_52D55D7B0178_var*
//#UC END# *52D5637A031E_52D55D7B0178_var*
begin
//#UC START# *52D5637A031E_52D55D7B0178_impl*
 Result := f_PrevFinder;
//#UC END# *52D5637A031E_52D55D7B0178_impl*
end;//TkwRuntimeWordWithCode.GetKeywordFinder

procedure TkwRuntimeWordWithCode.DoCompileInParameterPopCode(const aContext: TtfwContext;
 aParameterToPop: TtfwWord;
 aCheckCode: Boolean);
//#UC START# *52D56A980103_52D55D7B0178_var*
//#UC END# *52D56A980103_52D55D7B0178_var*
begin
//#UC START# *52D56A980103_52D55D7B0178_impl*
 CompilerAssert(false, 'Слово не может иметь входные параметры', aContext);
//#UC END# *52D56A980103_52D55D7B0178_impl*
end;//TkwRuntimeWordWithCode.DoCompileInParameterPopCode

initialization
 TkwRuntimeWordWithCode.RegisterClass;
 {* Регистрация TkwRuntimeWordWithCode }
{$IfEnd} // NOT Defined(NoScripts)

end.
