unit TypeInfoPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\TypeInfoPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "TypeInfoPack" MUID: (550C4C8701B4)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwTypeInfo
 , tfwGlobalKeyWord
 , tfwScriptingInterfaces
 , tfwScriptingTypes
 , TypInfo
 , l3Interfaces
 , tfwMainDictionary
 , tfwClassLike
 , tfwAxiomaticsResNameGetter
 , l3String
 , tfwScriptEngineExInterfaces
 , tfwStandardDictionaries
 , tfwStandardDictionaryListIterator
 , tfwInitedDictionariesListIterator
 , tfwDictionaryListIterator
 , tfwWordsIterator
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 //#UC START# *550C4C8701B4impl_uses*
 //#UC END# *550C4C8701B4impl_uses*
;

type
 TkwCtxIncludeModifier = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта Ctx:IncludeModifier }
  private
   procedure Ctx_IncludeModifier(const aCtx: TtfwContext;
    aModifier: TtfwWordModifier);
    {* Реализация слова скрипта Ctx:IncludeModifier }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCtxIncludeModifier

 TkwCtxPushCompiler = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта Ctx:PushCompiler }
  private
   function Ctx_PushCompiler(const aCtx: TtfwContext): TtfwCompiler;
    {* Реализация слова скрипта Ctx:PushCompiler }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCtxPushCompiler

 TkwCtxPushFinder = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта Ctx:PushFinder }
  private
   function Ctx_PushFinder(const aCtx: TtfwContext): TtfwKeywordFinder;
    {* Реализация слова скрипта Ctx:PushFinder }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCtxPushFinder

 TkwPopCompilerSetToCtx = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта pop:Compiler:SetToCtx }
  private
   procedure pop_Compiler_SetToCtx(const aCtx: TtfwContext;
    aCompiler: TtfwCompiler);
    {* Реализация слова скрипта pop:Compiler:SetToCtx }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopCompilerSetToCtx

 TkwPopFinderSetToCtx = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта pop:Finder:SetToCtx }
  private
   procedure pop_Finder_SetToCtx(const aCtx: TtfwContext;
    aFinder: TtfwKeywordFinder);
    {* Реализация слова скрипта pop:Finder:SetToCtx }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopFinderSetToCtx

 TkwNotImplemented = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта NotImplemented }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwNotImplemented

 TkwCtxNewWordDefinitor = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта Ctx:NewWordDefinitor }
  private
   function Ctx_NewWordDefinitor(const aCtx: TtfwContext): TtfwNewWordDefinitor;
    {* Реализация слова скрипта Ctx:NewWordDefinitor }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCtxNewWordDefinitor

 TkwCtxClearTypeInfo = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта Ctx:ClearTypeInfo }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCtxClearTypeInfo

 TkwCtxSetWordProducerForCompiledClass = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта Ctx:SetWordProducerForCompiledClass }
  private
   procedure Ctx_SetWordProducerForCompiledClass(const aCtx: TtfwContext;
    aProducer: TtfwWord);
    {* Реализация слова скрипта Ctx:SetWordProducerForCompiledClass }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCtxSetWordProducerForCompiledClass

 TkwCtxSetNewWordName = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта Ctx:SetNewWordName }
  private
   procedure Ctx_SetNewWordName(const aCtx: TtfwContext;
    const aValue: Il3CString);
    {* Реализация слова скрипта Ctx:SetNewWordName }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCtxSetNewWordName

 TkwCtxIncludeTypeModifier = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта Ctx:IncludeTypeModifier }
  private
   procedure Ctx_IncludeTypeModifier(const aCtx: TtfwContext;
    aType: TtfwValueType);
    {* Реализация слова скрипта Ctx:IncludeTypeModifier }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCtxIncludeTypeModifier

 TkwCtxWordDefiningNow = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта Ctx:WordDefiningNow }
  private
   function Ctx_WordDefiningNow(const aCtx: TtfwContext): TtfwWord;
    {* Реализация слова скрипта Ctx:WordDefiningNow }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCtxWordDefiningNow

 TkwCtxKeyWordDefiningNow = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта Ctx:KeyWordDefiningNow }
  private
   function Ctx_KeyWordDefiningNow(const aCtx: TtfwContext): TtfwKeyWord;
    {* Реализация слова скрипта Ctx:KeyWordDefiningNow }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCtxKeyWordDefiningNow

 TkwCtxIncludeAccessType = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта Ctx:IncludeAccessType }
  private
   procedure Ctx_IncludeAccessType(const aCtx: TtfwContext;
    anAccess: TtfwAccessType);
    {* Реализация слова скрипта Ctx:IncludeAccessType }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCtxIncludeAccessType

 TkwCtxIncludeLinkType = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта Ctx:IncludeLinkType }
  private
   procedure Ctx_IncludeLinkType(const aCtx: TtfwContext;
    aLinkType: TtfwLinkType);
    {* Реализация слова скрипта Ctx:IncludeLinkType }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCtxIncludeLinkType

 TkwCtxValueTypes = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта Ctx:ValueTypes }
  private
   function Ctx_ValueTypes(const aCtx: TtfwContext): TtfwValueTypes;
    {* Реализация слова скрипта Ctx:ValueTypes }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCtxValueTypes

 TkwCtxSetValueTypes = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта Ctx:SetValueTypes }
  private
   procedure Ctx_SetValueTypes(const aCtx: TtfwContext;
    aTypes: TtfwValueTypes);
    {* Реализация слова скрипта Ctx:SetValueTypes }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCtxSetValueTypes

 TkwCtxIncludeValueTypes = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта Ctx:IncludeValueTypes }
  private
   procedure Ctx_IncludeValueTypes(const aCtx: TtfwContext;
    aTypes: TtfwValueTypes);
    {* Реализация слова скрипта Ctx:IncludeValueTypes }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCtxIncludeValueTypes

 TkwCtxWordInfo = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта Ctx:WordInfo }
  private
   function Ctx_WordInfo(const aCtx: TtfwContext): TtfwWordInfo;
    {* Реализация слова скрипта Ctx:WordInfo }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCtxWordInfo

 TkwCtxResolveIncludedFilePath = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта Ctx:ResolveIncludedFilePath }
  private
   function Ctx_ResolveIncludedFilePath(const aCtx: TtfwContext;
    const aFileName: AnsiString): AnsiString;
    {* Реализация слова скрипта Ctx:ResolveIncludedFilePath }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCtxResolveIncludedFilePath

 TkwCtxMainDictionary = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта Ctx:MainDictionary }
  private
   function Ctx_MainDictionary(const aCtx: TtfwContext): TtfwMainDictionary;
    {* Реализация слова скрипта Ctx:MainDictionary }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCtxMainDictionary

 TkwCtxStandardDictionaries = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта Ctx:StandardDictionaries }
  private
   function Ctx_StandardDictionaries(const aCtx: TtfwContext): ItfwValueList;
    {* Реализация слова скрипта Ctx:StandardDictionaries }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCtxStandardDictionaries

 TkwCtxDictionaries = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта Ctx:Dictionaries }
  private
   function Ctx_Dictionaries(const aCtx: TtfwContext): ItfwValueList;
    {* Реализация слова скрипта Ctx:Dictionaries }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCtxDictionaries

 TkwCtxInitedDictionaries = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта Ctx:InitedDictionaries }
  private
   function Ctx_InitedDictionaries(const aCtx: TtfwContext): ItfwValueList;
    {* Реализация слова скрипта Ctx:InitedDictionaries }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCtxInitedDictionaries

 TkwCtxDisabledForHelp = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта Ctx:DisabledForHelp }
  private
   function Ctx_DisabledForHelp(const aCtx: TtfwContext): ItfwValueList;
    {* Реализация слова скрипта Ctx:DisabledForHelp }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCtxDisabledForHelp

 TkwIsArray = {final} class(TtfwClassLike)
  {* Слово скрипта IsArray }
  private
   function IsArray(const aCtx: TtfwContext;
    const aSV: TtfwStackValue): Boolean;
    {* Реализация слова скрипта IsArray }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwIsArray

 TkwIsVoid = {final} class(TtfwClassLike)
  {* Слово скрипта IsVoid }
  private
   function IsVoid(const aCtx: TtfwContext;
    const aSV: TtfwStackValue): Boolean;
    {* Реализация слова скрипта IsVoid }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwIsVoid

 TkwIsObj = {final} class(TtfwClassLike)
  {* Слово скрипта IsObj }
  private
   function IsObj(const aCtx: TtfwContext;
    const aSV: TtfwStackValue): Boolean;
    {* Реализация слова скрипта IsObj }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwIsObj

 TkwIsIntf = {final} class(TtfwClassLike)
  {* Слово скрипта IsIntf }
  private
   function IsIntf(const aCtx: TtfwContext;
    const aSV: TtfwStackValue): Boolean;
    {* Реализация слова скрипта IsIntf }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwIsIntf

 TkwIsChar = {final} class(TtfwClassLike)
  {* Слово скрипта IsChar }
  private
   function IsChar(const aCtx: TtfwContext;
    const aSV: TtfwStackValue): Boolean;
    {* Реализация слова скрипта IsChar }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwIsChar

 TkwIsString = {final} class(TtfwClassLike)
  {* Слово скрипта IsString }
  private
   function IsString(const aCtx: TtfwContext;
    const aSV: TtfwStackValue): Boolean;
    {* Реализация слова скрипта IsString }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwIsString

 TkwIsInt = {final} class(TtfwClassLike)
  {* Слово скрипта IsInt }
  private
   function IsInt(const aCtx: TtfwContext;
    const aSV: TtfwStackValue): Boolean;
    {* Реализация слова скрипта IsInt }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwIsInt

 TkwIsClass = {final} class(TtfwClassLike)
  {* Слово скрипта IsClass }
  private
   function IsClass(const aCtx: TtfwContext;
    const aSV: TtfwStackValue): Boolean;
    {* Реализация слова скрипта IsClass }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwIsClass

 TkwToPrintable = {final} class(TtfwClassLike)
  {* Слово скрипта ToPrintable }
  private
   function ToPrintable(const aCtx: TtfwContext;
    const aSV: TtfwStackValue): Il3CString;
    {* Реализация слова скрипта ToPrintable }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwToPrintable

 TkwIsBool = {final} class(TtfwClassLike)
  {* Слово скрипта IsBool }
  private
   function IsBool(const aCtx: TtfwContext;
    const aSV: TtfwStackValue): Boolean;
    {* Реализация слова скрипта IsBool }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwIsBool

 TkwIsTypeOf = {final} class(TtfwClassLike)
  {* Слово скрипта IsTypeOf }
  private
   function IsTypeOf(const aCtx: TtfwContext;
    const aSV: TtfwStackValue;
    aType: TtfwValueType): Boolean;
    {* Реализация слова скрипта IsTypeOf }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwIsTypeOf

 TkwIsNil = {final} class(TtfwClassLike)
  {* Слово скрипта IsNil }
  private
   function IsNil(const aCtx: TtfwContext;
    const aSV: TtfwStackValue): Boolean;
    {* Реализация слова скрипта IsNil }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwIsNil

 TTypeInfoPackResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
  public
   class function ResName: AnsiString; override;
 end;//TTypeInfoPackResNameGetter

