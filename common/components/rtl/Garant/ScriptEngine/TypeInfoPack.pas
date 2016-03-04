unit TypeInfoPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\TypeInfoPack.pas"
// Стереотип: "ScriptKeywordsPack"

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
 , tfwAxiomaticsResNameGetter
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
 , l3Interfaces
 , tfwGlobalKeyWord
 , tfwScriptingTypes
 , tfwMainDictionary
 , l3String
 , tfwScriptEngineExInterfaces
 , tfwStandardDictionaries
 , tfwStandardDictionaryListIterator
 , tfwInitedDictionariesListIterator
 , tfwDictionaryListIterator
 , tfwWordsIterator
 , tfwTypeRegistrator
 , SysUtils
;

type
 //#UC START# *B848CAD2CFA5ci*
 //#UC END# *B848CAD2CFA5ci*
 //#UC START# *B848CAD2CFA5cit*
 //#UC END# *B848CAD2CFA5cit*
 TTypeInfoPackResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
  public
   class function ResName: AnsiString; override;
 //#UC START# *B848CAD2CFA5publ*
 //#UC END# *B848CAD2CFA5publ*
 end;//TTypeInfoPackResNameGetter

 TkwIsArray = {final} class(TtfwClassLike)
  {* Слово скрипта IsArray
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aSV IsArray >>> l_Boolean
[code]  }
  private
   function IsArray(const aCtx: TtfwContext;
    const aSV: TtfwStackValue): Boolean;
    {* Реализация слова скрипта IsArray }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwIsArray

 TkwIsVoid = {final} class(TtfwClassLike)
  {* Слово скрипта IsVoid
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aSV IsVoid >>> l_Boolean
[code]  }
  private
   function IsVoid(const aCtx: TtfwContext;
    const aSV: TtfwStackValue): Boolean;
    {* Реализация слова скрипта IsVoid }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwIsVoid

 TkwIsObj = {final} class(TtfwClassLike)
  {* Слово скрипта IsObj
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aSV IsObj >>> l_Boolean
[code]  }
  private
   function IsObj(const aCtx: TtfwContext;
    const aSV: TtfwStackValue): Boolean;
    {* Реализация слова скрипта IsObj }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwIsObj

 TkwIsIntf = {final} class(TtfwClassLike)
  {* Слово скрипта IsIntf
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aSV IsIntf >>> l_Boolean
[code]  }
  private
   function IsIntf(const aCtx: TtfwContext;
    const aSV: TtfwStackValue): Boolean;
    {* Реализация слова скрипта IsIntf }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwIsIntf

 TkwIsChar = {final} class(TtfwClassLike)
  {* Слово скрипта IsChar
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aSV IsChar >>> l_Boolean
[code]  }
  private
   function IsChar(const aCtx: TtfwContext;
    const aSV: TtfwStackValue): Boolean;
    {* Реализация слова скрипта IsChar }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwIsChar

 TkwIsString = {final} class(TtfwClassLike)
  {* Слово скрипта IsString
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aSV IsString >>> l_Boolean
[code]  }
  private
   function IsString(const aCtx: TtfwContext;
    const aSV: TtfwStackValue): Boolean;
    {* Реализация слова скрипта IsString }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwIsString

 TkwIsInt = {final} class(TtfwClassLike)
  {* Слово скрипта IsInt
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aSV IsInt >>> l_Boolean
[code]  }
  private
   function IsInt(const aCtx: TtfwContext;
    const aSV: TtfwStackValue): Boolean;
    {* Реализация слова скрипта IsInt }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwIsInt

 TkwIsClass = {final} class(TtfwClassLike)
  {* Слово скрипта IsClass
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aSV IsClass >>> l_Boolean
[code]  }
  private
   function IsClass(const aCtx: TtfwContext;
    const aSV: TtfwStackValue): Boolean;
    {* Реализация слова скрипта IsClass }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwIsClass

 TkwToPrintable = {final} class(TtfwClassLike)
  {* Слово скрипта ToPrintable
*Тип результата:* Il3CString
*Пример:*
[code]
STRING VAR l_Il3CString
 aSV ToPrintable >>> l_Il3CString
[code]  }
  private
   function ToPrintable(const aCtx: TtfwContext;
    const aSV: TtfwStackValue): Il3CString;
    {* Реализация слова скрипта ToPrintable }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwToPrintable

 TkwIsBool = {final} class(TtfwClassLike)
  {* Слово скрипта IsBool
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aSV IsBool >>> l_Boolean
[code]  }
  private
   function IsBool(const aCtx: TtfwContext;
    const aSV: TtfwStackValue): Boolean;
    {* Реализация слова скрипта IsBool }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwIsBool

 TkwIsTypeOf = {final} class(TtfwClassLike)
  {* Слово скрипта IsTypeOf
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aType aSV IsTypeOf >>> l_Boolean
[code]  }
  private
   function IsTypeOf(const aCtx: TtfwContext;
    const aSV: TtfwStackValue;
    aType: TtfwValueType): Boolean;
    {* Реализация слова скрипта IsTypeOf }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwIsTypeOf

 TkwIsNil = {final} class(TtfwClassLike)
  {* Слово скрипта IsNil
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aSV IsNil >>> l_Boolean
[code]  }
  private
   function IsNil(const aCtx: TtfwContext;
    const aSV: TtfwStackValue): Boolean;
    {* Реализация слова скрипта IsNil }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwIsNil

 TkwCtxIncludeModifier = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта Ctx:IncludeModifier
