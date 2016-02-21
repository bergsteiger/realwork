unit kwIncludedPrim;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwIncludedPrim.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwCompilingWord
 , tfwStreamFactory
 , tfwScriptingInterfaces
 , kwCompiledWordPrim
;

type
 TkwIncludedPrim = {abstract} class(TtfwCompilingWord)
  protected
   procedure DoFiler(aFiler: TtfwStreamFactory;
    const aCtx: TtfwContext);
   procedure FillContext(const anOldContext: TtfwContext;
    var theNewContext: TtfwContext); virtual;
   function EndBracket(const aContext: TtfwContext;
    aSilent: Boolean): RtfwWord; override;
   procedure AfterCompile(var theNewContext: TtfwContext;
    aCompiled: TkwCompiledWordPrim); override;
   function CompiledWordClass(const aCtx: TtfwContext): RkwCompiledWordPrim; override;
   function AcceptsEOF: Boolean; override;
   class function ReallyNeedRegister: Boolean; override;
 end;//TkwIncludedPrim
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , kwCompiledIncluded
 , tfwParser
 , tfwParserInterfaces
;

procedure TkwIncludedPrim.DoFiler(aFiler: TtfwStreamFactory;
 const aCtx: TtfwContext);
//#UC START# *4E207ACF02D5_4E207A0002B2_var*
var
 l_P : ItfwParserEx;
 l_Ctx : TtfwContext;
 l_NeedCompile : Boolean;
//#UC END# *4E207ACF02D5_4E207A0002B2_var*
begin
//#UC START# *4E207ACF02D5_4E207A0002B2_impl*
 l_Ctx := aCtx;
 l_Ctx.rPrev := nil;
 l_Ctx.rTypeInfo := TtfwWordInfoE.Instance;
 l_Ctx.rStreamFactory := aFiler;
 try
  l_P := TtfwParser.Make(aFiler);
  try
   l_Ctx.rKeyWords := aCtx.rEngine.KeywordFinder(aCtx); {!!! - чтобы слова искались в ScriptEngine}
   try
    l_Ctx.rCompiler := nil; {!!! - чтобы слова попадали в ScriptEngine}
    l_Ctx.rParser := l_P;
    FillContext(aCtx, l_Ctx);
    l_NeedCompile := aCtx.rEngine.OpenDictionary(l_Ctx);
    try
     if l_NeedCompile then
      inherited DoDoIt(l_Ctx);
    finally
     aCtx.rEngine.CloseDictionary(l_Ctx);
    end;//try..finally
   finally
    l_Ctx.rKeyWords := nil;
   end;//try..finally
  finally
   l_P := nil;
  end;//try..finally
 finally
  Finalize(l_Ctx);
 end;//try..finally
//#UC END# *4E207ACF02D5_4E207A0002B2_impl*
end;//TkwIncludedPrim.DoFiler

procedure TkwIncludedPrim.FillContext(const anOldContext: TtfwContext;
 var theNewContext: TtfwContext);
//#UC START# *4F3AA59B025A_4E207A0002B2_var*
//#UC END# *4F3AA59B025A_4E207A0002B2_var*
begin
//#UC START# *4F3AA59B025A_4E207A0002B2_impl*
 // - ничего не делаем
//#UC END# *4F3AA59B025A_4E207A0002B2_impl*
end;//TkwIncludedPrim.FillContext

function TkwIncludedPrim.EndBracket(const aContext: TtfwContext;
 aSilent: Boolean): RtfwWord;
//#UC START# *4DB6C99F026E_4E207A0002B2_var*
//#UC END# *4DB6C99F026E_4E207A0002B2_var*
begin
//#UC START# *4DB6C99F026E_4E207A0002B2_impl*
 Result := DisabledEndBracket(aContext, aSilent);
//#UC END# *4DB6C99F026E_4E207A0002B2_impl*
end;//TkwIncludedPrim.EndBracket

procedure TkwIncludedPrim.AfterCompile(var theNewContext: TtfwContext;
 aCompiled: TkwCompiledWordPrim);
//#UC START# *4DB6CE2302C9_4E207A0002B2_var*
//#UC END# *4DB6CE2302C9_4E207A0002B2_var*
begin
//#UC START# *4DB6CE2302C9_4E207A0002B2_impl*
 CompilerAssert(not aCompiled.HasCode, 'Слово не может иметь собственный код', theNewContext.rPrev^);
 CompilerAssert(not aCompiled.HasLocalDictionary, 'Слово не может иметь локальный словарь', theNewContext.rPrev^);
 inherited;
//#UC END# *4DB6CE2302C9_4E207A0002B2_impl*
end;//TkwIncludedPrim.AfterCompile

function TkwIncludedPrim.CompiledWordClass(const aCtx: TtfwContext): RkwCompiledWordPrim;
//#UC START# *4DBAEE0D028D_4E207A0002B2_var*
//#UC END# *4DBAEE0D028D_4E207A0002B2_var*
begin
//#UC START# *4DBAEE0D028D_4E207A0002B2_impl*
 Result := TkwCompiledIncluded;
//#UC END# *4DBAEE0D028D_4E207A0002B2_impl*
end;//TkwIncludedPrim.CompiledWordClass

function TkwIncludedPrim.AcceptsEOF: Boolean;
//#UC START# *4DC2DEE70178_4E207A0002B2_var*
//#UC END# *4DC2DEE70178_4E207A0002B2_var*
begin
//#UC START# *4DC2DEE70178_4E207A0002B2_impl*
 Result := true;
//#UC END# *4DC2DEE70178_4E207A0002B2_impl*
end;//TkwIncludedPrim.AcceptsEOF

class function TkwIncludedPrim.ReallyNeedRegister: Boolean;
//#UC START# *4DC2E05B03DD_4E207A0002B2_var*
//#UC END# *4DC2E05B03DD_4E207A0002B2_var*
begin
//#UC START# *4DC2E05B03DD_4E207A0002B2_impl*
 Result := false;
//#UC END# *4DC2E05B03DD_4E207A0002B2_impl*
end;//TkwIncludedPrim.ReallyNeedRegister

initialization
 TkwIncludedPrim.RegisterClass;
 {* Регистрация TkwIncludedPrim }
{$IfEnd} // NOT Defined(NoScripts)

end.