procedure TkwCtxIncludeModifier.Ctx_IncludeModifier(const aCtx: TtfwContext;
 aModifier: TtfwWordModifier);
 {* Реализация слова скрипта Ctx:IncludeModifier }
//#UC START# *556C4FFA010F_556C4FFA010F_Word_var*
//#UC END# *556C4FFA010F_556C4FFA010F_Word_var*
begin
//#UC START# *556C4FFA010F_556C4FFA010F_Word_impl*
 aCtx.SetWordInfo(aCtx.rTypeInfo.IncludeModifier(aModifier));
//#UC END# *556C4FFA010F_556C4FFA010F_Word_impl*
end;//TkwCtxIncludeModifier.Ctx_IncludeModifier

class function TkwCtxIncludeModifier.GetWordNameForRegister: AnsiString;
begin
 Result := 'Ctx:IncludeModifier';
end;//TkwCtxIncludeModifier.GetWordNameForRegister

function TkwCtxIncludeModifier.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwCtxIncludeModifier.GetResultTypeInfo

function TkwCtxIncludeModifier.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCtxIncludeModifier.GetAllParamsCount

function TkwCtxIncludeModifier.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWordModifier)]);
end;//TkwCtxIncludeModifier.ParamsTypes

procedure TkwCtxIncludeModifier.DoDoIt(const aCtx: TtfwContext);
var l_aModifier: TtfwWordModifier;
begin
 try
  l_aModifier := TtfwWordModifier(aCtx.rEngine.PopInt);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aModifier: TtfwWordModifier : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 Ctx_IncludeModifier(aCtx, l_aModifier);
end;//TkwCtxIncludeModifier.DoDoIt

function TkwCtxPushCompiler.Ctx_PushCompiler(const aCtx: TtfwContext): TtfwCompiler;
 {* Реализация слова скрипта Ctx:PushCompiler }
//#UC START# *55758BEF00CE_55758BEF00CE_Word_var*
//#UC END# *55758BEF00CE_55758BEF00CE_Word_var*
begin
//#UC START# *55758BEF00CE_55758BEF00CE_Word_impl*
 Result := aCtx.rCompiler;
//#UC END# *55758BEF00CE_55758BEF00CE_Word_impl*
end;//TkwCtxPushCompiler.Ctx_PushCompiler

class function TkwCtxPushCompiler.GetWordNameForRegister: AnsiString;
begin
 Result := 'Ctx:PushCompiler';
end;//TkwCtxPushCompiler.GetWordNameForRegister

function TkwCtxPushCompiler.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TtfwCompiler);
end;//TkwCtxPushCompiler.GetResultTypeInfo

function TkwCtxPushCompiler.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwCtxPushCompiler.GetAllParamsCount

function TkwCtxPushCompiler.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwCtxPushCompiler.ParamsTypes

procedure TkwCtxPushCompiler.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushObj(Ctx_PushCompiler(aCtx));
end;//TkwCtxPushCompiler.DoDoIt

function TkwCtxPushFinder.Ctx_PushFinder(const aCtx: TtfwContext): TtfwKeywordFinder;
 {* Реализация слова скрипта Ctx:PushFinder }
//#UC START# *55758C2D003C_55758C2D003C_Word_var*
//#UC END# *55758C2D003C_55758C2D003C_Word_var*
begin
//#UC START# *55758C2D003C_55758C2D003C_Word_impl*
 Result := aCtx.rKeyWords;
//#UC END# *55758C2D003C_55758C2D003C_Word_impl*
end;//TkwCtxPushFinder.Ctx_PushFinder

class function TkwCtxPushFinder.GetWordNameForRegister: AnsiString;
begin
 Result := 'Ctx:PushFinder';
end;//TkwCtxPushFinder.GetWordNameForRegister

function TkwCtxPushFinder.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TtfwKeywordFinder);
end;//TkwCtxPushFinder.GetResultTypeInfo

function TkwCtxPushFinder.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwCtxPushFinder.GetAllParamsCount

function TkwCtxPushFinder.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwCtxPushFinder.ParamsTypes

procedure TkwCtxPushFinder.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushObj(Ctx_PushFinder(aCtx));
end;//TkwCtxPushFinder.DoDoIt

procedure TkwPopCompilerSetToCtx.pop_Compiler_SetToCtx(const aCtx: TtfwContext;
 aCompiler: TtfwCompiler);
 {* Реализация слова скрипта pop:Compiler:SetToCtx }
//#UC START# *557595A40059_557595A40059_Word_var*
//#UC END# *557595A40059_557595A40059_Word_var*
begin
//#UC START# *557595A40059_557595A40059_Word_impl*
 PtfwContext(@aCtx)^.rCompiler := aCompiler;
//#UC END# *557595A40059_557595A40059_Word_impl*
end;//TkwPopCompilerSetToCtx.pop_Compiler_SetToCtx

class function TkwPopCompilerSetToCtx.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Compiler:SetToCtx';
end;//TkwPopCompilerSetToCtx.GetWordNameForRegister

function TkwPopCompilerSetToCtx.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopCompilerSetToCtx.GetResultTypeInfo

function TkwPopCompilerSetToCtx.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopCompilerSetToCtx.GetAllParamsCount

function TkwPopCompilerSetToCtx.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwCompiler)]);
end;//TkwPopCompilerSetToCtx.ParamsTypes

procedure TkwPopCompilerSetToCtx.DoDoIt(const aCtx: TtfwContext);
var l_aCompiler: TtfwCompiler;
begin
 try
  l_aCompiler := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aCompiler: TtfwCompiler : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 pop_Compiler_SetToCtx(aCtx, l_aCompiler);
end;//TkwPopCompilerSetToCtx.DoDoIt

procedure TkwPopFinderSetToCtx.pop_Finder_SetToCtx(const aCtx: TtfwContext;
 aFinder: TtfwKeywordFinder);
 {* Реализация слова скрипта pop:Finder:SetToCtx }
//#UC START# *557595C503B0_557595C503B0_Word_var*
//#UC END# *557595C503B0_557595C503B0_Word_var*
begin
//#UC START# *557595C503B0_557595C503B0_Word_impl*
 PtfwContext(@aCtx).rKeyWords := aFinder;
//#UC END# *557595C503B0_557595C503B0_Word_impl*
end;//TkwPopFinderSetToCtx.pop_Finder_SetToCtx