[panel]Включает модификатор в информацию о типе[panel]
*Пример:*
[code]
 aModifier Ctx:IncludeModifier
[code]  }
  private
   procedure Ctx_IncludeModifier(const aCtx: TtfwContext;
    aModifier: TtfwWordModifier);
    {* Реализация слова скрипта Ctx:IncludeModifier }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCtxIncludeModifier

 TkwCtxPushCompiler = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта Ctx:PushCompiler
*Тип результата:* TtfwCompiler
*Пример:*
[code]
OBJECT VAR l_TtfwCompiler
 Ctx:PushCompiler >>> l_TtfwCompiler
[code]  }
  private
   function Ctx_PushCompiler(const aCtx: TtfwContext): TtfwCompiler;
    {* Реализация слова скрипта Ctx:PushCompiler }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCtxPushCompiler

 TkwCtxPushFinder = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта Ctx:PushFinder
*Тип результата:* TtfwKeywordFinder
*Пример:*
[code]
OBJECT VAR l_TtfwKeywordFinder
 Ctx:PushFinder >>> l_TtfwKeywordFinder
[code]  }
  private
   function Ctx_PushFinder(const aCtx: TtfwContext): TtfwKeywordFinder;
    {* Реализация слова скрипта Ctx:PushFinder }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCtxPushFinder

 TkwPopCompilerSetToCtx = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта pop:Compiler:SetToCtx
*Пример:*
[code]
 aCompiler pop:Compiler:SetToCtx
[code]  }
  private
   procedure pop_Compiler_SetToCtx(const aCtx: TtfwContext;
    aCompiler: TtfwCompiler);
    {* Реализация слова скрипта pop:Compiler:SetToCtx }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopCompilerSetToCtx

 TkwPopFinderSetToCtx = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта pop:Finder:SetToCtx
*Пример:*
[code]
 aFinder pop:Finder:SetToCtx
[code]  }
  private
   procedure pop_Finder_SetToCtx(const aCtx: TtfwContext;
    aFinder: TtfwKeywordFinder);
    {* Реализация слова скрипта pop:Finder:SetToCtx }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopFinderSetToCtx

 TkwNotImplemented = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта NotImplemented
*Пример:*
[code]
 NotImplemented
[code]  }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
 end;//TkwNotImplemented

 TkwCtxNewWordDefinitor = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта Ctx:NewWordDefinitor
*Тип результата:* TtfwNewWordDefinitor
*Пример:*
[code]
OBJECT VAR l_TtfwNewWordDefinitor
 Ctx:NewWordDefinitor >>> l_TtfwNewWordDefinitor
[code]  }
  private
   function Ctx_NewWordDefinitor(const aCtx: TtfwContext): TtfwNewWordDefinitor;
    {* Реализация слова скрипта Ctx:NewWordDefinitor }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCtxNewWordDefinitor

 TkwCtxClearTypeInfo = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта Ctx:ClearTypeInfo
*Пример:*
[code]
 Ctx:ClearTypeInfo
[code]  }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
 end;//TkwCtxClearTypeInfo

 TkwCtxSetWordProducerForCompiledClass = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта Ctx:SetWordProducerForCompiledClass
*Пример:*
[code]
 aProducer Ctx:SetWordProducerForCompiledClass
[code]  }
  private
   procedure Ctx_SetWordProducerForCompiledClass(const aCtx: TtfwContext;
    aProducer: TtfwWord);
    {* Реализация слова скрипта Ctx:SetWordProducerForCompiledClass }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCtxSetWordProducerForCompiledClass

 TkwCtxSetNewWordName = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта Ctx:SetNewWordName
*Пример:*
[code]
 aValue Ctx:SetNewWordName
[code]  }
  private
   procedure Ctx_SetNewWordName(const aCtx: TtfwContext;
    const aValue: Il3CString);
    {* Реализация слова скрипта Ctx:SetNewWordName }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCtxSetNewWordName

 TkwCtxIncludeTypeModifier = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта Ctx:IncludeTypeModifier
*Пример:*
[code]
 aType Ctx:IncludeTypeModifier
[code]  }
  private
   procedure Ctx_IncludeTypeModifier(const aCtx: TtfwContext;
    aType: TtfwValueType);
    {* Реализация слова скрипта Ctx:IncludeTypeModifier }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCtxIncludeTypeModifier

 TkwCtxWordDefiningNow = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта Ctx:WordDefiningNow
*Тип результата:* TtfwWord
*Пример:*
[code]
OBJECT VAR l_TtfwWord
 Ctx:WordDefiningNow >>> l_TtfwWord
[code]  }
  private
   function Ctx_WordDefiningNow(const aCtx: TtfwContext): TtfwWord;
    {* Реализация слова скрипта Ctx:WordDefiningNow }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCtxWordDefiningNow

 TkwCtxKeyWordDefiningNow = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта Ctx:KeyWordDefiningNow
*Тип результата:* TtfwKeyWord
*Пример:*
[code]
OBJECT VAR l_TtfwKeyWord
 Ctx:KeyWordDefiningNow >>> l_TtfwKeyWord
[code]  }
  private
   function Ctx_KeyWordDefiningNow(const aCtx: TtfwContext): TtfwKeyWord;
    {* Реализация слова скрипта Ctx:KeyWordDefiningNow }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCtxKeyWordDefiningNow

 TkwCtxIncludeAccessType = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта Ctx:IncludeAccessType
