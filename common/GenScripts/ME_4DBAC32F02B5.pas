unit tfwDualWord;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwDualWord.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TtfwDualWord" MUID: (4DBAC32F02B5)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwAnonimousWord
 , tfwScriptingInterfaces
 , kwDualCompiledWordContainer
 , kwCompiledWordPrim
;

type
 TtfwDualWord = {abstract} class(TtfwAnonimousWord)
  protected
   function MedianBracket: RtfwWord; virtual; abstract;
   function MakeDualCompiled(const aContext: TtfwContext;
    aCompiled: TkwCompiledWordPrim;
    aCompiled2: TkwCompiledWordPrim): TkwDualCompiledWordContainer; virtual; abstract;
   function MedianBracket2: RtfwWord; virtual; abstract;
   procedure AfterCompile(var theNewContext: TtfwContext;
    aCompiled: TkwCompiledWordPrim); override;
  public
   function AcceptMedianBracket(aBracket: TtfwWord;
    var aCtx: TtfwContext): Boolean; override;
 end;//TtfwDualWord
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , SysUtils
;

procedure TtfwDualWord.AfterCompile(var theNewContext: TtfwContext;
 aCompiled: TkwCompiledWordPrim);
//#UC START# *4DB6CE2302C9_4DBAC32F02B5_var*
var
 l_CI : TkwDualCompiledWordContainer;
//#UC END# *4DB6CE2302C9_4DBAC32F02B5_var*
begin
//#UC START# *4DB6CE2302C9_4DBAC32F02B5_impl*
 if (theNewContext.rFirstHalfOfDualWord = nil) then
  l_CI := MakeDualCompiled(theNewContext.rPrev^, aCompiled, nil)
 else
  l_CI := MakeDualCompiled(theNewContext.rPrev^, theNewContext.rFirstHalfOfDualWord As TkwCompiledWordPrim, aCompiled);
 try
  DoCompiledWord(l_CI, theNewContext.rPrev^);
 finally
  FreeAndNil(l_CI);
 end;//try..finally
 FreeAndNil(theNewContext.rFirstHalfOfDualWord);
 inherited;
//#UC END# *4DB6CE2302C9_4DBAC32F02B5_impl*
end;//TtfwDualWord.AfterCompile

function TtfwDualWord.AcceptMedianBracket(aBracket: TtfwWord;
 var aCtx: TtfwContext): Boolean;
//#UC START# *52D7DC84019E_4DBAC32F02B5_var*
//#UC END# *52D7DC84019E_4DBAC32F02B5_var*
begin
//#UC START# *52D7DC84019E_4DBAC32F02B5_impl*
 CompilerAssert(aCtx.rFirstHalfOfDualWord = nil, 'Неожиданные данные при проверке середины структуры', aCtx);
 if (aBracket.ClassType = MedianBracket)
    OR (aBracket.ClassType = MedianBracket2) then
 begin
  Result := true;
  aCtx.rWordCompilingNow.SetRefTo(aCtx.rFirstHalfOfDualWord);
  FreeAndNil(aCtx.rWordCompilingNow);
  aCtx.rWordCompilingNow := CompiledWordClass(aCtx).Create(Self, aCtx.rPrevFinder, TtfwWordInfoE.Instance, aCtx, aBracket.Key);
  //aCtx.rWordCompilingNow.Key := aBracket.Key;
  // - чтобы под отладчиком можно было смотреть
  aCtx.rCompiler := aCtx.rWordCompilingNow.GetCompiler(aCtx) {As ItfwCompiler};
  aCtx.rKeyWords := aCtx.rCompiler.KeywordFinder(aCtx){theCompiled};
 end//aBracket.ClassType = MedianBracket..
 else
  Result := false;
//#UC END# *52D7DC84019E_4DBAC32F02B5_impl*
end;//TtfwDualWord.AcceptMedianBracket

initialization
 TtfwDualWord.RegisterClass;
 {* Регистрация TtfwDualWord }
{$IfEnd} // NOT Defined(NoScripts)

end.