class function TkwPopFinderSetToCtx.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Finder:SetToCtx';
end;//TkwPopFinderSetToCtx.GetWordNameForRegister

function TkwPopFinderSetToCtx.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopFinderSetToCtx.GetResultTypeInfo

function TkwPopFinderSetToCtx.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopFinderSetToCtx.GetAllParamsCount

function TkwPopFinderSetToCtx.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwKeywordFinder)]);
end;//TkwPopFinderSetToCtx.ParamsTypes

procedure TkwPopFinderSetToCtx.DoDoIt(const aCtx: TtfwContext);
var l_aFinder: TtfwKeywordFinder;
begin
 try
  l_aFinder := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aFinder: TtfwKeywordFinder : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 pop_Finder_SetToCtx(aCtx, l_aFinder);
end;//TkwPopFinderSetToCtx.DoDoIt

class function TkwNotImplemented.GetWordNameForRegister: AnsiString;
begin
 Result := 'NotImplemented';
end;//TkwNotImplemented.GetWordNameForRegister

function TkwNotImplemented.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwNotImplemented.GetResultTypeInfo

function TkwNotImplemented.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwNotImplemented.GetAllParamsCount

function TkwNotImplemented.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwNotImplemented.ParamsTypes

procedure TkwNotImplemented.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_55759630008C_Word_var*
//#UC END# *4DAEEDE10285_55759630008C_Word_var*
begin
//#UC START# *4DAEEDE10285_55759630008C_Word_impl*
 RunnerError('Не реализовано', aCtx);
//#UC END# *4DAEEDE10285_55759630008C_Word_impl*
end;//TkwNotImplemented.DoDoIt

function TkwCtxNewWordDefinitor.Ctx_NewWordDefinitor(const aCtx: TtfwContext): TtfwNewWordDefinitor;
 {* Реализация слова скрипта Ctx:NewWordDefinitor }
//#UC START# *558952C80024_558952C80024_Word_var*
//#UC END# *558952C80024_558952C80024_Word_var*
begin
//#UC START# *558952C80024_558952C80024_Word_impl*
 Assert(aCtx.rCompiler <> nil);
 Result := aCtx.rCompiler.NewWordDefinitor;
//#UC END# *558952C80024_558952C80024_Word_impl*
end;//TkwCtxNewWordDefinitor.Ctx_NewWordDefinitor

class function TkwCtxNewWordDefinitor.GetWordNameForRegister: AnsiString;
begin
 Result := 'Ctx:NewWordDefinitor';
end;//TkwCtxNewWordDefinitor.GetWordNameForRegister

function TkwCtxNewWordDefinitor.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TtfwNewWordDefinitor);
end;//TkwCtxNewWordDefinitor.GetResultTypeInfo

function TkwCtxNewWordDefinitor.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwCtxNewWordDefinitor.GetAllParamsCount

function TkwCtxNewWordDefinitor.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwCtxNewWordDefinitor.ParamsTypes

procedure TkwCtxNewWordDefinitor.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushObj(Ctx_NewWordDefinitor(aCtx));
end;//TkwCtxNewWordDefinitor.DoDoIt

class function TkwCtxClearTypeInfo.GetWordNameForRegister: AnsiString;
begin
 Result := 'Ctx:ClearTypeInfo';
end;//TkwCtxClearTypeInfo.GetWordNameForRegister

function TkwCtxClearTypeInfo.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwCtxClearTypeInfo.GetResultTypeInfo

function TkwCtxClearTypeInfo.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwCtxClearTypeInfo.GetAllParamsCount

function TkwCtxClearTypeInfo.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwCtxClearTypeInfo.ParamsTypes

procedure TkwCtxClearTypeInfo.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_558ABF630220_Word_var*
//#UC END# *4DAEEDE10285_558ABF630220_Word_var*
begin
//#UC START# *4DAEEDE10285_558ABF630220_Word_impl*
 aCtx.SetWordInfo(TtfwWordInfoE.Instance);
//#UC END# *4DAEEDE10285_558ABF630220_Word_impl*
end;//TkwCtxClearTypeInfo.DoDoIt

procedure TkwCtxSetWordProducerForCompiledClass.Ctx_SetWordProducerForCompiledClass(const aCtx: TtfwContext;
 aProducer: TtfwWord);
 {* Реализация слова скрипта Ctx:SetWordProducerForCompiledClass }
//#UC START# *5592C3E60149_5592C3E60149_Word_var*
//#UC END# *5592C3E60149_5592C3E60149_Word_var*
begin
//#UC START# *5592C3E60149_5592C3E60149_Word_impl*
 PtfwContext(@aCtx)^.rWordProducerForCompiledClass := aProducer;
//#UC END# *5592C3E60149_5592C3E60149_Word_impl*
end;//TkwCtxSetWordProducerForCompiledClass.Ctx_SetWordProducerForCompiledClass

class function TkwCtxSetWordProducerForCompiledClass.GetWordNameForRegister: AnsiString;
begin
 Result := 'Ctx:SetWordProducerForCompiledClass';
end;//TkwCtxSetWordProducerForCompiledClass.GetWordNameForRegister

function TkwCtxSetWordProducerForCompiledClass.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwCtxSetWordProducerForCompiledClass.GetResultTypeInfo

function TkwCtxSetWordProducerForCompiledClass.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCtxSetWordProducerForCompiledClass.GetAllParamsCount

function TkwCtxSetWordProducerForCompiledClass.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord)]);
end;//TkwCtxSetWordProducerForCompiledClass.ParamsTypes

procedure TkwCtxSetWordProducerForCompiledClass.DoDoIt(const aCtx: TtfwContext);
var l_aProducer: TtfwWord;
begin
 try
  l_aProducer := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aProducer: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 Ctx_SetWordProducerForCompiledClass(aCtx, l_aProducer);
end;//TkwCtxSetWordProducerForCompiledClass.DoDoIt

procedure TkwCtxSetNewWordName.Ctx_SetNewWordName(const aCtx: TtfwContext;
 const aValue: Il3CString);
 {* Реализация слова скрипта Ctx:SetNewWordName }
//#UC START# *5592D2500399_5592D2500399_Word_var*
//#UC END# *5592D2500399_5592D2500399_Word_var*
begin
//#UC START# *5592D2500399_5592D2500399_Word_impl*
 PtfwContext(@aCtx)^.rNewWordName := aValue;
//#UC END# *5592D2500399_5592D2500399_Word_impl*
end;//TkwCtxSetNewWordName.Ctx_SetNewWordName

class function TkwCtxSetNewWordName.GetWordNameForRegister: AnsiString;
begin
 Result := 'Ctx:SetNewWordName';
end;//TkwCtxSetNewWordName.GetWordNameForRegister

function TkwCtxSetNewWordName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwCtxSetNewWordName.GetResultTypeInfo

function TkwCtxSetNewWordName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCtxSetNewWordName.GetAllParamsCount

function TkwCtxSetNewWordName.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiString]);
end;//TkwCtxSetNewWordName.ParamsTypes

procedure TkwCtxSetNewWordName.DoDoIt(const aCtx: TtfwContext);
var l_aValue: Il3CString;
begin
 try
  l_aValue := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aValue: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 Ctx_SetNewWordName(aCtx, l_aValue);
end;//TkwCtxSetNewWordName.DoDoIt

procedure TkwCtxIncludeTypeModifier.Ctx_IncludeTypeModifier(const aCtx: TtfwContext;
 aType: TtfwValueType);
 {* Реализация слова скрипта Ctx:IncludeTypeModifier }
//#UC START# *55B265CA016E_55B265CA016E_Word_var*
//#UC END# *55B265CA016E_55B265CA016E_Word_var*
begin
//#UC START# *55B265CA016E_55B265CA016E_Word_impl*
 aCtx.SetWordInfo(aCtx.rTypeInfo.IncludeTypeModifier(aType));
//#UC END# *55B265CA016E_55B265CA016E_Word_impl*
end;//TkwCtxIncludeTypeModifier.Ctx_IncludeTypeModifier

class function TkwCtxIncludeTypeModifier.GetWordNameForRegister: AnsiString;
begin
 Result := 'Ctx:IncludeTypeModifier';
end;//TkwCtxIncludeTypeModifier.GetWordNameForRegister

function TkwCtxIncludeTypeModifier.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwCtxIncludeTypeModifier.GetResultTypeInfo

function TkwCtxIncludeTypeModifier.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCtxIncludeTypeModifier.GetAllParamsCount

function TkwCtxIncludeTypeModifier.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwValueType)]);
end;//TkwCtxIncludeTypeModifier.ParamsTypes

procedure TkwCtxIncludeTypeModifier.DoDoIt(const aCtx: TtfwContext);
var l_aType: TtfwValueType;
begin
 try
  l_aType := TtfwValueType(aCtx.rEngine.PopInt);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aType: TtfwValueType : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 Ctx_IncludeTypeModifier(aCtx, l_aType);