*Пример:*
[code]
 anAccess Ctx:IncludeAccessType
[code]  }
  private
   procedure Ctx_IncludeAccessType(const aCtx: TtfwContext;
    anAccess: TtfwAccessType);
    {* Реализация слова скрипта Ctx:IncludeAccessType }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCtxIncludeAccessType

 TkwCtxIncludeLinkType = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта Ctx:IncludeLinkType
*Пример:*
[code]
 aLinkType Ctx:IncludeLinkType
[code]  }
  private
   procedure Ctx_IncludeLinkType(const aCtx: TtfwContext;
    aLinkType: TtfwLinkType);
    {* Реализация слова скрипта Ctx:IncludeLinkType }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCtxIncludeLinkType

 TkwCtxValueTypes = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта Ctx:ValueTypes
*Тип результата:* TtfwValueTypes
*Пример:*
[code]
OBJECT VAR l_TtfwValueTypes
 Ctx:ValueTypes >>> l_TtfwValueTypes
[code]  }
  private
   function Ctx_ValueTypes(const aCtx: TtfwContext): TtfwValueTypes;
    {* Реализация слова скрипта Ctx:ValueTypes }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCtxValueTypes

 TkwCtxSetValueTypes = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта Ctx:SetValueTypes
*Пример:*
[code]
 aTypes Ctx:SetValueTypes
[code]  }
  private
   procedure Ctx_SetValueTypes(const aCtx: TtfwContext;
    aTypes: TtfwValueTypes);
    {* Реализация слова скрипта Ctx:SetValueTypes }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCtxSetValueTypes

 TkwCtxIncludeValueTypes = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта Ctx:IncludeValueTypes
*Пример:*
[code]
 aTypes Ctx:IncludeValueTypes
[code]  }
  private
   procedure Ctx_IncludeValueTypes(const aCtx: TtfwContext;
    aTypes: TtfwValueTypes);
    {* Реализация слова скрипта Ctx:IncludeValueTypes }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCtxIncludeValueTypes

 TkwCtxWordInfo = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта Ctx:WordInfo
*Тип результата:* TtfwWordInfo
*Пример:*
[code]
OBJECT VAR l_TtfwWordInfo
 Ctx:WordInfo >>> l_TtfwWordInfo
[code]  }
  private
   function Ctx_WordInfo(const aCtx: TtfwContext): TtfwWordInfo;
    {* Реализация слова скрипта Ctx:WordInfo }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCtxWordInfo

 TkwCtxResolveIncludedFilePath = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта Ctx:ResolveIncludedFilePath
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 aFileName Ctx:ResolveIncludedFilePath >>> l_String
[code]  }
  private
   function Ctx_ResolveIncludedFilePath(const aCtx: TtfwContext;
    const aFileName: AnsiString): AnsiString;
    {* Реализация слова скрипта Ctx:ResolveIncludedFilePath }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCtxResolveIncludedFilePath

 TkwCtxMainDictionary = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта Ctx:MainDictionary
*Тип результата:* TtfwMainDictionary
*Пример:*
[code]
OBJECT VAR l_TtfwMainDictionary
 Ctx:MainDictionary >>> l_TtfwMainDictionary
[code]  }
  private
   function Ctx_MainDictionary(const aCtx: TtfwContext): TtfwMainDictionary;
    {* Реализация слова скрипта Ctx:MainDictionary }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCtxMainDictionary

 TkwCtxStandardDictionaries = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта Ctx:StandardDictionaries
*Тип результата:* ItfwValueList
*Пример:*
[code]
ARRAY VAR l_ItfwValueList
 Ctx:StandardDictionaries >>> l_ItfwValueList
[code]  }
  private
   function Ctx_StandardDictionaries(const aCtx: TtfwContext): ItfwValueList;
    {* Реализация слова скрипта Ctx:StandardDictionaries }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCtxStandardDictionaries

 TkwCtxDictionaries = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта Ctx:Dictionaries
*Тип результата:* ItfwValueList
*Пример:*
[code]
ARRAY VAR l_ItfwValueList
 Ctx:Dictionaries >>> l_ItfwValueList
[code]  }
  private
   function Ctx_Dictionaries(const aCtx: TtfwContext): ItfwValueList;
    {* Реализация слова скрипта Ctx:Dictionaries }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCtxDictionaries

 TkwCtxInitedDictionaries = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта Ctx:InitedDictionaries
*Тип результата:* ItfwValueList
*Пример:*
[code]
ARRAY VAR l_ItfwValueList
 Ctx:InitedDictionaries >>> l_ItfwValueList
[code]  }
  private
   function Ctx_InitedDictionaries(const aCtx: TtfwContext): ItfwValueList;
    {* Реализация слова скрипта Ctx:InitedDictionaries }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCtxInitedDictionaries

 TkwCtxDisabledForHelp = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта Ctx:DisabledForHelp
*Тип результата:* ItfwValueList
*Пример:*
[code]
ARRAY VAR l_ItfwValueList
 Ctx:DisabledForHelp >>> l_ItfwValueList
[code]  }
  private
   function Ctx_DisabledForHelp(const aCtx: TtfwContext): ItfwValueList;
    {* Реализация слова скрипта Ctx:DisabledForHelp }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCtxDisabledForHelp

