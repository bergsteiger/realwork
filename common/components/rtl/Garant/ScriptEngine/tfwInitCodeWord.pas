unit tfwInitCodeWord;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwInitCodeWord.pas"
// Стереотип: "SimpleClass"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwScriptingInterfaces
 , tfwDictionaryExPrim
 , tfwDictionaryPrim
 , l3Interfaces
 , l3Variant
 , tfwWordRefList
;

type
 _tfwCodeCompiler_Parent_ = TtfwWord;
 {$Include w:\common\components\rtl\Garant\ScriptEngine\tfwCodeCompiler.imp.pas}
 TtfwInitCodeWord = class(_tfwCodeCompiler_)
  private
   f_Dictionary: TtfwDictionaryExPrim;
    {* Поле для свойства Dictionary }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   function pm_GetInnerDictionary: TtfwDictionaryPrim; override;
   function GetNewWordDefinitor: TtfwWord; override;
   procedure DoCompileInParameterPopCode(const aContext: TtfwContext;
    aParameterToPop: TtfwWord;
    aCheckCode: Boolean); override;
  public
   constructor Create(aDictionary: TtfwDictionaryExPrim); reintroduce;
   function DoDefineInParameter(const aCtx: TtfwContext;
    const aParamName: Il3CString;
    aStereo: TtfwWord;
    aTypeInfo: TtfwWordInfo): TtfwWord; override;
    {* Определяет слову входной параметр }
   function GetKeywordFinder(const aCtx: TtfwContext): TtfwWord; override;
   function DoCheckWord(const aName: Il3CString): TtfwKeyWord; override;
   function GetKeywordByName(const aName: Il3CString): Tl3PrimString; override;
   function GetParentFinder: TtfwWord; override;
  public
   property Dictionary: TtfwDictionaryExPrim
    read f_Dictionary;
 end;//TtfwInitCodeWord
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwDictionaryEx
 , tfwAutoregisteredDiction
 , kwForwardDeclarationHolder
 , SysUtils
;

{$Include w:\common\components\rtl\Garant\ScriptEngine\tfwCodeCompiler.imp.pas}

constructor TtfwInitCodeWord.Create(aDictionary: TtfwDictionaryExPrim);
//#UC START# *55A7DB260310_55A7DA0200C0_var*
//#UC END# *55A7DB260310_55A7DA0200C0_var*
begin
//#UC START# *55A7DB260310_55A7DA0200C0_impl*
 Assert(aDictionary <> nil);
 inherited Create;
 f_Dictionary := aDictionary;
//#UC END# *55A7DB260310_55A7DA0200C0_impl*
end;//TtfwInitCodeWord.Create

procedure TtfwInitCodeWord.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_55A7DA0200C0_var*
//#UC END# *4DAEEDE10285_55A7DA0200C0_var*
begin
//#UC START# *4DAEEDE10285_55A7DA0200C0_impl*
 RunCode(aCtx);
//#UC END# *4DAEEDE10285_55A7DA0200C0_impl*
end;//TtfwInitCodeWord.DoDoIt

function TtfwInitCodeWord.DoDefineInParameter(const aCtx: TtfwContext;
 const aParamName: Il3CString;
 aStereo: TtfwWord;
 aTypeInfo: TtfwWordInfo): TtfwWord;
 {* Определяет слову входной параметр }
//#UC START# *4F4161BC0024_55A7DA0200C0_var*
//#UC END# *4F4161BC0024_55A7DA0200C0_var*
begin
//#UC START# *4F4161BC0024_55A7DA0200C0_impl*
 Result := nil;
 CompilerAssert(false, 'Слово не может определять параметры', aCtx);
//#UC END# *4F4161BC0024_55A7DA0200C0_impl*
end;//TtfwInitCodeWord.DoDefineInParameter