end;//TkwCtxIncludeTypeModifier.DoDoIt

function TkwCtxWordDefiningNow.Ctx_WordDefiningNow(const aCtx: TtfwContext): TtfwWord;
 {* Реализация слова скрипта Ctx:WordDefiningNow }
//#UC START# *55B7C3EE0240_55B7C3EE0240_Word_var*
//#UC END# *55B7C3EE0240_55B7C3EE0240_Word_var*
begin
//#UC START# *55B7C3EE0240_55B7C3EE0240_Word_impl*
 Result := aCtx.rWordDefiningNow;
//#UC END# *55B7C3EE0240_55B7C3EE0240_Word_impl*
end;//TkwCtxWordDefiningNow.Ctx_WordDefiningNow

class function TkwCtxWordDefiningNow.GetWordNameForRegister: AnsiString;
begin
 Result := 'Ctx:WordDefiningNow';
end;//TkwCtxWordDefiningNow.GetWordNameForRegister

function TkwCtxWordDefiningNow.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TtfwWord);
end;//TkwCtxWordDefiningNow.GetResultTypeInfo

function TkwCtxWordDefiningNow.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwCtxWordDefiningNow.GetAllParamsCount

function TkwCtxWordDefiningNow.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwCtxWordDefiningNow.ParamsTypes

procedure TkwCtxWordDefiningNow.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushObj(Ctx_WordDefiningNow(aCtx));
end;//TkwCtxWordDefiningNow.DoDoIt

function TkwCtxKeyWordDefiningNow.Ctx_KeyWordDefiningNow(const aCtx: TtfwContext): TtfwKeyWord;
 {* Реализация слова скрипта Ctx:KeyWordDefiningNow }
//#UC START# *55B7C4090182_55B7C4090182_Word_var*
//#UC END# *55B7C4090182_55B7C4090182_Word_var*
begin
//#UC START# *55B7C4090182_55B7C4090182_Word_impl*
 Result := aCtx.rKeyWordDefiningNow;
//#UC END# *55B7C4090182_55B7C4090182_Word_impl*
end;//TkwCtxKeyWordDefiningNow.Ctx_KeyWordDefiningNow

class function TkwCtxKeyWordDefiningNow.GetWordNameForRegister: AnsiString;
begin
 Result := 'Ctx:KeyWordDefiningNow';
end;//TkwCtxKeyWordDefiningNow.GetWordNameForRegister

function TkwCtxKeyWordDefiningNow.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TtfwKeyWord);
end;//TkwCtxKeyWordDefiningNow.GetResultTypeInfo

function TkwCtxKeyWordDefiningNow.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwCtxKeyWordDefiningNow.GetAllParamsCount

function TkwCtxKeyWordDefiningNow.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwCtxKeyWordDefiningNow.ParamsTypes

procedure TkwCtxKeyWordDefiningNow.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushObj(Ctx_KeyWordDefiningNow(aCtx));
end;//TkwCtxKeyWordDefiningNow.DoDoIt

procedure TkwCtxIncludeAccessType.Ctx_IncludeAccessType(const aCtx: TtfwContext;
 anAccess: TtfwAccessType);
 {* Реализация слова скрипта Ctx:IncludeAccessType }
//#UC START# *55BA4F6E02DD_55BA4F6E02DD_Word_var*
//#UC END# *55BA4F6E02DD_55BA4F6E02DD_Word_var*
begin
//#UC START# *55BA4F6E02DD_55BA4F6E02DD_Word_impl*
 aCtx.SetWordInfo(aCtx.rTypeInfo.IncludeAccesType(anAccess));
//#UC END# *55BA4F6E02DD_55BA4F6E02DD_Word_impl*
end;//TkwCtxIncludeAccessType.Ctx_IncludeAccessType

class function TkwCtxIncludeAccessType.GetWordNameForRegister: AnsiString;
begin
 Result := 'Ctx:IncludeAccessType';
end;//TkwCtxIncludeAccessType.GetWordNameForRegister

function TkwCtxIncludeAccessType.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwCtxIncludeAccessType.GetResultTypeInfo

function TkwCtxIncludeAccessType.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCtxIncludeAccessType.GetAllParamsCount

function TkwCtxIncludeAccessType.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwAccessType)]);
end;//TkwCtxIncludeAccessType.ParamsTypes

procedure TkwCtxIncludeAccessType.DoDoIt(const aCtx: TtfwContext);
var l_anAccess: TtfwAccessType;
begin
 try
  l_anAccess := TtfwAccessType(aCtx.rEngine.PopInt);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра anAccess: TtfwAccessType : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 Ctx_IncludeAccessType(aCtx, l_anAccess);
end;//TkwCtxIncludeAccessType.DoDoIt

procedure TkwCtxIncludeLinkType.Ctx_IncludeLinkType(const aCtx: TtfwContext;
 aLinkType: TtfwLinkType);
 {* Реализация слова скрипта Ctx:IncludeLinkType }
//#UC START# *55C23D200221_55C23D200221_Word_var*
//#UC END# *55C23D200221_55C23D200221_Word_var*
begin
//#UC START# *55C23D200221_55C23D200221_Word_impl*
 aCtx.SetWordInfo(aCtx.rTypeInfo.IncludeLinkType(aLinkType));
//#UC END# *55C23D200221_55C23D200221_Word_impl*
end;//TkwCtxIncludeLinkType.Ctx_IncludeLinkType

class function TkwCtxIncludeLinkType.GetWordNameForRegister: AnsiString;
begin
 Result := 'Ctx:IncludeLinkType';
end;//TkwCtxIncludeLinkType.GetWordNameForRegister

function TkwCtxIncludeLinkType.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwCtxIncludeLinkType.GetResultTypeInfo

function TkwCtxIncludeLinkType.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCtxIncludeLinkType.GetAllParamsCount

function TkwCtxIncludeLinkType.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwLinkType)]);
end;//TkwCtxIncludeLinkType.ParamsTypes

procedure TkwCtxIncludeLinkType.DoDoIt(const aCtx: TtfwContext);
var l_aLinkType: TtfwLinkType;
begin
 try
  l_aLinkType := TtfwLinkType(aCtx.rEngine.PopInt);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aLinkType: TtfwLinkType : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 Ctx_IncludeLinkType(aCtx, l_aLinkType);
end;//TkwCtxIncludeLinkType.DoDoIt

function TkwCtxValueTypes.Ctx_ValueTypes(const aCtx: TtfwContext): TtfwValueTypes;
 {* Реализация слова скрипта Ctx:ValueTypes }
//#UC START# *55C24AC502B5_55C24AC502B5_Word_var*
//#UC END# *55C24AC502B5_55C24AC502B5_Word_var*
begin
//#UC START# *55C24AC502B5_55C24AC502B5_Word_impl*
 Result := aCtx.rTypeInfo.ValueTypes;
//#UC END# *55C24AC502B5_55C24AC502B5_Word_impl*
end;//TkwCtxValueTypes.Ctx_ValueTypes

class function TkwCtxValueTypes.GetWordNameForRegister: AnsiString;
begin
 Result := 'Ctx:ValueTypes';
end;//TkwCtxValueTypes.GetWordNameForRegister

function TkwCtxValueTypes.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TtfwValueTypes);
end;//TkwCtxValueTypes.GetResultTypeInfo

function TkwCtxValueTypes.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwCtxValueTypes.GetAllParamsCount

function TkwCtxValueTypes.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwCtxValueTypes.ParamsTypes

procedure TkwCtxValueTypes.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushObj(Ctx_ValueTypes(aCtx));
end;//TkwCtxValueTypes.DoDoIt

procedure TkwCtxSetValueTypes.Ctx_SetValueTypes(const aCtx: TtfwContext;
 aTypes: TtfwValueTypes);
 {* Реализация слова скрипта Ctx:SetValueTypes }
//#UC START# *55C24AD80339_55C24AD80339_Word_var*
//#UC END# *55C24AD80339_55C24AD80339_Word_var*
begin
//#UC START# *55C24AD80339_55C24AD80339_Word_impl*
 aCtx.SetWordInfo(TtfwWordInfo.Make(aTypes, [], tfw_atNone, tfw_ltNone));
//#UC END# *55C24AD80339_55C24AD80339_Word_impl*
end;//TkwCtxSetValueTypes.Ctx_SetValueTypes

class function TkwCtxSetValueTypes.GetWordNameForRegister: AnsiString;
begin
 Result := 'Ctx:SetValueTypes';
end;//TkwCtxSetValueTypes.GetWordNameForRegister

function TkwCtxSetValueTypes.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwCtxSetValueTypes.GetResultTypeInfo

function TkwCtxSetValueTypes.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCtxSetValueTypes.GetAllParamsCount