class function TTypeInfoPackResNameGetter.ResName: AnsiString;
begin
  Result := 'TypeInfoPack';
end;//TTypeInfoPackResNameGetter.ResName

 {$R TypeInfoPack.res}

function TkwIsArray.IsArray(const aCtx: TtfwContext;
 const aSV: TtfwStackValue): Boolean;
 {* Реализация слова скрипта IsArray }
//#UC START# *15B838867296_758F80018751_var*
//#UC END# *15B838867296_758F80018751_var*
begin
//#UC START# *15B838867296_758F80018751_impl*
 Result := (aSV.rType = tfw_vtList);
//#UC END# *15B838867296_758F80018751_impl*
end;//TkwIsArray.IsArray

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

function TkwIsVoid.IsVoid(const aCtx: TtfwContext;
 const aSV: TtfwStackValue): Boolean;
 {* Реализация слова скрипта IsVoid }
//#UC START# *C4B2F87508DA_0707D9C010E3_var*
//#UC END# *C4B2F87508DA_0707D9C010E3_var*
begin
//#UC START# *C4B2F87508DA_0707D9C010E3_impl*
 Result := (aSV.rType = tfw_vtVoid);
//#UC END# *C4B2F87508DA_0707D9C010E3_impl*
end;//TkwIsVoid.IsVoid

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

function TkwIsObj.IsObj(const aCtx: TtfwContext;
 const aSV: TtfwStackValue): Boolean;
 {* Реализация слова скрипта IsObj }
//#UC START# *99DC3EB5BE4F_257BCAC433BA_var*
//#UC END# *99DC3EB5BE4F_257BCAC433BA_var*
begin
//#UC START# *99DC3EB5BE4F_257BCAC433BA_impl*
 Result := (aSV.rType = tfw_vtObj);
//#UC END# *99DC3EB5BE4F_257BCAC433BA_impl*
end;//TkwIsObj.IsObj

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

function TkwIsIntf.IsIntf(const aCtx: TtfwContext;
 const aSV: TtfwStackValue): Boolean;
 {* Реализация слова скрипта IsIntf }
//#UC START# *2091967DFD07_475E881B9090_var*
//#UC END# *2091967DFD07_475E881B9090_var*
begin
//#UC START# *2091967DFD07_475E881B9090_impl*
 Result := (aSV.rType = tfw_vtIntf);
//#UC END# *2091967DFD07_475E881B9090_impl*
end;//TkwIsIntf.IsIntf

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

function TkwIsChar.IsChar(const aCtx: TtfwContext;
 const aSV: TtfwStackValue): Boolean;
 {* Реализация слова скрипта IsChar }
//#UC START# *07ECD13EA5B8_ACCFB9C57546_var*
//#UC END# *07ECD13EA5B8_ACCFB9C57546_var*
begin
//#UC START# *07ECD13EA5B8_ACCFB9C57546_impl*
 Result := (aSV.rType = tfw_vtChar);
//#UC END# *07ECD13EA5B8_ACCFB9C57546_impl*
end;//TkwIsChar.IsChar

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

function TkwIsString.IsString(const aCtx: TtfwContext;
 const aSV: TtfwStackValue): Boolean;
 {* Реализация слова скрипта IsString }
//#UC START# *35FB3393AF28_689D96A305FE_var*
//#UC END# *35FB3393AF28_689D96A305FE_var*
begin
//#UC START# *35FB3393AF28_689D96A305FE_impl*
 Result := (aSV.rType = tfw_vtStr);
//#UC END# *35FB3393AF28_689D96A305FE_impl*
end;//TkwIsString.IsString

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

function TkwIsInt.IsInt(const aCtx: TtfwContext;
 const aSV: TtfwStackValue): Boolean;
 {* Реализация слова скрипта IsInt }
//#UC START# *5961904482C4_1E29EA0B90A4_var*
//#UC END# *5961904482C4_1E29EA0B90A4_var*
begin
//#UC START# *5961904482C4_1E29EA0B90A4_impl*
 Result := (aSV.rType = tfw_vtInt);
//#UC END# *5961904482C4_1E29EA0B90A4_impl*
end;//TkwIsInt.IsInt

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

function TkwIsClass.IsClass(const aCtx: TtfwContext;
 const aSV: TtfwStackValue): Boolean;
 {* Реализация слова скрипта IsClass }
//#UC START# *91B47D0849F0_D8E9C4F61308_var*
//#UC END# *91B47D0849F0_D8E9C4F61308_var*
begin
//#UC START# *91B47D0849F0_D8E9C4F61308_impl*
 Result := (aSV.rType = tfw_vtClass);
//#UC END# *91B47D0849F0_D8E9C4F61308_impl*
end;//TkwIsClass.IsClass

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

function TkwToPrintable.ToPrintable(const aCtx: TtfwContext;
 const aSV: TtfwStackValue): Il3CString;
 {* Реализация слова скрипта ToPrintable }
//#UC START# *8C01CED67FCB_0B39C51FE7D1_var*
//#UC END# *8C01CED67FCB_0B39C51FE7D1_var*
begin
//#UC START# *8C01CED67FCB_0B39C51FE7D1_impl*
 Result := aSV.AsPrintable;
//#UC END# *8C01CED67FCB_0B39C51FE7D1_impl*
end;//TkwToPrintable.ToPrintable

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

