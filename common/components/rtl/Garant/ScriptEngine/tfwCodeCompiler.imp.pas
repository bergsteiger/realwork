{$IfNDef tfwCodeCompiler_imp}

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwCodeCompiler.imp.pas"
// Стереотип: "Impurity"

{$Define tfwCodeCompiler_imp}

{$If NOT Defined(NoScripts)}
 _tfwCodeCompiler_ = {abstract} class(_tfwCodeCompiler_Parent_)
  private
   f_Code: TtfwWordRefList;
    {* Поле для свойства Code }
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure DoAddCodePart(aWord: TtfwWord;
    const aCtx: TtfwContext;
    aSNI: TtfwSuppressNextImmediate); override;
  public
   procedure RunCode(const aCtx: TtfwContext);
   function HasCode: Boolean; override;
    {* Есть ли у слова компилированный код }
   function CodeCount: Integer; override;
    {* Число элементов скомпилированного кода }
   function GetCompiler(const aCtx: TtfwContext): TtfwWord; override;
  public
   property Code: TtfwWordRefList
    read f_Code;
 end;//_tfwCodeCompiler_

{$Else NOT Defined(NoScripts)}

_tfwCodeCompiler_ = _tfwCodeCompiler_Parent_;

{$IfEnd} // NOT Defined(NoScripts)
{$Else tfwCodeCompiler_imp}

{$IfNDef tfwCodeCompiler_imp_impl}

{$Define tfwCodeCompiler_imp_impl}

{$If NOT Defined(NoScripts)}
procedure _tfwCodeCompiler_.RunCode(const aCtx: TtfwContext);
//#UC START# *55A4EA4402A7_55A4E9940396_var*
var
 l_Index : Integer;
//#UC END# *55A4EA4402A7_55A4E9940396_var*
begin
//#UC START# *55A4EA4402A7_55A4E9940396_impl*
 if (Code <> nil) then
  for l_Index := 0 to Pred(Code.Count) do
   Code[l_Index].DoIt(aCtx);
//#UC END# *55A4EA4402A7_55A4E9940396_impl*
end;//_tfwCodeCompiler_.RunCode

procedure _tfwCodeCompiler_.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_55A4E9940396_var*
//#UC END# *479731C50290_55A4E9940396_var*
begin
//#UC START# *479731C50290_55A4E9940396_impl*
 FreeandNil(f_Code);
 inherited;
//#UC END# *479731C50290_55A4E9940396_impl*
end;//_tfwCodeCompiler_.Cleanup

procedure _tfwCodeCompiler_.DoAddCodePart(aWord: TtfwWord;
 const aCtx: TtfwContext;
 aSNI: TtfwSuppressNextImmediate);
//#UC START# *4DB6CB1703AD_55A4E9940396_var*
var
 l_Holder : TtfwWord;
//#UC END# *4DB6CB1703AD_55A4E9940396_var*
begin
//#UC START# *4DB6CB1703AD_55A4E9940396_impl*
 CompilerAssert(aWord <> Self, 'Циклическая ссылка', aCtx);
 // - чтобы избежать циклических ссылок
 if (f_Code = nil) then
  f_Code := TtfwWordRefList.Create;
(* if aWord.IsForwardDeclaration {AND
    (TkwForwardDeclaration(aWord).RealWord = Self)}
    // - проверка специально убрана, т.к. бывает вложенность
    then
 // - чтобы избежать циклических ссылок*)
 begin
  l_Holder := aWord.MakeRefForCompile(aCtx, aSNI);
  try
   f_Code.Add(l_Holder);
  finally
   FreeAndNil(l_Holder);
  end;//try..finally
 end//aWord.IsForwardDeclaration
(* else
  f_Code.Add(aWord)*)
 ;
//#UC END# *4DB6CB1703AD_55A4E9940396_impl*
end;//_tfwCodeCompiler_.DoAddCodePart

function _tfwCodeCompiler_.HasCode: Boolean;
 {* Есть ли у слова компилированный код }
//#UC START# *52D40F640308_55A4E9940396_var*
//#UC END# *52D40F640308_55A4E9940396_var*
begin
//#UC START# *52D40F640308_55A4E9940396_impl*
 Result := (Code <> nil) AND not Code.Empty;
//#UC END# *52D40F640308_55A4E9940396_impl*
end;//_tfwCodeCompiler_.HasCode

function _tfwCodeCompiler_.CodeCount: Integer;
 {* Число элементов скомпилированного кода }
//#UC START# *52D4191402A2_55A4E9940396_var*
//#UC END# *52D4191402A2_55A4E9940396_var*
begin
//#UC START# *52D4191402A2_55A4E9940396_impl*
 if (Code = nil) then
  Result := 0
 else
  Result := Code.Count; 
//#UC END# *52D4191402A2_55A4E9940396_impl*
end;//_tfwCodeCompiler_.CodeCount

function _tfwCodeCompiler_.GetCompiler(const aCtx: TtfwContext): TtfwWord;
//#UC START# *52D523A40118_55A4E9940396_var*
//#UC END# *52D523A40118_55A4E9940396_var*
begin
//#UC START# *52D523A40118_55A4E9940396_impl*
 Result := Self;
//#UC END# *52D523A40118_55A4E9940396_impl*
end;//_tfwCodeCompiler_.GetCompiler
{$IfEnd} // NOT Defined(NoScripts)

{$EndIf tfwCodeCompiler_imp_impl}

{$EndIf tfwCodeCompiler_imp}