function TkwCtxSetValueTypes.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwValueTypes)]);
end;//TkwCtxSetValueTypes.ParamsTypes

procedure TkwCtxSetValueTypes.DoDoIt(const aCtx: TtfwContext);
var l_aTypes: TtfwValueTypes;
begin
 try
  l_aTypes := TtfwValueTypes(aCtx.rEngine.PopObjAs(TtfwValueTypes));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aTypes: TtfwValueTypes : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 Ctx_SetValueTypes(aCtx, l_aTypes);
end;//TkwCtxSetValueTypes.DoDoIt

procedure TkwCtxIncludeValueTypes.Ctx_IncludeValueTypes(const aCtx: TtfwContext;
 aTypes: TtfwValueTypes);
 {* Реализация слова скрипта Ctx:IncludeValueTypes }
//#UC START# *55C3672C002B_55C3672C002B_Word_var*
//#UC END# *55C3672C002B_55C3672C002B_Word_var*
begin
//#UC START# *55C3672C002B_55C3672C002B_Word_impl*
 aCtx.SetWordInfo(TtfwWordInfo.Make(aCtx.rTypeInfo.ValueTypes.Add(aTypes), aCtx.rTypeInfo.Modifiers, aCtx.rTypeInfo.AccessType, aCtx.rTypeInfo.LinkType));
//#UC END# *55C3672C002B_55C3672C002B_Word_impl*
end;//TkwCtxIncludeValueTypes.Ctx_IncludeValueTypes

class function TkwCtxIncludeValueTypes.GetWordNameForRegister: AnsiString;
begin
 Result := 'Ctx:IncludeValueTypes';
end;//TkwCtxIncludeValueTypes.GetWordNameForRegister

function TkwCtxIncludeValueTypes.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwCtxIncludeValueTypes.GetResultTypeInfo

function TkwCtxIncludeValueTypes.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCtxIncludeValueTypes.GetAllParamsCount

function TkwCtxIncludeValueTypes.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwValueTypes)]);
end;//TkwCtxIncludeValueTypes.ParamsTypes

procedure TkwCtxIncludeValueTypes.DoDoIt(const aCtx: TtfwContext);
var l_aTypes: TtfwValueTypes;
begin
 try
  l_aTypes := TtfwValueTypes(aCtx.rEngine.PopObjAs(TtfwValueTypes));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aTypes: TtfwValueTypes : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 Ctx_IncludeValueTypes(aCtx, l_aTypes);
end;//TkwCtxIncludeValueTypes.DoDoIt

function TkwCtxWordInfo.Ctx_WordInfo(const aCtx: TtfwContext): TtfwWordInfo;
 {* Реализация слова скрипта Ctx:WordInfo }
//#UC START# *55C3723D02CC_55C3723D02CC_Word_var*
//#UC END# *55C3723D02CC_55C3723D02CC_Word_var*
begin
//#UC START# *55C3723D02CC_55C3723D02CC_Word_impl*
 Result := aCtx.rTypeInfo;
//#UC END# *55C3723D02CC_55C3723D02CC_Word_impl*
end;//TkwCtxWordInfo.Ctx_WordInfo

class function TkwCtxWordInfo.GetWordNameForRegister: AnsiString;
begin
 Result := 'Ctx:WordInfo';
end;//TkwCtxWordInfo.GetWordNameForRegister

function TkwCtxWordInfo.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TtfwWordInfo);
end;//TkwCtxWordInfo.GetResultTypeInfo

function TkwCtxWordInfo.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwCtxWordInfo.GetAllParamsCount

function TkwCtxWordInfo.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwCtxWordInfo.ParamsTypes

procedure TkwCtxWordInfo.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushObj(Ctx_WordInfo(aCtx));
end;//TkwCtxWordInfo.DoDoIt

function TkwCtxResolveIncludedFilePath.Ctx_ResolveIncludedFilePath(const aCtx: TtfwContext;
 const aFileName: AnsiString): AnsiString;
 {* Реализация слова скрипта Ctx:ResolveIncludedFilePath }
//#UC START# *55C8BDDC0089_55C8BDDC0089_Word_var*
//#UC END# *55C8BDDC0089_55C8BDDC0089_Word_var*
begin
//#UC START# *55C8BDDC0089_55C8BDDC0089_Word_impl*
 Result := aCtx.ResolveIncludedFilePath(aFileName);
//#UC END# *55C8BDDC0089_55C8BDDC0089_Word_impl*
end;//TkwCtxResolveIncludedFilePath.Ctx_ResolveIncludedFilePath

class function TkwCtxResolveIncludedFilePath.GetWordNameForRegister: AnsiString;
begin
 Result := 'Ctx:ResolveIncludedFilePath';
end;//TkwCtxResolveIncludedFilePath.GetWordNameForRegister

function TkwCtxResolveIncludedFilePath.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwCtxResolveIncludedFilePath.GetResultTypeInfo

function TkwCtxResolveIncludedFilePath.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCtxResolveIncludedFilePath.GetAllParamsCount

function TkwCtxResolveIncludedFilePath.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiString]);
end;//TkwCtxResolveIncludedFilePath.ParamsTypes

procedure TkwCtxResolveIncludedFilePath.DoDoIt(const aCtx: TtfwContext);
var l_aFileName: AnsiString;
begin
 try
  l_aFileName := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aFileName: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString(Ctx_ResolveIncludedFilePath(aCtx, l_aFileName));
end;//TkwCtxResolveIncludedFilePath.DoDoIt

function TkwCtxMainDictionary.Ctx_MainDictionary(const aCtx: TtfwContext): TtfwMainDictionary;
 {* Реализация слова скрипта Ctx:MainDictionary }
//#UC START# *55E9AA93019F_55E9AA93019F_Word_var*
//#UC END# *55E9AA93019F_55E9AA93019F_Word_var*
begin
//#UC START# *55E9AA93019F_55E9AA93019F_Word_impl*
 Result := (aCtx.rEngine As ItfwScriptEngineEx).MainDictionary;
//#UC END# *55E9AA93019F_55E9AA93019F_Word_impl*
end;//TkwCtxMainDictionary.Ctx_MainDictionary

class function TkwCtxMainDictionary.GetWordNameForRegister: AnsiString;
begin
 Result := 'Ctx:MainDictionary';
end;//TkwCtxMainDictionary.GetWordNameForRegister

function TkwCtxMainDictionary.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TtfwMainDictionary);
end;//TkwCtxMainDictionary.GetResultTypeInfo

function TkwCtxMainDictionary.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwCtxMainDictionary.GetAllParamsCount

function TkwCtxMainDictionary.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwCtxMainDictionary.ParamsTypes

procedure TkwCtxMainDictionary.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushObj(Ctx_MainDictionary(aCtx));
end;//TkwCtxMainDictionary.DoDoIt

function TkwCtxStandardDictionaries.Ctx_StandardDictionaries(const aCtx: TtfwContext): ItfwValueList;
 {* Реализация слова скрипта Ctx:StandardDictionaries }
//#UC START# *55E9AC7800DC_55E9AC7800DC_Word_var*
//#UC END# *55E9AC7800DC_55E9AC7800DC_Word_var*
begin
//#UC START# *55E9AC7800DC_55E9AC7800DC_Word_impl*
 Result := TtfwStandardDictionaryListIterator.Make(TtfwStandardDictionaries.Instance);
//#UC END# *55E9AC7800DC_55E9AC7800DC_Word_impl*
end;//TkwCtxStandardDictionaries.Ctx_StandardDictionaries

class function TkwCtxStandardDictionaries.GetWordNameForRegister: AnsiString;
begin
 Result := 'Ctx:StandardDictionaries';
end;//TkwCtxStandardDictionaries.GetWordNameForRegister

function TkwCtxStandardDictionaries.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(ItfwValueList);
end;//TkwCtxStandardDictionaries.GetResultTypeInfo

function TkwCtxStandardDictionaries.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwCtxStandardDictionaries.GetAllParamsCount

function TkwCtxStandardDictionaries.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwCtxStandardDictionaries.ParamsTypes

procedure TkwCtxStandardDictionaries.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushList(Ctx_StandardDictionaries(aCtx));
end;//TkwCtxStandardDictionaries.DoDoIt

function TkwCtxDictionaries.Ctx_Dictionaries(const aCtx: TtfwContext): ItfwValueList;
 {* Реализация слова скрипта Ctx:Dictionaries }
//#UC START# *55E9AD6D0320_55E9AD6D0320_Word_var*
//#UC END# *55E9AD6D0320_55E9AD6D0320_Word_var*
begin
//#UC START# *55E9AD6D0320_55E9AD6D0320_Word_impl*
 Result := TtfwDictionaryListIterator.Make((aCtx.rEngine As ItfwScriptEngineEx).Dictionaries);