function TkwIsBool.IsBool(const aCtx: TtfwContext;
 const aSV: TtfwStackValue): Boolean;
 {* Реализация слова скрипта IsBool }
//#UC START# *65885D693C21_805A190E934E_var*
//#UC END# *65885D693C21_805A190E934E_var*
begin
//#UC START# *65885D693C21_805A190E934E_impl*
 Result := (aSV.rType = tfw_vtBool);
//#UC END# *65885D693C21_805A190E934E_impl*
end;//TkwIsBool.IsBool

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

function TkwIsTypeOf.IsTypeOf(const aCtx: TtfwContext;
 const aSV: TtfwStackValue;
 aType: TtfwValueType): Boolean;
 {* Реализация слова скрипта IsTypeOf }
//#UC START# *97D860339C94_482D1ABE67DA_var*
//#UC END# *97D860339C94_482D1ABE67DA_var*
begin
//#UC START# *97D860339C94_482D1ABE67DA_impl*
 Result := (aSV.rType = aType);
//#UC END# *97D860339C94_482D1ABE67DA_impl*
end;//TkwIsTypeOf.IsTypeOf

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

function TkwIsNil.IsNil(const aCtx: TtfwContext;
 const aSV: TtfwStackValue): Boolean;
 {* Реализация слова скрипта IsNil }
//#UC START# *1AC4F2BEB556_1D17EAE13A3E_var*
//#UC END# *1AC4F2BEB556_1D17EAE13A3E_var*
begin
//#UC START# *1AC4F2BEB556_1D17EAE13A3E_impl*
 Case aSV.rType of
  tfw_vtNil:
   Result := true;
  tfw_vtVoid:
   Result := false;
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
//#UC END# *1AC4F2BEB556_1D17EAE13A3E_impl*
end;//TkwIsNil.IsNil

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

procedure TkwCtxIncludeModifier.Ctx_IncludeModifier(const aCtx: TtfwContext;
 aModifier: TtfwWordModifier);
 {* Реализация слова скрипта Ctx:IncludeModifier }
//#UC START# *38D90DF7C305_C05D38D44F64_var*
//#UC END# *38D90DF7C305_C05D38D44F64_var*
begin
//#UC START# *38D90DF7C305_C05D38D44F64_impl*
 aCtx.SetWordInfo(aCtx.rTypeInfo.IncludeModifier(aModifier));
//#UC END# *38D90DF7C305_C05D38D44F64_impl*
end;//TkwCtxIncludeModifier.Ctx_IncludeModifier

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

function TkwCtxPushCompiler.Ctx_PushCompiler(const aCtx: TtfwContext): TtfwCompiler;
 {* Реализация слова скрипта Ctx:PushCompiler }
//#UC START# *CDAA2A6A2AD7_76B2C4302847_var*
//#UC END# *CDAA2A6A2AD7_76B2C4302847_var*
begin
//#UC START# *CDAA2A6A2AD7_76B2C4302847_impl*
 Result := aCtx.rCompiler;
//#UC END# *CDAA2A6A2AD7_76B2C4302847_impl*
end;//TkwCtxPushCompiler.Ctx_PushCompiler

procedure TkwCtxPushCompiler.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushObj(Ctx_PushCompiler(aCtx));
end;//TkwCtxPushCompiler.DoDoIt

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

function TkwCtxPushFinder.Ctx_PushFinder(const aCtx: TtfwContext): TtfwKeywordFinder;
 {* Реализация слова скрипта Ctx:PushFinder }
//#UC START# *ECD8F9EEA9F6_E129F00B5D0B_var*
//#UC END# *ECD8F9EEA9F6_E129F00B5D0B_var*
begin
//#UC START# *ECD8F9EEA9F6_E129F00B5D0B_impl*
 Result := aCtx.rKeyWords;
//#UC END# *ECD8F9EEA9F6_E129F00B5D0B_impl*
end;//TkwCtxPushFinder.Ctx_PushFinder

procedure TkwCtxPushFinder.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushObj(Ctx_PushFinder(aCtx));
end;//TkwCtxPushFinder.DoDoIt

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

procedure TkwPopCompilerSetToCtx.pop_Compiler_SetToCtx(const aCtx: TtfwContext;
 aCompiler: TtfwCompiler);
 {* Реализация слова скрипта pop:Compiler:SetToCtx }
//#UC START# *7547D1BE3A40_DCE6B328F683_var*
//#UC END# *7547D1BE3A40_DCE6B328F683_var*
begin
//#UC START# *7547D1BE3A40_DCE6B328F683_impl*
 PtfwContext(@aCtx)^.rCompiler := aCompiler;
//#UC END# *7547D1BE3A40_DCE6B328F683_impl*
end;//TkwPopCompilerSetToCtx.pop_Compiler_SetToCtx

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

procedure TkwPopFinderSetToCtx.pop_Finder_SetToCtx(const aCtx: TtfwContext;
 aFinder: TtfwKeywordFinder);
 {* Реализация слова скрипта pop:Finder:SetToCtx }
//#UC START# *F415B417142F_5222729B474B_var*
//#UC END# *F415B417142F_5222729B474B_var*
begin
//#UC START# *F415B417142F_5222729B474B_impl*
 PtfwContext(@aCtx).rKeyWords := aFinder;
//#UC END# *F415B417142F_5222729B474B_impl*
end;//TkwPopFinderSetToCtx.pop_Finder_SetToCtx

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

