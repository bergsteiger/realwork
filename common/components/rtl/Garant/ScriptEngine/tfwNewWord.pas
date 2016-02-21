unit tfwNewWord;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwNewWord.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwCompilingWord
 , tfwScriptingInterfaces
 , kwCompiledWordPrim
 , l3Interfaces
;

type
 TtfwNewWord = {abstract} class(TtfwCompilingWord)
  protected
   procedure FinishDefinitionOfNewWord(aWordToFinish: TtfwKeyWord;
    aCompiled: TkwCompiledWordPrim;
    const aContext: TtfwContext); virtual;
    {* Завершает определение вновь созданного слова }
   function GetNewWordName(const aContext: TtfwContext): Il3CString; virtual;
   procedure BeforeCompile(var theNewContext: TtfwContext); override;
   procedure AfterCompile(var theNewContext: TtfwContext;
    aCompiled: TkwCompiledWordPrim); override;
 end;//TtfwNewWord
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , SysUtils
 , l3String
 , l3Parser
 , kwForwardDeclaration
;

procedure TtfwNewWord.FinishDefinitionOfNewWord(aWordToFinish: TtfwKeyWord;
 aCompiled: TkwCompiledWordPrim;
 const aContext: TtfwContext);
 {* Завершает определение вновь созданного слова }
//#UC START# *4F219629036A_4DB9B6D20168_var*
//#UC END# *4F219629036A_4DB9B6D20168_var*
begin
//#UC START# *4F219629036A_4DB9B6D20168_impl*
 aWordToFinish.SetWord(aContext, aCompiled);
//#UC END# *4F219629036A_4DB9B6D20168_impl*
end;//TtfwNewWord.FinishDefinitionOfNewWord

function TtfwNewWord.GetNewWordName(const aContext: TtfwContext): Il3CString;
//#UC START# *4F37B3F10318_4DB9B6D20168_var*
//#UC END# *4F37B3F10318_4DB9B6D20168_var*
begin
//#UC START# *4F37B3F10318_4DB9B6D20168_impl*
 aContext.rParser.NextToken;
 CompilerAssert(aContext.rParser.TokenType <> l3_ttInteger, 'Числа переопределять нельзя', aContext);
 Result := aContext.rParser.TokenLongString;
//#UC END# *4F37B3F10318_4DB9B6D20168_impl*
end;//TtfwNewWord.GetNewWordName

procedure TtfwNewWord.BeforeCompile(var theNewContext: TtfwContext);
//#UC START# *4DB6CDDA038B_4DB9B6D20168_var*

 function locName : Il3CString;
 begin//locName
  if (theNewContext.rWordCompilingNow.WordProducer <> nil) then
   Result := theNewContext.rWordCompilingNow.WordProducer.Key.AsCStr
  else 
  if (Self.Key <> nil) then
   Result := Self.Key.AsCStr
  else
   Result := nil;
 end;//locName

var
 l_N : Il3CString;
 l_W : TtfwKeyWord;
 l_Stereotype : Il3CString;
 l_Stereotype2 : Il3CString;
 l_C : TtfwNewWordDefinitor;
 l_CanBeMerged : Boolean;
 l_IsRedefinition : Boolean;