//#UC END# *55E9AD6D0320_55E9AD6D0320_Word_impl*
end;//TkwCtxDictionaries.Ctx_Dictionaries

class function TkwCtxDictionaries.GetWordNameForRegister: AnsiString;
begin
 Result := 'Ctx:Dictionaries';
end;//TkwCtxDictionaries.GetWordNameForRegister

function TkwCtxDictionaries.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(ItfwValueList);
end;//TkwCtxDictionaries.GetResultTypeInfo

function TkwCtxDictionaries.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwCtxDictionaries.GetAllParamsCount

function TkwCtxDictionaries.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwCtxDictionaries.ParamsTypes

procedure TkwCtxDictionaries.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushList(Ctx_Dictionaries(aCtx));
end;//TkwCtxDictionaries.DoDoIt

function TkwCtxInitedDictionaries.Ctx_InitedDictionaries(const aCtx: TtfwContext): ItfwValueList;
 {* Реализация слова скрипта Ctx:InitedDictionaries }
//#UC START# *55E9AD8C0373_55E9AD8C0373_Word_var*
//#UC END# *55E9AD8C0373_55E9AD8C0373_Word_var*
begin
//#UC START# *55E9AD8C0373_55E9AD8C0373_Word_impl*
 Result := TtfwInitedDictionariesListIterator.Make((aCtx.rEngine As ItfwScriptEngineEx).InitedDictionaries);
//#UC END# *55E9AD8C0373_55E9AD8C0373_Word_impl*
end;//TkwCtxInitedDictionaries.Ctx_InitedDictionaries

class function TkwCtxInitedDictionaries.GetWordNameForRegister: AnsiString;
begin
 Result := 'Ctx:InitedDictionaries';
end;//TkwCtxInitedDictionaries.GetWordNameForRegister

function TkwCtxInitedDictionaries.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(ItfwValueList);
end;//TkwCtxInitedDictionaries.GetResultTypeInfo

function TkwCtxInitedDictionaries.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwCtxInitedDictionaries.GetAllParamsCount

function TkwCtxInitedDictionaries.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwCtxInitedDictionaries.ParamsTypes

procedure TkwCtxInitedDictionaries.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushList(Ctx_InitedDictionaries(aCtx));
end;//TkwCtxInitedDictionaries.DoDoIt

function TkwCtxDisabledForHelp.Ctx_DisabledForHelp(const aCtx: TtfwContext): ItfwValueList;
 {* Реализация слова скрипта Ctx:DisabledForHelp }
//#UC START# *55ED4C8402D2_55ED4C8402D2_Word_var*
//#UC END# *55ED4C8402D2_55ED4C8402D2_Word_var*
begin
//#UC START# *55ED4C8402D2_55ED4C8402D2_Word_impl*
 Result := TtfwWordsIterator.Make((aCtx.rEngine As ItfwScriptEngineEx).DisabledForHelp);
//#UC END# *55ED4C8402D2_55ED4C8402D2_Word_impl*
end;//TkwCtxDisabledForHelp.Ctx_DisabledForHelp

class function TkwCtxDisabledForHelp.GetWordNameForRegister: AnsiString;
begin
 Result := 'Ctx:DisabledForHelp';
end;//TkwCtxDisabledForHelp.GetWordNameForRegister

function TkwCtxDisabledForHelp.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(ItfwValueList);
end;//TkwCtxDisabledForHelp.GetResultTypeInfo

function TkwCtxDisabledForHelp.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwCtxDisabledForHelp.GetAllParamsCount

function TkwCtxDisabledForHelp.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwCtxDisabledForHelp.ParamsTypes

procedure TkwCtxDisabledForHelp.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushList(Ctx_DisabledForHelp(aCtx));
end;//TkwCtxDisabledForHelp.DoDoIt

function TkwIsArray.IsArray(const aCtx: TtfwContext;
 const aSV: TtfwStackValue): Boolean;
 {* Реализация слова скрипта IsArray }
//#UC START# *550C4CAD0164_550C4CAD0164_4DB00A510300_Word_var*
//#UC END# *550C4CAD0164_550C4CAD0164_4DB00A510300_Word_var*
begin
//#UC START# *550C4CAD0164_550C4CAD0164_4DB00A510300_Word_impl*
 Result := (aSV.rType = tfw_vtList);
//#UC END# *550C4CAD0164_550C4CAD0164_4DB00A510300_Word_impl*
end;//TkwIsArray.IsArray

class function TkwIsArray.GetWordNameForRegister: AnsiString;
begin
 Result := 'IsArray';
end;//TkwIsArray.GetWordNameForRegister

function TkwIsArray.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwIsArray.GetResultTypeInfo

function TkwIsArray.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwIsArray.GetAllParamsCount

function TkwIsArray.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiStruct]);
end;//TkwIsArray.ParamsTypes

procedure TkwIsArray.DoDoIt(const aCtx: TtfwContext);
var l_aSV: TtfwStackValue;
begin
 try
  l_aSV := aCtx.rEngine.Pop;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aSV: TtfwStackValue : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(IsArray(aCtx, l_aSV));
end;//TkwIsArray.DoDoIt

function TkwIsVoid.IsVoid(const aCtx: TtfwContext;
 const aSV: TtfwStackValue): Boolean;
 {* Реализация слова скрипта IsVoid }
//#UC START# *550C4CC90359_550C4CC90359_4DB00A510300_Word_var*
//#UC END# *550C4CC90359_550C4CC90359_4DB00A510300_Word_var*
begin
//#UC START# *550C4CC90359_550C4CC90359_4DB00A510300_Word_impl*
 Result := (aSV.rType = tfw_vtVoid);
//#UC END# *550C4CC90359_550C4CC90359_4DB00A510300_Word_impl*
end;//TkwIsVoid.IsVoid

class function TkwIsVoid.GetWordNameForRegister: AnsiString;
begin
 Result := 'IsVoid';
end;//TkwIsVoid.GetWordNameForRegister

function TkwIsVoid.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwIsVoid.GetResultTypeInfo

function TkwIsVoid.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwIsVoid.GetAllParamsCount

function TkwIsVoid.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiStruct]);
end;//TkwIsVoid.ParamsTypes

procedure TkwIsVoid.DoDoIt(const aCtx: TtfwContext);
var l_aSV: TtfwStackValue;
begin
 try
  l_aSV := aCtx.rEngine.Pop;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aSV: TtfwStackValue : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(IsVoid(aCtx, l_aSV));
end;//TkwIsVoid.DoDoIt

function TkwIsObj.IsObj(const aCtx: TtfwContext;
 const aSV: TtfwStackValue): Boolean;
 {* Реализация слова скрипта IsObj }
//#UC START# *550C4CD40062_550C4CD40062_4DB00A510300_Word_var*
//#UC END# *550C4CD40062_550C4CD40062_4DB00A510300_Word_var*
begin
//#UC START# *550C4CD40062_550C4CD40062_4DB00A510300_Word_impl*
 Result := (aSV.rType = tfw_vtObj);
//#UC END# *550C4CD40062_550C4CD40062_4DB00A510300_Word_impl*
end;//TkwIsObj.IsObj

class function TkwIsObj.GetWordNameForRegister: AnsiString;
begin
 Result := 'IsObj';
end;//TkwIsObj.GetWordNameForRegister

function TkwIsObj.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwIsObj.GetResultTypeInfo

function TkwIsObj.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwIsObj.GetAllParamsCount

function TkwIsObj.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiStruct]);
end;//TkwIsObj.ParamsTypes

procedure TkwIsObj.DoDoIt(const aCtx: TtfwContext);
var l_aSV: TtfwStackValue;
begin
 try
  l_aSV := aCtx.rEngine.Pop;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aSV: TtfwStackValue : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(IsObj(aCtx, l_aSV));
end;//TkwIsObj.DoDoIt

function TkwIsIntf.IsIntf(const aCtx: TtfwContext;
 const aSV: TtfwStackValue): Boolean;
 {* Реализация слова скрипта IsIntf }
//#UC START# *550C4CE80144_550C4CE80144_4DB00A510300_Word_var*
//#UC END# *550C4CE80144_550C4CE80144_4DB00A510300_Word_var*
begin
//#UC START# *550C4CE80144_550C4CE80144_4DB00A510300_Word_impl*
 Result := (aSV.rType = tfw_vtIntf);
//#UC END# *550C4CE80144_550C4CE80144_4DB00A510300_Word_impl*
end;//TkwIsIntf.IsIntf

class function TkwIsIntf.GetWordNameForRegister: AnsiString;
begin
 Result := 'IsIntf';
end;//TkwIsIntf.GetWordNameForRegister

function TkwIsIntf.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwIsIntf.GetResultTypeInfo

function TkwIsIntf.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwIsIntf.GetAllParamsCount

function TkwIsIntf.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiStruct]);
end;//TkwIsIntf.ParamsTypes