procedure TkwNotImplemented.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_723DBAD5D836_var*
//#UC END# *4DAEEDE10285_723DBAD5D836_var*
begin
//#UC START# *4DAEEDE10285_723DBAD5D836_impl*
 RunnerError('Не реализовано', aCtx);
//#UC END# *4DAEEDE10285_723DBAD5D836_impl*
end;//TkwNotImplemented.DoDoIt

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

function TkwCtxNewWordDefinitor.Ctx_NewWordDefinitor(const aCtx: TtfwContext): TtfwNewWordDefinitor;
 {* Реализация слова скрипта Ctx:NewWordDefinitor }
//#UC START# *A3EE7AAF51AE_727C5ED83D51_var*
//#UC END# *A3EE7AAF51AE_727C5ED83D51_var*
begin
//#UC START# *A3EE7AAF51AE_727C5ED83D51_impl*
 Assert(aCtx.rCompiler <> nil);
 Result := aCtx.rCompiler.NewWordDefinitor;
//#UC END# *A3EE7AAF51AE_727C5ED83D51_impl*
end;//TkwCtxNewWordDefinitor.Ctx_NewWordDefinitor

procedure TkwCtxNewWordDefinitor.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushObj(Ctx_NewWordDefinitor(aCtx));
end;//TkwCtxNewWordDefinitor.DoDoIt

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

procedure TkwCtxClearTypeInfo.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_A118FE89A230_var*
//#UC END# *4DAEEDE10285_A118FE89A230_var*
begin
//#UC START# *4DAEEDE10285_A118FE89A230_impl*
 aCtx.SetWordInfo(TtfwWordInfoE.Instance);
//#UC END# *4DAEEDE10285_A118FE89A230_impl*
end;//TkwCtxClearTypeInfo.DoDoIt

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

procedure TkwCtxSetWordProducerForCompiledClass.Ctx_SetWordProducerForCompiledClass(const aCtx: TtfwContext;
 aProducer: TtfwWord);
 {* Реализация слова скрипта Ctx:SetWordProducerForCompiledClass }
//#UC START# *FAD614919182_6940038A26AA_var*
//#UC END# *FAD614919182_6940038A26AA_var*
begin
//#UC START# *FAD614919182_6940038A26AA_impl*
 PtfwContext(@aCtx)^.rWordProducerForCompiledClass := aProducer;
//#UC END# *FAD614919182_6940038A26AA_impl*
end;//TkwCtxSetWordProducerForCompiledClass.Ctx_SetWordProducerForCompiledClass

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

procedure TkwCtxSetNewWordName.Ctx_SetNewWordName(const aCtx: TtfwContext;
 const aValue: Il3CString);
 {* Реализация слова скрипта Ctx:SetNewWordName }
//#UC START# *88A555297CD8_C23B404259CC_var*
//#UC END# *88A555297CD8_C23B404259CC_var*
begin
//#UC START# *88A555297CD8_C23B404259CC_impl*
 PtfwContext(@aCtx)^.rNewWordName := aValue;
//#UC END# *88A555297CD8_C23B404259CC_impl*
end;//TkwCtxSetNewWordName.Ctx_SetNewWordName

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

procedure TkwCtxIncludeTypeModifier.Ctx_IncludeTypeModifier(const aCtx: TtfwContext;
 aType: TtfwValueType);
 {* Реализация слова скрипта Ctx:IncludeTypeModifier }
//#UC START# *C76389C21A2D_286CAF6C6B6A_var*
//#UC END# *C76389C21A2D_286CAF6C6B6A_var*
begin
//#UC START# *C76389C21A2D_286CAF6C6B6A_impl*
 aCtx.SetWordInfo(aCtx.rTypeInfo.IncludeTypeModifier(aType));
//#UC END# *C76389C21A2D_286CAF6C6B6A_impl*
end;//TkwCtxIncludeTypeModifier.Ctx_IncludeTypeModifier

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

function TkwCtxWordDefiningNow.Ctx_WordDefiningNow(const aCtx: TtfwContext): TtfwWord;
 {* Реализация слова скрипта Ctx:WordDefiningNow }
//#UC START# *03F9D805A35E_F9DC6877556A_var*
//#UC END# *03F9D805A35E_F9DC6877556A_var*
begin
//#UC START# *03F9D805A35E_F9DC6877556A_impl*
 Result := aCtx.rWordDefiningNow;
//#UC END# *03F9D805A35E_F9DC6877556A_impl*
end;//TkwCtxWordDefiningNow.Ctx_WordDefiningNow

procedure TkwCtxWordDefiningNow.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushObj(Ctx_WordDefiningNow(aCtx));
end;//TkwCtxWordDefiningNow.DoDoIt

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

function TkwCtxKeyWordDefiningNow.Ctx_KeyWordDefiningNow(const aCtx: TtfwContext): TtfwKeyWord;
 {* Реализация слова скрипта Ctx:KeyWordDefiningNow }
//#UC START# *256B4C029617_1C2D3DEAE952_var*
//#UC END# *256B4C029617_1C2D3DEAE952_var*
begin
//#UC START# *256B4C029617_1C2D3DEAE952_impl*
 Result := aCtx.rKeyWordDefiningNow;
//#UC END# *256B4C029617_1C2D3DEAE952_impl*
end;//TkwCtxKeyWordDefiningNow.Ctx_KeyWordDefiningNow