function TtfwInitCodeWord.pm_GetInnerDictionary: TtfwDictionaryPrim;
//#UC START# *52B43311021D_55A7DA0200C0get_var*
//#UC END# *52B43311021D_55A7DA0200C0get_var*
begin
//#UC START# *52B43311021D_55A7DA0200C0get_impl*
 Result := f_Dictionary;
//#UC END# *52B43311021D_55A7DA0200C0get_impl*
end;//TtfwInitCodeWord.pm_GetInnerDictionary

function TtfwInitCodeWord.GetNewWordDefinitor: TtfwWord;
//#UC START# *52D56341033B_55A7DA0200C0_var*
//#UC END# *52D56341033B_55A7DA0200C0_var*
begin
//#UC START# *52D56341033B_55A7DA0200C0_impl*
 Result := Self;
 //Result := inherited GetNewWordDefinitor;
 //Assert(false, 'Должны ли попадать сюда?');
//#UC END# *52D56341033B_55A7DA0200C0_impl*
end;//TtfwInitCodeWord.GetNewWordDefinitor

function TtfwInitCodeWord.GetKeywordFinder(const aCtx: TtfwContext): TtfwWord;
//#UC START# *52D5637A031E_55A7DA0200C0_var*
//#UC END# *52D5637A031E_55A7DA0200C0_var*
begin
//#UC START# *52D5637A031E_55A7DA0200C0_impl*
 if aCtx.rEngine.CascadeDict then
  Result := Self
 else
  Result := aCtx.rEngine.KeywordFinder(aCtx);
//#UC END# *52D5637A031E_55A7DA0200C0_impl*
end;//TtfwInitCodeWord.GetKeywordFinder

procedure TtfwInitCodeWord.DoCompileInParameterPopCode(const aContext: TtfwContext;
 aParameterToPop: TtfwWord;
 aCheckCode: Boolean);
//#UC START# *52D56A980103_55A7DA0200C0_var*
//#UC END# *52D56A980103_55A7DA0200C0_var*
begin
//#UC START# *52D56A980103_55A7DA0200C0_impl*
 CompilerAssert(false, 'Слово не может определять параметры', aContext);
//#UC END# *52D56A980103_55A7DA0200C0_impl*
end;//TtfwInitCodeWord.DoCompileInParameterPopCode

function TtfwInitCodeWord.DoCheckWord(const aName: Il3CString): TtfwKeyWord;
//#UC START# *55A7D34102A0_55A7DA0200C0_var*
//#UC END# *55A7D34102A0_55A7DA0200C0_var*
begin
//#UC START# *55A7D34102A0_55A7DA0200C0_impl*
 Result := f_Dictionary.CheckWord(aName);
//#UC END# *55A7D34102A0_55A7DA0200C0_impl*
end;//TtfwInitCodeWord.DoCheckWord

function TtfwInitCodeWord.GetKeywordByName(const aName: Il3CString): Tl3PrimString;
//#UC START# *55ACE5210310_55A7DA0200C0_var*
//#UC END# *55ACE5210310_55A7DA0200C0_var*
begin
//#UC START# *55ACE5210310_55A7DA0200C0_impl*
 Result := f_Dictionary.DRByCName[aName];
//#UC END# *55ACE5210310_55A7DA0200C0_impl*
end;//TtfwInitCodeWord.GetKeywordByName

function TtfwInitCodeWord.GetParentFinder: TtfwWord;
//#UC START# *55ACF0F5025D_55A7DA0200C0_var*
//#UC END# *55ACF0F5025D_55A7DA0200C0_var*
begin
//#UC START# *55ACF0F5025D_55A7DA0200C0_impl*
 Result := nil;
//#UC END# *55ACF0F5025D_55A7DA0200C0_impl*
end;//TtfwInitCodeWord.GetParentFinder

initialization
 TtfwInitCodeWord.RegisterClass;
 {* Регистрация TtfwInitCodeWord }
{$IfEnd} // NOT Defined(NoScripts)

end.