procedure TkwIsIntf.DoDoIt(const aCtx: TtfwContext);
var l_aSV: TtfwStackValue;
begin
 try
  l_aSV := aCtx.rEngine.Pop;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aSV: TtfwStackValue : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(IsIntf(aCtx, l_aSV));
end;//TkwIsIntf.DoDoIt

function TkwIsChar.IsChar(const aCtx: TtfwContext;
 const aSV: TtfwStackValue): Boolean;
 {* Реализация слова скрипта IsChar }
//#UC START# *550C4D090151_550C4D090151_4DB00A510300_Word_var*
//#UC END# *550C4D090151_550C4D090151_4DB00A510300_Word_var*
begin
//#UC START# *550C4D090151_550C4D090151_4DB00A510300_Word_impl*
 Result := (aSV.rType = tfw_vtChar);
//#UC END# *550C4D090151_550C4D090151_4DB00A510300_Word_impl*
end;//TkwIsChar.IsChar

class function TkwIsChar.GetWordNameForRegister: AnsiString;
begin
 Result := 'IsChar';
end;//TkwIsChar.GetWordNameForRegister

function TkwIsChar.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwIsChar.GetResultTypeInfo

function TkwIsChar.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwIsChar.GetAllParamsCount

function TkwIsChar.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiStruct]);
end;//TkwIsChar.ParamsTypes

procedure TkwIsChar.DoDoIt(const aCtx: TtfwContext);
var l_aSV: TtfwStackValue;
begin
 try
  l_aSV := aCtx.rEngine.Pop;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aSV: TtfwStackValue : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(IsChar(aCtx, l_aSV));
end;//TkwIsChar.DoDoIt

function TkwIsString.IsString(const aCtx: TtfwContext;
 const aSV: TtfwStackValue): Boolean;
 {* Реализация слова скрипта IsString }
//#UC START# *550C4D18007D_550C4D18007D_4DB00A510300_Word_var*
//#UC END# *550C4D18007D_550C4D18007D_4DB00A510300_Word_var*
begin
//#UC START# *550C4D18007D_550C4D18007D_4DB00A510300_Word_impl*
 Result := (aSV.rType = tfw_vtStr);
//#UC END# *550C4D18007D_550C4D18007D_4DB00A510300_Word_impl*
end;//TkwIsString.IsString

class function TkwIsString.GetWordNameForRegister: AnsiString;
begin
 Result := 'IsString';
end;//TkwIsString.GetWordNameForRegister

function TkwIsString.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwIsString.GetResultTypeInfo

function TkwIsString.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwIsString.GetAllParamsCount

function TkwIsString.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiStruct]);
end;//TkwIsString.ParamsTypes

procedure TkwIsString.DoDoIt(const aCtx: TtfwContext);
var l_aSV: TtfwStackValue;
begin
 try
  l_aSV := aCtx.rEngine.Pop;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aSV: TtfwStackValue : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(IsString(aCtx, l_aSV));
end;//TkwIsString.DoDoIt

function TkwIsInt.IsInt(const aCtx: TtfwContext;
 const aSV: TtfwStackValue): Boolean;
 {* Реализация слова скрипта IsInt }
//#UC START# *550C4D2701DA_550C4D2701DA_4DB00A510300_Word_var*
//#UC END# *550C4D2701DA_550C4D2701DA_4DB00A510300_Word_var*
begin
//#UC START# *550C4D2701DA_550C4D2701DA_4DB00A510300_Word_impl*
 Result := (aSV.rType = tfw_vtInt);
//#UC END# *550C4D2701DA_550C4D2701DA_4DB00A510300_Word_impl*
end;//TkwIsInt.IsInt

class function TkwIsInt.GetWordNameForRegister: AnsiString;
begin
 Result := 'IsInt';
end;//TkwIsInt.GetWordNameForRegister

function TkwIsInt.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwIsInt.GetResultTypeInfo

function TkwIsInt.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwIsInt.GetAllParamsCount

function TkwIsInt.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiStruct]);
end;//TkwIsInt.ParamsTypes

procedure TkwIsInt.DoDoIt(const aCtx: TtfwContext);
var l_aSV: TtfwStackValue;
begin
 try
  l_aSV := aCtx.rEngine.Pop;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aSV: TtfwStackValue : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(IsInt(aCtx, l_aSV));
end;//TkwIsInt.DoDoIt

function TkwIsClass.IsClass(const aCtx: TtfwContext;
 const aSV: TtfwStackValue): Boolean;
 {* Реализация слова скрипта IsClass }
//#UC START# *550C4D490048_550C4D490048_4DB00A510300_Word_var*
//#UC END# *550C4D490048_550C4D490048_4DB00A510300_Word_var*
begin
//#UC START# *550C4D490048_550C4D490048_4DB00A510300_Word_impl*
 Result := (aSV.rType = tfw_vtClass);
//#UC END# *550C4D490048_550C4D490048_4DB00A510300_Word_impl*
end;//TkwIsClass.IsClass

class function TkwIsClass.GetWordNameForRegister: AnsiString;
begin
 Result := 'IsClass';
end;//TkwIsClass.GetWordNameForRegister

function TkwIsClass.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwIsClass.GetResultTypeInfo

function TkwIsClass.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwIsClass.GetAllParamsCount

function TkwIsClass.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiStruct]);
end;//TkwIsClass.ParamsTypes

procedure TkwIsClass.DoDoIt(const aCtx: TtfwContext);
var l_aSV: TtfwStackValue;
begin
 try
  l_aSV := aCtx.rEngine.Pop;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aSV: TtfwStackValue : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(IsClass(aCtx, l_aSV));
end;//TkwIsClass.DoDoIt

function TkwToPrintable.ToPrintable(const aCtx: TtfwContext;
 const aSV: TtfwStackValue): Il3CString;
 {* Реализация слова скрипта ToPrintable }
//#UC START# *550C4D5800ED_550C4D5800ED_4DB00A510300_Word_var*
//#UC END# *550C4D5800ED_550C4D5800ED_4DB00A510300_Word_var*
begin
//#UC START# *550C4D5800ED_550C4D5800ED_4DB00A510300_Word_impl*
 Result := aSV.AsPrintable;
//#UC END# *550C4D5800ED_550C4D5800ED_4DB00A510300_Word_impl*
end;//TkwToPrintable.ToPrintable

class function TkwToPrintable.GetWordNameForRegister: AnsiString;
begin
 Result := 'ToPrintable';
end;//TkwToPrintable.GetWordNameForRegister

function TkwToPrintable.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwToPrintable.GetResultTypeInfo

function TkwToPrintable.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwToPrintable.GetAllParamsCount

function TkwToPrintable.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiStruct]);
end;//TkwToPrintable.ParamsTypes

procedure TkwToPrintable.DoDoIt(const aCtx: TtfwContext);
var l_aSV: TtfwStackValue;
begin
 try
  l_aSV := aCtx.rEngine.Pop;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aSV: TtfwStackValue : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString(ToPrintable(aCtx, l_aSV));
end;//TkwToPrintable.DoDoIt

function TkwIsBool.IsBool(const aCtx: TtfwContext;
 const aSV: TtfwStackValue): Boolean;
 {* Реализация слова скрипта IsBool }
//#UC START# *55194C770296_55194C770296_4DB00A510300_Word_var*
//#UC END# *55194C770296_55194C770296_4DB00A510300_Word_var*
begin
//#UC START# *55194C770296_55194C770296_4DB00A510300_Word_impl*
 Result := (aSV.rType = tfw_vtBool);
//#UC END# *55194C770296_55194C770296_4DB00A510300_Word_impl*
end;//TkwIsBool.IsBool

class function TkwIsBool.GetWordNameForRegister: AnsiString;
begin
 Result := 'IsBool';
end;//TkwIsBool.GetWordNameForRegister

function TkwIsBool.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwIsBool.GetResultTypeInfo

function TkwIsBool.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwIsBool.GetAllParamsCount

function TkwIsBool.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiStruct]);
end;//TkwIsBool.ParamsTypes

procedure TkwIsBool.DoDoIt(const aCtx: TtfwContext);
var l_aSV: TtfwStackValue;
begin
 try
  l_aSV := aCtx.rEngine.Pop;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aSV: TtfwStackValue : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(IsBool(aCtx, l_aSV));
end;//TkwIsBool.DoDoIt

function TkwIsTypeOf.IsTypeOf(const aCtx: TtfwContext;
 const aSV: TtfwStackValue;
 aType: TtfwValueType): Boolean;
 {* Реализация слова скрипта IsTypeOf }
//#UC START# *556C4FAF0177_556C4FAF0177_4DB00A510300_Word_var*
//#UC END# *556C4FAF0177_556C4FAF0177_4DB00A510300_Word_var*
begin
//#UC START# *556C4FAF0177_556C4FAF0177_4DB00A510300_Word_impl*
 Result := (aSV.rType = aType);