procedure TkwCtxKeyWordDefiningNow.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushObj(Ctx_KeyWordDefiningNow(aCtx));
end;//TkwCtxKeyWordDefiningNow.DoDoIt

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

procedure TkwCtxIncludeAccessType.Ctx_IncludeAccessType(const aCtx: TtfwContext;
 anAccess: TtfwAccessType);
 {* Реализация слова скрипта Ctx:IncludeAccessType }
//#UC START# *AA17108711E6_7AAC4F1C32BA_var*
//#UC END# *AA17108711E6_7AAC4F1C32BA_var*
begin
//#UC START# *AA17108711E6_7AAC4F1C32BA_impl*
 aCtx.SetWordInfo(aCtx.rTypeInfo.IncludeAccesType(anAccess));
//#UC END# *AA17108711E6_7AAC4F1C32BA_impl*
end;//TkwCtxIncludeAccessType.Ctx_IncludeAccessType

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

procedure TkwCtxIncludeLinkType.Ctx_IncludeLinkType(const aCtx: TtfwContext;
 aLinkType: TtfwLinkType);
 {* Реализация слова скрипта Ctx:IncludeLinkType }
//#UC START# *23B154B4DBB8_53FBB3F9AAFD_var*
//#UC END# *23B154B4DBB8_53FBB3F9AAFD_var*
begin
//#UC START# *23B154B4DBB8_53FBB3F9AAFD_impl*
 aCtx.SetWordInfo(aCtx.rTypeInfo.IncludeLinkType(aLinkType));
//#UC END# *23B154B4DBB8_53FBB3F9AAFD_impl*
end;//TkwCtxIncludeLinkType.Ctx_IncludeLinkType

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

function TkwCtxValueTypes.Ctx_ValueTypes(const aCtx: TtfwContext): TtfwValueTypes;
 {* Реализация слова скрипта Ctx:ValueTypes }
//#UC START# *352E66091EEC_2701D2795604_var*
//#UC END# *352E66091EEC_2701D2795604_var*
begin
//#UC START# *352E66091EEC_2701D2795604_impl*
 Result := aCtx.rTypeInfo.ValueTypes;
//#UC END# *352E66091EEC_2701D2795604_impl*
end;//TkwCtxValueTypes.Ctx_ValueTypes

procedure TkwCtxValueTypes.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushObj(Ctx_ValueTypes(aCtx));
end;//TkwCtxValueTypes.DoDoIt

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

procedure TkwCtxSetValueTypes.Ctx_SetValueTypes(const aCtx: TtfwContext;
 aTypes: TtfwValueTypes);
 {* Реализация слова скрипта Ctx:SetValueTypes }
//#UC START# *712E549F6918_0501B6DEBAE2_var*
//#UC END# *712E549F6918_0501B6DEBAE2_var*
begin
//#UC START# *712E549F6918_0501B6DEBAE2_impl*
 aCtx.SetWordInfo(TtfwWordInfo.Make(aTypes, [], tfw_atNone, tfw_ltNone));
//#UC END# *712E549F6918_0501B6DEBAE2_impl*
end;//TkwCtxSetValueTypes.Ctx_SetValueTypes

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

procedure TkwCtxIncludeValueTypes.Ctx_IncludeValueTypes(const aCtx: TtfwContext;
 aTypes: TtfwValueTypes);
 {* Реализация слова скрипта Ctx:IncludeValueTypes }
//#UC START# *A48D2ADCEACA_183633344722_var*
//#UC END# *A48D2ADCEACA_183633344722_var*
begin
//#UC START# *A48D2ADCEACA_183633344722_impl*
 aCtx.SetWordInfo(TtfwWordInfo.Make(aCtx.rTypeInfo.ValueTypes.Add(aTypes), aCtx.rTypeInfo.Modifiers, aCtx.rTypeInfo.AccessType, aCtx.rTypeInfo.LinkType));
//#UC END# *A48D2ADCEACA_183633344722_impl*
end;//TkwCtxIncludeValueTypes.Ctx_IncludeValueTypes

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

function TkwCtxWordInfo.Ctx_WordInfo(const aCtx: TtfwContext): TtfwWordInfo;
 {* Реализация слова скрипта Ctx:WordInfo }
//#UC START# *FFF18757733C_3BE27B131D46_var*
//#UC END# *FFF18757733C_3BE27B131D46_var*
begin
//#UC START# *FFF18757733C_3BE27B131D46_impl*
 Result := aCtx.rTypeInfo;
//#UC END# *FFF18757733C_3BE27B131D46_impl*
end;//TkwCtxWordInfo.Ctx_WordInfo

procedure TkwCtxWordInfo.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushObj(Ctx_WordInfo(aCtx));
end;//TkwCtxWordInfo.DoDoIt

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

function TkwCtxResolveIncludedFilePath.Ctx_ResolveIncludedFilePath(const aCtx: TtfwContext;
 const aFileName: AnsiString): AnsiString;
 {* Реализация слова скрипта Ctx:ResolveIncludedFilePath }
//#UC START# *C1B1C109F815_880CCE28EDF4_var*
//#UC END# *C1B1C109F815_880CCE28EDF4_var*
begin
//#UC START# *C1B1C109F815_880CCE28EDF4_impl*
 Result := aCtx.ResolveIncludedFilePath(aFileName);
