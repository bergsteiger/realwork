unit tfwAnonimousWord;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwAnonimousWord.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TtfwAnonimousWord" MUID: (4DB9BB43017B)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwCompilingWord
 , tfwScriptingInterfaces
;

type
 TtfwAnonimousWord = {abstract} class(TtfwCompilingWord)
  protected
   procedure DoCompiledWord(aWord: TtfwWord;
    const aContext: TtfwContext); virtual;
  public
   procedure DoRun(const aCtx: TtfwContext); virtual;
   function IsAnonimous(const aCtx: TtfwContext): Boolean; override;
 end;//TtfwAnonimousWord
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 //#UC START# *4DB9BB43017Bimpl_uses*
 //#UC END# *4DB9BB43017Bimpl_uses*
;

procedure TtfwAnonimousWord.DoCompiledWord(aWord: TtfwWord;
 const aContext: TtfwContext);
//#UC START# *4DB9BBD6024F_4DB9BB43017B_var*
//#UC END# *4DB9BBD6024F_4DB9BB43017B_var*
begin
//#UC START# *4DB9BBD6024F_4DB9BB43017B_impl*
 if aWord.IsImmediate(aContext) then
 //if aWord.IsRunner(aContext) then
 begin
  CompilerAssert((aWord.Key = nil) OR (aWord.Key = Self.Key), 'Неверное имя запускаемого слова', aContext);
  aWord.Key := Self.Key;
  // - чтобы легче было опознавать слова по их Runner'ам
  try
   aWord.DoIt(aContext);
  finally
   aWord.Key := nil;
  end;//try..finally
 end//aWord.IsRunner
 else
 begin
  CompilerAssert(aContext.rCompiler <> nil, 'Нет кода для компиляции', aContext);
  aContext.rCompiler.AddCodePart(aWord, aContext, tfw_sniNo);
 end;//aWord.IsRunner
//#UC END# *4DB9BBD6024F_4DB9BB43017B_impl*
end;//TtfwAnonimousWord.DoCompiledWord

procedure TtfwAnonimousWord.DoRun(const aCtx: TtfwContext);
//#UC START# *5512949D0048_4DB9BB43017B_var*
//#UC END# *5512949D0048_4DB9BB43017B_var*
begin
//#UC START# *5512949D0048_4DB9BB43017B_impl*
 RunnerError(ClassName + '.DoRun не реализован', aCtx);
//#UC END# *5512949D0048_4DB9BB43017B_impl*
end;//TtfwAnonimousWord.DoRun

function TtfwAnonimousWord.IsAnonimous(const aCtx: TtfwContext): Boolean;
//#UC START# *4F3AB3600008_4DB9BB43017B_var*
//#UC END# *4F3AB3600008_4DB9BB43017B_var*
begin
//#UC START# *4F3AB3600008_4DB9BB43017B_impl*
 Result := true;
//#UC END# *4F3AB3600008_4DB9BB43017B_impl*
end;//TtfwAnonimousWord.IsAnonimous

initialization
 TtfwAnonimousWord.RegisterClass;
 {* Регистрация TtfwAnonimousWord }
{$IfEnd} // NOT Defined(NoScripts)

end.