//#UC END# *556C4FAF0177_556C4FAF0177_4DB00A510300_Word_impl*
end;//TkwIsTypeOf.IsTypeOf

class function TkwIsTypeOf.GetWordNameForRegister: AnsiString;
begin
 Result := 'IsTypeOf';
end;//TkwIsTypeOf.GetWordNameForRegister

function TkwIsTypeOf.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwIsTypeOf.GetResultTypeInfo

function TkwIsTypeOf.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwIsTypeOf.GetAllParamsCount

function TkwIsTypeOf.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiStruct, TypeInfo(TtfwValueType)]);
end;//TkwIsTypeOf.ParamsTypes

procedure TkwIsTypeOf.DoDoIt(const aCtx: TtfwContext);
var l_aSV: TtfwStackValue;
var l_aType: TtfwValueType;
begin
 try
  l_aSV := aCtx.rEngine.Pop;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aSV: TtfwStackValue : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aType := TtfwValueType(aCtx.rEngine.PopInt);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aType: TtfwValueType : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(IsTypeOf(aCtx, l_aSV, l_aType));
end;//TkwIsTypeOf.DoDoIt

function TkwIsNil.IsNil(const aCtx: TtfwContext;
 const aSV: TtfwStackValue): Boolean;
 {* Реализация слова скрипта IsNil }
//#UC START# *559BF785003F_559BF785003F_4DB00A510300_Word_var*
//#UC END# *559BF785003F_559BF785003F_4DB00A510300_Word_var*
begin
//#UC START# *559BF785003F_559BF785003F_4DB00A510300_Word_impl*
 Case aSV.rType of
  tfw_vtNil:
   Result := true;
  tfw_vtVoid:
   Result := false;
  tfw_vtInt:
   Result := false;
  tfw_vtBool:
   Result := false;
  tfw_vtChar:
   Result := false;
  tfw_vtClass:
   Result := (aSV.AsClass = nil);
  tfw_vtObj:
   Result := (aSV.AsObject = nil);
  tfw_vtIntf:
   Result := (aSV.AsIntf = nil);
  tfw_vtFile:
   Result := (aSV.AsIntf = nil);
  tfw_vtList:
   Result := (aSV.AsIntf = nil);
  tfw_vtStr:
   Result := l3IsNil(aSV.AsString);
  else
  begin
   Result := false;
   BadValueType(aSV.rType, aCtx);
  end;//else
 end;//Case aSV.rType
//#UC END# *559BF785003F_559BF785003F_4DB00A510300_Word_impl*
end;//TkwIsNil.IsNil

class function TkwIsNil.GetWordNameForRegister: AnsiString;
begin
 Result := 'IsNil';
end;//TkwIsNil.GetWordNameForRegister

function TkwIsNil.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwIsNil.GetResultTypeInfo

function TkwIsNil.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwIsNil.GetAllParamsCount

function TkwIsNil.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiStruct]);
end;//TkwIsNil.ParamsTypes

procedure TkwIsNil.DoDoIt(const aCtx: TtfwContext);
var l_aSV: TtfwStackValue;
begin
 try
  l_aSV := aCtx.rEngine.Pop;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aSV: TtfwStackValue : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(IsNil(aCtx, l_aSV));
end;//TkwIsNil.DoDoIt

class function TTypeInfoPackResNameGetter.ResName: AnsiString;
begin
 Result := 'TypeInfoPack';
end;//TTypeInfoPackResNameGetter.ResName

{$R TypeInfoPack.res}

initialization
 TkwCtxIncludeModifier.RegisterInEngine;
 {* Регистрация Ctx_IncludeModifier }
 TkwCtxPushCompiler.RegisterInEngine;
 {* Регистрация Ctx_PushCompiler }
 TkwCtxPushFinder.RegisterInEngine;
 {* Регистрация Ctx_PushFinder }
 TkwPopCompilerSetToCtx.RegisterInEngine;
 {* Регистрация pop_Compiler_SetToCtx }
 TkwPopFinderSetToCtx.RegisterInEngine;
 {* Регистрация pop_Finder_SetToCtx }
 TkwNotImplemented.RegisterInEngine;
 {* Регистрация NotImplemented }
 TkwCtxNewWordDefinitor.RegisterInEngine;
 {* Регистрация Ctx_NewWordDefinitor }
 TkwCtxClearTypeInfo.RegisterInEngine;
 {* Регистрация Ctx_ClearTypeInfo }
 TkwCtxSetWordProducerForCompiledClass.RegisterInEngine;
 {* Регистрация Ctx_SetWordProducerForCompiledClass }
 TkwCtxSetNewWordName.RegisterInEngine;
 {* Регистрация Ctx_SetNewWordName }
 TkwCtxIncludeTypeModifier.RegisterInEngine;
 {* Регистрация Ctx_IncludeTypeModifier }
 TkwCtxWordDefiningNow.RegisterInEngine;
 {* Регистрация Ctx_WordDefiningNow }
 TkwCtxKeyWordDefiningNow.RegisterInEngine;
 {* Регистрация Ctx_KeyWordDefiningNow }
 TkwCtxIncludeAccessType.RegisterInEngine;
 {* Регистрация Ctx_IncludeAccessType }
 TkwCtxIncludeLinkType.RegisterInEngine;
 {* Регистрация Ctx_IncludeLinkType }
 TkwCtxValueTypes.RegisterInEngine;
 {* Регистрация Ctx_ValueTypes }
 TkwCtxSetValueTypes.RegisterInEngine;
 {* Регистрация Ctx_SetValueTypes }
 TkwCtxIncludeValueTypes.RegisterInEngine;
 {* Регистрация Ctx_IncludeValueTypes }
 TkwCtxWordInfo.RegisterInEngine;
 {* Регистрация Ctx_WordInfo }
 TkwCtxResolveIncludedFilePath.RegisterInEngine;
 {* Регистрация Ctx_ResolveIncludedFilePath }
 TkwCtxMainDictionary.RegisterInEngine;
 {* Регистрация Ctx_MainDictionary }
 TkwCtxStandardDictionaries.RegisterInEngine;
 {* Регистрация Ctx_StandardDictionaries }
 TkwCtxDictionaries.RegisterInEngine;
 {* Регистрация Ctx_Dictionaries }
 TkwCtxInitedDictionaries.RegisterInEngine;
 {* Регистрация Ctx_InitedDictionaries }
 TkwCtxDisabledForHelp.RegisterInEngine;
 {* Регистрация Ctx_DisabledForHelp }
 TkwIsArray.RegisterInEngine;
 {* Регистрация IsArray }
 TkwIsVoid.RegisterInEngine;
 {* Регистрация IsVoid }
 TkwIsObj.RegisterInEngine;
 {* Регистрация IsObj }
 TkwIsIntf.RegisterInEngine;
 {* Регистрация IsIntf }
 TkwIsChar.RegisterInEngine;
 {* Регистрация IsChar }
 TkwIsString.RegisterInEngine;
 {* Регистрация IsString }
 TkwIsInt.RegisterInEngine;
 {* Регистрация IsInt }
 TkwIsClass.RegisterInEngine;
 {* Регистрация IsClass }
 TkwToPrintable.RegisterInEngine;
 {* Регистрация ToPrintable }
 TkwIsBool.RegisterInEngine;
 {* Регистрация IsBool }
 TkwIsTypeOf.RegisterInEngine;
 {* Регистрация IsTypeOf }
 TkwIsNil.RegisterInEngine;
 {* Регистрация IsNil }
 TTypeInfoPackResNameGetter.Register;
 {* Регистрация скриптованой аксиоматики }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwStackValue }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* Регистрация типа Boolean }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа Il3CString }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwCompiler));
 {* Регистрация типа TtfwCompiler }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwKeywordFinder));
 {* Регистрация типа TtfwKeywordFinder }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwNewWordDefinitor));
 {* Регистрация типа TtfwNewWordDefinitor }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwWord));
 {* Регистрация типа TtfwWord }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwKeyWord));
 {* Регистрация типа TtfwKeyWord }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwValueTypes));
 {* Регистрация типа TtfwValueTypes }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwWordInfo));
 {* Регистрация типа TtfwWordInfo }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа AnsiString }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwMainDictionary));
 {* Регистрация типа TtfwMainDictionary }
 TtfwTypeRegistrator.RegisterType(TypeInfo(ItfwValueList));
 {* Регистрация типа ItfwValueList }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwValueType));
 {* Регистрация типа TtfwValueType }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwWordModifier));
 {* Регистрация типа TtfwWordModifier }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwAccessType));
 {* Регистрация типа TtfwAccessType }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwLinkType));
 {* Регистрация типа TtfwLinkType }
{$IfEnd} // NOT Defined(NoScripts)

end.
