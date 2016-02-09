unit kwTemporaryCompiledCode;
 {* Временный контейне скомпилированного кода, который умрёт после компиляции. На который нельзя держать "слабые" ссылки. Например как Caller }

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwTemporaryCompiledCode.pas"
// Стереотип: "SimpleClass"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwRuntimeWordWithCode
 , tfwScriptingInterfaces
;

type
 TkwTemporaryCompiledCode = class(TkwRuntimeWordWithCode)
  {* Временный контейне скомпилированного кода, который умрёт после компиляции. На который нельзя держать "слабые" ссылки. Например как Caller }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetAsCaller(const aCtx: TtfwContext): TtfwWord; override;
 end;//TkwTemporaryCompiledCode
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
;

procedure TkwTemporaryCompiledCode.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_52DFE4E403E7_var*
//#UC END# *4DAEEDE10285_52DFE4E403E7_var*
begin
//#UC START# *4DAEEDE10285_52DFE4E403E7_impl*
 RunnerError('Временный код не может исполняться', aCtx);
//#UC END# *4DAEEDE10285_52DFE4E403E7_impl*
end;//TkwTemporaryCompiledCode.DoDoIt

function TkwTemporaryCompiledCode.GetAsCaller(const aCtx: TtfwContext): TtfwWord;
//#UC START# *52DFE48500BB_52DFE4E403E7_var*
//#UC END# *52DFE48500BB_52DFE4E403E7_var*
begin
//#UC START# *52DFE48500BB_52DFE4E403E7_impl*
 CompilerAssert(ParentWord <> nil, 'Слово не имеет родителя', aCtx);
 Result := ParentWord;
//#UC END# *52DFE48500BB_52DFE4E403E7_impl*
end;//TkwTemporaryCompiledCode.GetAsCaller

initialization
 TkwTemporaryCompiledCode.RegisterClass;
 {* Регистрация TkwTemporaryCompiledCode }
{$IfEnd} // NOT Defined(NoScripts)

end.