//#UC END# *4DB6CDDA038B_4DB9B6D20168_var*
begin
//#UC START# *4DB6CDDA038B_4DB9B6D20168_impl*
 inherited;
 l_N := theNewContext.rPrev^.rNewWordName;
 if l3IsNil(l_N) then
  l_N := GetNewWordName(theNewContext.rPrev^)
 else
  theNewContext.rPrev^.rNewWordName := nil;
 CompilerAssert(theNewContext.rPrev.rCompiler <> nil, 'Негде определять слова', theNewContext);
 l_C := theNewContext.rPrev.rCompiler.NewWordDefinitor;
 l_W := l_C.CheckWord(l_N);
 l_CanBeMerged := false;
 l_IsRedefinition := theNewContext.rPrev.rTypeInfo.Has(tfw_wmRedefinition);
 if l_IsRedefinition then
 begin
  if theNewContext.rEngine.CascadeDict then
  // - иначе пока отваливается чтение шаблонов и модели
  begin
   CompilerAssert(l_W.Word <> nil, 'Нет слова для переопределения', theNewContext);
   CompilerAssert(not l_W.Word.IsForwardDeclaration, 'Нельзя переопределять предварительное описание', theNewContext);
  end;//theNewContext.rEngine.CascadeDict
 end;//l_IsRedefinition
 if (l_W.Word <> nil) AND not l_W.Word.IsForwardDeclaration then
 begin
  if l_IsRedefinition then
  // - это переопределение
  begin
   l_CanBeMerged := true;
   theNewContext.rWordCompilingNow.Redefines := l_W.Word;
  end//theNewContext.rPrev.rTypeInfo.Has(tfw_wmRedefinition)
  else
  begin
   l_Stereotype := locName;
   CompilerAssertFmt(not l3IsNil(l_Stereotype),
                     'Не задан стереотип у дублирующегося элемента %s: %s (%s)',
                     [
                      l_W.AsString,
                      l_W.Word.ClassName,
                      l_W.ClassName
                     ],
                     theNewContext.rPrev^);
   if (l_W.Word.WordProducer <> nil) then
   begin
    l_StereoType2 := l_W.Word.WordProducer.Key.AsCStr;
    if l3Same(l_Stereotype, l_StereoType2) then
    begin
     if l_W.Word.ResultTypeInfo[theNewContext].Has(tfw_wmCanBeMerged) then
      l_CanBeMerged := true
     else
      CompilerAssertFmt(false,
                        'Совпадают стереотипы %s и %s', [l3Str(l_Stereotype), l3Str(l_StereoType2)],
                        theNewContext.rPrev^);
    end;//l_Stereotype = l_StereoType2
   end;//l_W.Word.WordProducer
   // - хорошая проверка, но для hResult и HResult - не работает !!!
   if l_CanBeMerged then
   begin
    l_W.Word.SetRefTo(theNewContext.rWordCompilingNow);
    // - подменяем текущее компилируемое слово
    theNewContext.rCompiler := theNewContext.rWordCompilingNow.GetCompiler(theNewContext.rPrev^);
    // - подменяем компилятор
   end//tfw_wmCanBeMerged in l_W.Word.Modifiers
   else
   begin
    l_N := TtfwCStringFactory.Cat([l_N, TtfwCStringFactory.C('$'), l_Stereotype]);
    // - прибавляем имя стереотипа к имени элемента и таким образом пытаемся разрешить коллизию
    //   это для того, чтобы нормально разобрать то, что вылили из Розы
    l_W := l_C.CheckWord(l_N);
   end;//tfw_wmCanBeMerged in l_W.Word.Modifiers
  end;//theNewContext.rPrev.rTypeInfo.Has(tfw_wmRedefinition)
 end;//l_W.Word <> nil
 theNewContext.rKeyWordCompilingNow := l_W;
 theNewContext.rKeyWordDefiningNow := l_W;
 theNewContext.rWordDefiningNow := theNewContext.rWordCompilingNow;
 if not l_CanBeMerged then
 begin
  if (l_W.Word <> nil) then
  begin
   if l_W.Word.IsForwardDeclaration then
   begin
    if (TkwForwardDeclaration(l_W.Word).RealWord <> nil) then
     CompilerAssertFmt(false,
                       'Предварительное определение слова %s: %s/%s (%s) уже было завершено',
                       [
                        l_W.AsString,
                        l_W.Word.ClassName,
                        TkwForwardDeclaration(l_W.Word).RealWord.ClassName,
                        l_W.ClassName
                       ],
                       theNewContext.rPrev^)
   end//l_W.Word.IsForwardDeclaration
   else
    CompilerAssertFmt(false,
                      'Слово %s: %s (%s) уже есть в словаре',
                      [
                       l_W.AsString,
                       l_W.Word.ClassName,
                       l_W.ClassName
                      ],
                      theNewContext.rPrev^);
  end;//l_W.Word <> nil
 end;//l_CanBeMerged 
//#UC END# *4DB6CDDA038B_4DB9B6D20168_impl*
end;//TtfwNewWord.BeforeCompile

procedure TtfwNewWord.AfterCompile(var theNewContext: TtfwContext;
 aCompiled: TkwCompiledWordPrim);
//#UC START# *4DB6CE2302C9_4DB9B6D20168_var*
//#UC END# *4DB6CE2302C9_4DB9B6D20168_var*
begin
//#UC START# *4DB6CE2302C9_4DB9B6D20168_impl*
 FinishDefinitionOfNewWord(theNewContext.rKeyWordCompilingNow, aCompiled, theNewContext{.rPrev^});
 theNewContext.rPrev^.rTypeInfo := TtfwWordInfoE.Instance;
 // - сбрасываем модификаторы
 inherited;
//#UC END# *4DB6CE2302C9_4DB9B6D20168_impl*
end;//TtfwNewWord.AfterCompile

initialization
 TtfwNewWord.RegisterClass;
 {* Регистрация TtfwNewWord }
{$IfEnd} // NOT Defined(NoScripts)

end.
