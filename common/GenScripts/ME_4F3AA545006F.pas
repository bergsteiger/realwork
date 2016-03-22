unit kwInnerIncluded;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwInnerIncluded.pas"
// Стереотип: "SimpleClass"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwIncluded
 , tfwScriptingInterfaces
;

type
 TkwInnerIncluded = class(TkwIncluded)
  protected
   procedure FillContext(const anOldContext: TtfwContext;
    var theNewContext: TtfwContext); override;
 end;//TkwInnerIncluded
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , l3ParserInterfaces
;

procedure TkwInnerIncluded.FillContext(const anOldContext: TtfwContext;
 var theNewContext: TtfwContext);
//#UC START# *4F3AA59B025A_4F3AA545006F_var*
var
 l_F : TtfwKeywordFinder;
 l_C : TtfwCompiler;
//#UC END# *4F3AA59B025A_4F3AA545006F_var*
begin
//#UC START# *4F3AA59B025A_4F3AA545006F_impl*
 inherited;
 //l_P.KeyWords := aCtx.rEngine.As_Il3KeywordFinder; {!!! - чтобы слова искались в ScriptEngine}
 //l_Ctx.rCompiler := nil; {!!! - чтобы слова попадали в ScriptEngine}
 if (anOldContext.rCompiler <> nil) then
 begin
  l_F := anOldContext.rCompiler.KeywordFinder(anOldContext).ParentFinder;
  l_C := l_F;
  theNewContext.rKeyWords := l_F;
  {!!! - чтобы слова искались начиная с внутреннего слова}
  theNewContext.rCompiler := l_C;
  {!!! - чтобы слова попадали во внутреннее слово}
 end;//anOldContext.rCompiler <> nil
//#UC END# *4F3AA59B025A_4F3AA545006F_impl*
end;//TkwInnerIncluded.FillContext

initialization
!!! Lost ini !!!
 {* Регистрация TkwInnerIncluded }
{$IfEnd} // NOT Defined(NoScripts)

end.