//#UC END# *C1B1C109F815_880CCE28EDF4_impl*
end;//TkwCtxResolveIncludedFilePath.Ctx_ResolveIncludedFilePath

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

function TkwCtxMainDictionary.Ctx_MainDictionary(const aCtx: TtfwContext): TtfwMainDictionary;
 {* Реализация слова скрипта Ctx:MainDictionary }
//#UC START# *F12DBD5766C9_F387799EAE1E_var*
//#UC END# *F12DBD5766C9_F387799EAE1E_var*
begin
//#UC START# *F12DBD5766C9_F387799EAE1E_impl*
 Result := (aCtx.rEngine As ItfwScriptEngineEx).MainDictionary;
//#UC END# *F12DBD5766C9_F387799EAE1E_impl*
end;//TkwCtxMainDictionary.Ctx_MainDictionary

procedure TkwCtxMainDictionary.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushObj(Ctx_MainDictionary(aCtx));
end;//TkwCtxMainDictionary.DoDoIt

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

function TkwCtxStandardDictionaries.Ctx_StandardDictionaries(const aCtx: TtfwContext): ItfwValueList;
 {* Реализация слова скрипта Ctx:StandardDictionaries }
//#UC START# *9CB880934455_7FC312875F45_var*
//#UC END# *9CB880934455_7FC312875F45_var*
begin
//#UC START# *9CB880934455_7FC312875F45_impl*
 Result := TtfwStandardDictionaryListIterator.Make(TtfwStandardDictionaries.Instance);
//#UC END# *9CB880934455_7FC312875F45_impl*
end;//TkwCtxStandardDictionaries.Ctx_StandardDictionaries

procedure TkwCtxStandardDictionaries.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushList(Ctx_StandardDictionaries(aCtx));
end;//TkwCtxStandardDictionaries.DoDoIt

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

function TkwCtxDictionaries.Ctx_Dictionaries(const aCtx: TtfwContext): ItfwValueList;
 {* Реализация слова скрипта Ctx:Dictionaries }
//#UC START# *78F97FD56568_2A2848913C0E_var*
//#UC END# *78F97FD56568_2A2848913C0E_var*
begin
//#UC START# *78F97FD56568_2A2848913C0E_impl*
 Result := TtfwDictionaryListIterator.Make((aCtx.rEngine As ItfwScriptEngineEx).Dictionaries);
//#UC END# *78F97FD56568_2A2848913C0E_impl*
end;//TkwCtxDictionaries.Ctx_Dictionaries

procedure TkwCtxDictionaries.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushList(Ctx_Dictionaries(aCtx));
end;//TkwCtxDictionaries.DoDoIt

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

function TkwCtxInitedDictionaries.Ctx_InitedDictionaries(const aCtx: TtfwContext): ItfwValueList;
 {* Реализация слова скрипта Ctx:InitedDictionaries }
//#UC START# *7DD94B76F5AF_2B152A45C4EE_var*
//#UC END# *7DD94B76F5AF_2B152A45C4EE_var*
begin
//#UC START# *7DD94B76F5AF_2B152A45C4EE_impl*
 Result := TtfwInitedDictionariesListIterator.Make((aCtx.rEngine As ItfwScriptEngineEx).InitedDictionaries);
//#UC END# *7DD94B76F5AF_2B152A45C4EE_impl*
end;//TkwCtxInitedDictionaries.Ctx_InitedDictionaries

procedure TkwCtxInitedDictionaries.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushList(Ctx_InitedDictionaries(aCtx));
end;//TkwCtxInitedDictionaries.DoDoIt

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

function TkwCtxDisabledForHelp.Ctx_DisabledForHelp(const aCtx: TtfwContext): ItfwValueList;
 {* Реализация слова скрипта Ctx:DisabledForHelp }
//#UC START# *F777D1BA53D9_DDA19C1F4E5B_var*
//#UC END# *F777D1BA53D9_DDA19C1F4E5B_var*
begin
//#UC START# *F777D1BA53D9_DDA19C1F4E5B_impl*
 Result := TtfwWordsIterator.Make((aCtx.rEngine As ItfwScriptEngineEx).DisabledForHelp);
//#UC END# *F777D1BA53D9_DDA19C1F4E5B_impl*
end;//TkwCtxDisabledForHelp.Ctx_DisabledForHelp

procedure TkwCtxDisabledForHelp.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushList(Ctx_DisabledForHelp(aCtx));
end;//TkwCtxDisabledForHelp.DoDoIt

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

initialization
 TTypeInfoPackResNameGetter.Register;
 {* Регистрация скриптованой аксиоматики }
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
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwStackValue }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* Регистрация типа Boolean }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа Il3CString }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwValueType));
 {* Регистрация типа TtfwValueType }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwWordModifier));
 {* Регистрация типа TtfwWordModifier }
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
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwAccessType));
 {* Регистрация типа TtfwAccessType }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwLinkType));
 {* Регистрация типа TtfwLinkType }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwValueTypes));
 {* Регистрация типа TtfwValueTypes }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwWordInfo));
 {* Регистрация типа TtfwWordInfo }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа String }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwMainDictionary));
 {* Регистрация типа TtfwMainDictionary }
 TtfwTypeRegistrator.RegisterType(TypeInfo(ItfwValueList));
 {* Регистрация типа ItfwValueList }
{$IfEnd} // NOT Defined(NoScripts)

end.
