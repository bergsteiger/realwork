unit TypeInfoPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\TypeInfoPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwTypeInfo
 , l3Interfaces
 , tfwScriptingInterfaces
 , tfwMainDictionary
 , tfwScriptingTypes
 , tfwAxiomaticsResNameGetter
 , tfwClassLike
 , TypInfo
 , tfwGlobalKeyWord
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
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
//#UC START# *4DAEEDE10285_758F80018751_var*
//#UC END# *4DAEEDE10285_758F80018751_var*
begin
//#UC START# *4DAEEDE10285_758F80018751_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_758F80018751_impl*
end;//TkwIsArray.DoDoIt

class function TkwIsArray.GetWordNameForRegister: AnsiString;
begin
 Result := 'IsArray';
end;//TkwIsArray.GetWordNameForRegister

function TkwIsArray.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_758F80018751_var*
//#UC END# *551544E2001A_758F80018751_var*
begin
//#UC START# *551544E2001A_758F80018751_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_758F80018751_impl*
end;//TkwIsArray.GetResultTypeInfo

function TkwIsArray.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_758F80018751_var*
//#UC END# *559687E6025A_758F80018751_var*
begin
//#UC START# *559687E6025A_758F80018751_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_758F80018751_impl*
end;//TkwIsArray.GetAllParamsCount

function TkwIsArray.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_758F80018751_var*
//#UC END# *5617F4D00243_758F80018751_var*
begin
//#UC START# *5617F4D00243_758F80018751_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_758F80018751_impl*
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
//#UC START# *4DAEEDE10285_0707D9C010E3_var*
//#UC END# *4DAEEDE10285_0707D9C010E3_var*
begin
//#UC START# *4DAEEDE10285_0707D9C010E3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_0707D9C010E3_impl*
end;//TkwIsVoid.DoDoIt

class function TkwIsVoid.GetWordNameForRegister: AnsiString;
begin
 Result := 'IsVoid';
end;//TkwIsVoid.GetWordNameForRegister

function TkwIsVoid.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_0707D9C010E3_var*
//#UC END# *551544E2001A_0707D9C010E3_var*
begin
//#UC START# *551544E2001A_0707D9C010E3_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_0707D9C010E3_impl*
end;//TkwIsVoid.GetResultTypeInfo

function TkwIsVoid.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_0707D9C010E3_var*
//#UC END# *559687E6025A_0707D9C010E3_var*
begin
//#UC START# *559687E6025A_0707D9C010E3_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_0707D9C010E3_impl*
end;//TkwIsVoid.GetAllParamsCount

function TkwIsVoid.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_0707D9C010E3_var*
//#UC END# *5617F4D00243_0707D9C010E3_var*
begin
//#UC START# *5617F4D00243_0707D9C010E3_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_0707D9C010E3_impl*
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
//#UC START# *4DAEEDE10285_257BCAC433BA_var*
//#UC END# *4DAEEDE10285_257BCAC433BA_var*
begin
//#UC START# *4DAEEDE10285_257BCAC433BA_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_257BCAC433BA_impl*
end;//TkwIsObj.DoDoIt

class function TkwIsObj.GetWordNameForRegister: AnsiString;
begin
 Result := 'IsObj';
end;//TkwIsObj.GetWordNameForRegister

function TkwIsObj.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_257BCAC433BA_var*
//#UC END# *551544E2001A_257BCAC433BA_var*
begin
//#UC START# *551544E2001A_257BCAC433BA_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_257BCAC433BA_impl*
end;//TkwIsObj.GetResultTypeInfo

function TkwIsObj.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_257BCAC433BA_var*
//#UC END# *559687E6025A_257BCAC433BA_var*
begin
//#UC START# *559687E6025A_257BCAC433BA_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_257BCAC433BA_impl*
end;//TkwIsObj.GetAllParamsCount

function TkwIsObj.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_257BCAC433BA_var*
//#UC END# *5617F4D00243_257BCAC433BA_var*
begin
//#UC START# *5617F4D00243_257BCAC433BA_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_257BCAC433BA_impl*
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
//#UC START# *4DAEEDE10285_475E881B9090_var*
//#UC END# *4DAEEDE10285_475E881B9090_var*
begin
//#UC START# *4DAEEDE10285_475E881B9090_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_475E881B9090_impl*
end;//TkwIsIntf.DoDoIt

class function TkwIsIntf.GetWordNameForRegister: AnsiString;
begin
 Result := 'IsIntf';
end;//TkwIsIntf.GetWordNameForRegister

function TkwIsIntf.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_475E881B9090_var*
//#UC END# *551544E2001A_475E881B9090_var*
begin
//#UC START# *551544E2001A_475E881B9090_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_475E881B9090_impl*
end;//TkwIsIntf.GetResultTypeInfo

function TkwIsIntf.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_475E881B9090_var*
//#UC END# *559687E6025A_475E881B9090_var*
begin
//#UC START# *559687E6025A_475E881B9090_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_475E881B9090_impl*
end;//TkwIsIntf.GetAllParamsCount

function TkwIsIntf.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_475E881B9090_var*
//#UC END# *5617F4D00243_475E881B9090_var*
begin
//#UC START# *5617F4D00243_475E881B9090_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_475E881B9090_impl*
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
//#UC START# *4DAEEDE10285_ACCFB9C57546_var*
//#UC END# *4DAEEDE10285_ACCFB9C57546_var*
begin
//#UC START# *4DAEEDE10285_ACCFB9C57546_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_ACCFB9C57546_impl*
end;//TkwIsChar.DoDoIt

class function TkwIsChar.GetWordNameForRegister: AnsiString;
begin
 Result := 'IsChar';
end;//TkwIsChar.GetWordNameForRegister

function TkwIsChar.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_ACCFB9C57546_var*
//#UC END# *551544E2001A_ACCFB9C57546_var*
begin
//#UC START# *551544E2001A_ACCFB9C57546_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_ACCFB9C57546_impl*
end;//TkwIsChar.GetResultTypeInfo

function TkwIsChar.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_ACCFB9C57546_var*
//#UC END# *559687E6025A_ACCFB9C57546_var*
begin
//#UC START# *559687E6025A_ACCFB9C57546_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_ACCFB9C57546_impl*
end;//TkwIsChar.GetAllParamsCount

function TkwIsChar.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_ACCFB9C57546_var*
//#UC END# *5617F4D00243_ACCFB9C57546_var*
begin
//#UC START# *5617F4D00243_ACCFB9C57546_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_ACCFB9C57546_impl*
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
//#UC START# *4DAEEDE10285_689D96A305FE_var*
//#UC END# *4DAEEDE10285_689D96A305FE_var*
begin
//#UC START# *4DAEEDE10285_689D96A305FE_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_689D96A305FE_impl*
end;//TkwIsString.DoDoIt

class function TkwIsString.GetWordNameForRegister: AnsiString;
begin
 Result := 'IsString';
end;//TkwIsString.GetWordNameForRegister

function TkwIsString.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_689D96A305FE_var*
//#UC END# *551544E2001A_689D96A305FE_var*
begin
//#UC START# *551544E2001A_689D96A305FE_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_689D96A305FE_impl*
end;//TkwIsString.GetResultTypeInfo

function TkwIsString.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_689D96A305FE_var*
//#UC END# *559687E6025A_689D96A305FE_var*
begin
//#UC START# *559687E6025A_689D96A305FE_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_689D96A305FE_impl*
end;//TkwIsString.GetAllParamsCount

function TkwIsString.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_689D96A305FE_var*
//#UC END# *5617F4D00243_689D96A305FE_var*
begin
//#UC START# *5617F4D00243_689D96A305FE_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_689D96A305FE_impl*
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
//#UC START# *4DAEEDE10285_1E29EA0B90A4_var*
//#UC END# *4DAEEDE10285_1E29EA0B90A4_var*
begin
//#UC START# *4DAEEDE10285_1E29EA0B90A4_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_1E29EA0B90A4_impl*
end;//TkwIsInt.DoDoIt

class function TkwIsInt.GetWordNameForRegister: AnsiString;
begin
 Result := 'IsInt';
end;//TkwIsInt.GetWordNameForRegister

function TkwIsInt.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_1E29EA0B90A4_var*
//#UC END# *551544E2001A_1E29EA0B90A4_var*
begin
//#UC START# *551544E2001A_1E29EA0B90A4_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_1E29EA0B90A4_impl*
end;//TkwIsInt.GetResultTypeInfo

function TkwIsInt.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_1E29EA0B90A4_var*
//#UC END# *559687E6025A_1E29EA0B90A4_var*
begin
//#UC START# *559687E6025A_1E29EA0B90A4_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_1E29EA0B90A4_impl*
end;//TkwIsInt.GetAllParamsCount

function TkwIsInt.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_1E29EA0B90A4_var*
//#UC END# *5617F4D00243_1E29EA0B90A4_var*
begin
//#UC START# *5617F4D00243_1E29EA0B90A4_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_1E29EA0B90A4_impl*
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
//#UC START# *4DAEEDE10285_D8E9C4F61308_var*
//#UC END# *4DAEEDE10285_D8E9C4F61308_var*
begin
//#UC START# *4DAEEDE10285_D8E9C4F61308_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_D8E9C4F61308_impl*
end;//TkwIsClass.DoDoIt

class function TkwIsClass.GetWordNameForRegister: AnsiString;
begin
 Result := 'IsClass';
end;//TkwIsClass.GetWordNameForRegister

function TkwIsClass.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_D8E9C4F61308_var*
//#UC END# *551544E2001A_D8E9C4F61308_var*
begin
//#UC START# *551544E2001A_D8E9C4F61308_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_D8E9C4F61308_impl*
end;//TkwIsClass.GetResultTypeInfo

function TkwIsClass.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_D8E9C4F61308_var*
//#UC END# *559687E6025A_D8E9C4F61308_var*
begin
//#UC START# *559687E6025A_D8E9C4F61308_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_D8E9C4F61308_impl*
end;//TkwIsClass.GetAllParamsCount

function TkwIsClass.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_D8E9C4F61308_var*
//#UC END# *5617F4D00243_D8E9C4F61308_var*
begin
//#UC START# *5617F4D00243_D8E9C4F61308_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_D8E9C4F61308_impl*
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
//#UC START# *4DAEEDE10285_0B39C51FE7D1_var*
//#UC END# *4DAEEDE10285_0B39C51FE7D1_var*
begin
//#UC START# *4DAEEDE10285_0B39C51FE7D1_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_0B39C51FE7D1_impl*
end;//TkwToPrintable.DoDoIt

class function TkwToPrintable.GetWordNameForRegister: AnsiString;
begin
 Result := 'ToPrintable';
end;//TkwToPrintable.GetWordNameForRegister

function TkwToPrintable.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_0B39C51FE7D1_var*
//#UC END# *551544E2001A_0B39C51FE7D1_var*
begin
//#UC START# *551544E2001A_0B39C51FE7D1_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_0B39C51FE7D1_impl*
end;//TkwToPrintable.GetResultTypeInfo

function TkwToPrintable.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_0B39C51FE7D1_var*
//#UC END# *559687E6025A_0B39C51FE7D1_var*
begin
//#UC START# *559687E6025A_0B39C51FE7D1_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_0B39C51FE7D1_impl*
end;//TkwToPrintable.GetAllParamsCount

function TkwToPrintable.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_0B39C51FE7D1_var*
//#UC END# *5617F4D00243_0B39C51FE7D1_var*
begin
//#UC START# *5617F4D00243_0B39C51FE7D1_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_0B39C51FE7D1_impl*
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
//#UC START# *4DAEEDE10285_805A190E934E_var*
//#UC END# *4DAEEDE10285_805A190E934E_var*
begin
//#UC START# *4DAEEDE10285_805A190E934E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_805A190E934E_impl*
end;//TkwIsBool.DoDoIt

class function TkwIsBool.GetWordNameForRegister: AnsiString;
begin
 Result := 'IsBool';
end;//TkwIsBool.GetWordNameForRegister

function TkwIsBool.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_805A190E934E_var*
//#UC END# *551544E2001A_805A190E934E_var*
begin
//#UC START# *551544E2001A_805A190E934E_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_805A190E934E_impl*
end;//TkwIsBool.GetResultTypeInfo

function TkwIsBool.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_805A190E934E_var*
//#UC END# *559687E6025A_805A190E934E_var*
begin
//#UC START# *559687E6025A_805A190E934E_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_805A190E934E_impl*
end;//TkwIsBool.GetAllParamsCount

function TkwIsBool.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_805A190E934E_var*
//#UC END# *5617F4D00243_805A190E934E_var*
begin
//#UC START# *5617F4D00243_805A190E934E_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_805A190E934E_impl*
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
//#UC START# *4DAEEDE10285_482D1ABE67DA_var*
//#UC END# *4DAEEDE10285_482D1ABE67DA_var*
begin
//#UC START# *4DAEEDE10285_482D1ABE67DA_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_482D1ABE67DA_impl*
end;//TkwIsTypeOf.DoDoIt

class function TkwIsTypeOf.GetWordNameForRegister: AnsiString;
begin
 Result := 'IsTypeOf';
end;//TkwIsTypeOf.GetWordNameForRegister

function TkwIsTypeOf.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_482D1ABE67DA_var*
//#UC END# *551544E2001A_482D1ABE67DA_var*
begin
//#UC START# *551544E2001A_482D1ABE67DA_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_482D1ABE67DA_impl*
end;//TkwIsTypeOf.GetResultTypeInfo

function TkwIsTypeOf.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_482D1ABE67DA_var*
//#UC END# *559687E6025A_482D1ABE67DA_var*
begin
//#UC START# *559687E6025A_482D1ABE67DA_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_482D1ABE67DA_impl*
end;//TkwIsTypeOf.GetAllParamsCount

function TkwIsTypeOf.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_482D1ABE67DA_var*
//#UC END# *5617F4D00243_482D1ABE67DA_var*
begin
//#UC START# *5617F4D00243_482D1ABE67DA_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_482D1ABE67DA_impl*
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
//#UC START# *4DAEEDE10285_1D17EAE13A3E_var*
//#UC END# *4DAEEDE10285_1D17EAE13A3E_var*
begin
//#UC START# *4DAEEDE10285_1D17EAE13A3E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_1D17EAE13A3E_impl*
end;//TkwIsNil.DoDoIt

class function TkwIsNil.GetWordNameForRegister: AnsiString;
begin
 Result := 'IsNil';
end;//TkwIsNil.GetWordNameForRegister

function TkwIsNil.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_1D17EAE13A3E_var*
//#UC END# *551544E2001A_1D17EAE13A3E_var*
begin
//#UC START# *551544E2001A_1D17EAE13A3E_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_1D17EAE13A3E_impl*
end;//TkwIsNil.GetResultTypeInfo

function TkwIsNil.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_1D17EAE13A3E_var*
//#UC END# *559687E6025A_1D17EAE13A3E_var*
begin
//#UC START# *559687E6025A_1D17EAE13A3E_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_1D17EAE13A3E_impl*
end;//TkwIsNil.GetAllParamsCount

function TkwIsNil.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_1D17EAE13A3E_var*
//#UC END# *5617F4D00243_1D17EAE13A3E_var*
begin
//#UC START# *5617F4D00243_1D17EAE13A3E_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_1D17EAE13A3E_impl*
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
//#UC START# *4DAEEDE10285_C05D38D44F64_var*
//#UC END# *4DAEEDE10285_C05D38D44F64_var*
begin
//#UC START# *4DAEEDE10285_C05D38D44F64_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_C05D38D44F64_impl*
end;//TkwCtxIncludeModifier.DoDoIt

class function TkwCtxIncludeModifier.GetWordNameForRegister: AnsiString;
begin
 Result := 'Ctx:IncludeModifier';
end;//TkwCtxIncludeModifier.GetWordNameForRegister

function TkwCtxIncludeModifier.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_C05D38D44F64_var*
//#UC END# *551544E2001A_C05D38D44F64_var*
begin
//#UC START# *551544E2001A_C05D38D44F64_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_C05D38D44F64_impl*
end;//TkwCtxIncludeModifier.GetResultTypeInfo

function TkwCtxIncludeModifier.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_C05D38D44F64_var*
//#UC END# *559687E6025A_C05D38D44F64_var*
begin
//#UC START# *559687E6025A_C05D38D44F64_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_C05D38D44F64_impl*
end;//TkwCtxIncludeModifier.GetAllParamsCount

function TkwCtxIncludeModifier.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_C05D38D44F64_var*
//#UC END# *5617F4D00243_C05D38D44F64_var*
begin
//#UC START# *5617F4D00243_C05D38D44F64_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_C05D38D44F64_impl*
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
//#UC START# *4DAEEDE10285_76B2C4302847_var*
//#UC END# *4DAEEDE10285_76B2C4302847_var*
begin
//#UC START# *4DAEEDE10285_76B2C4302847_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_76B2C4302847_impl*
end;//TkwCtxPushCompiler.DoDoIt

class function TkwCtxPushCompiler.GetWordNameForRegister: AnsiString;
begin
 Result := 'Ctx:PushCompiler';
end;//TkwCtxPushCompiler.GetWordNameForRegister

function TkwCtxPushCompiler.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_76B2C4302847_var*
//#UC END# *551544E2001A_76B2C4302847_var*
begin
//#UC START# *551544E2001A_76B2C4302847_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_76B2C4302847_impl*
end;//TkwCtxPushCompiler.GetResultTypeInfo

function TkwCtxPushCompiler.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_76B2C4302847_var*
//#UC END# *559687E6025A_76B2C4302847_var*
begin
//#UC START# *559687E6025A_76B2C4302847_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_76B2C4302847_impl*
end;//TkwCtxPushCompiler.GetAllParamsCount

function TkwCtxPushCompiler.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_76B2C4302847_var*
//#UC END# *5617F4D00243_76B2C4302847_var*
begin
//#UC START# *5617F4D00243_76B2C4302847_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_76B2C4302847_impl*
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
//#UC START# *4DAEEDE10285_E129F00B5D0B_var*
//#UC END# *4DAEEDE10285_E129F00B5D0B_var*
begin
//#UC START# *4DAEEDE10285_E129F00B5D0B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_E129F00B5D0B_impl*
end;//TkwCtxPushFinder.DoDoIt

class function TkwCtxPushFinder.GetWordNameForRegister: AnsiString;
begin
 Result := 'Ctx:PushFinder';
end;//TkwCtxPushFinder.GetWordNameForRegister

function TkwCtxPushFinder.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_E129F00B5D0B_var*
//#UC END# *551544E2001A_E129F00B5D0B_var*
begin
//#UC START# *551544E2001A_E129F00B5D0B_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_E129F00B5D0B_impl*
end;//TkwCtxPushFinder.GetResultTypeInfo

function TkwCtxPushFinder.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_E129F00B5D0B_var*
//#UC END# *559687E6025A_E129F00B5D0B_var*
begin
//#UC START# *559687E6025A_E129F00B5D0B_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_E129F00B5D0B_impl*
end;//TkwCtxPushFinder.GetAllParamsCount

function TkwCtxPushFinder.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_E129F00B5D0B_var*
//#UC END# *5617F4D00243_E129F00B5D0B_var*
begin
//#UC START# *5617F4D00243_E129F00B5D0B_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_E129F00B5D0B_impl*
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
//#UC START# *4DAEEDE10285_DCE6B328F683_var*
//#UC END# *4DAEEDE10285_DCE6B328F683_var*
begin
//#UC START# *4DAEEDE10285_DCE6B328F683_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_DCE6B328F683_impl*
end;//TkwPopCompilerSetToCtx.DoDoIt

class function TkwPopCompilerSetToCtx.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Compiler:SetToCtx';
end;//TkwPopCompilerSetToCtx.GetWordNameForRegister

function TkwPopCompilerSetToCtx.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_DCE6B328F683_var*
//#UC END# *551544E2001A_DCE6B328F683_var*
begin
//#UC START# *551544E2001A_DCE6B328F683_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_DCE6B328F683_impl*
end;//TkwPopCompilerSetToCtx.GetResultTypeInfo

function TkwPopCompilerSetToCtx.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_DCE6B328F683_var*
//#UC END# *559687E6025A_DCE6B328F683_var*
begin
//#UC START# *559687E6025A_DCE6B328F683_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_DCE6B328F683_impl*
end;//TkwPopCompilerSetToCtx.GetAllParamsCount

function TkwPopCompilerSetToCtx.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_DCE6B328F683_var*
//#UC END# *5617F4D00243_DCE6B328F683_var*
begin
//#UC START# *5617F4D00243_DCE6B328F683_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_DCE6B328F683_impl*
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
//#UC START# *4DAEEDE10285_5222729B474B_var*
//#UC END# *4DAEEDE10285_5222729B474B_var*
begin
//#UC START# *4DAEEDE10285_5222729B474B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_5222729B474B_impl*
end;//TkwPopFinderSetToCtx.DoDoIt

class function TkwPopFinderSetToCtx.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Finder:SetToCtx';
end;//TkwPopFinderSetToCtx.GetWordNameForRegister

function TkwPopFinderSetToCtx.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_5222729B474B_var*
//#UC END# *551544E2001A_5222729B474B_var*
begin
//#UC START# *551544E2001A_5222729B474B_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_5222729B474B_impl*
end;//TkwPopFinderSetToCtx.GetResultTypeInfo

function TkwPopFinderSetToCtx.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_5222729B474B_var*
//#UC END# *559687E6025A_5222729B474B_var*
begin
//#UC START# *559687E6025A_5222729B474B_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_5222729B474B_impl*
end;//TkwPopFinderSetToCtx.GetAllParamsCount

function TkwPopFinderSetToCtx.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_5222729B474B_var*
//#UC END# *5617F4D00243_5222729B474B_var*
begin
//#UC START# *5617F4D00243_5222729B474B_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_5222729B474B_impl*
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
//#UC START# *551544E2001A_723DBAD5D836_var*
//#UC END# *551544E2001A_723DBAD5D836_var*
begin
//#UC START# *551544E2001A_723DBAD5D836_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_723DBAD5D836_impl*
end;//TkwNotImplemented.GetResultTypeInfo

function TkwNotImplemented.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_723DBAD5D836_var*
//#UC END# *559687E6025A_723DBAD5D836_var*
begin
//#UC START# *559687E6025A_723DBAD5D836_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_723DBAD5D836_impl*
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
//#UC START# *4DAEEDE10285_727C5ED83D51_var*
//#UC END# *4DAEEDE10285_727C5ED83D51_var*
begin
//#UC START# *4DAEEDE10285_727C5ED83D51_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_727C5ED83D51_impl*
end;//TkwCtxNewWordDefinitor.DoDoIt

class function TkwCtxNewWordDefinitor.GetWordNameForRegister: AnsiString;
begin
 Result := 'Ctx:NewWordDefinitor';
end;//TkwCtxNewWordDefinitor.GetWordNameForRegister

function TkwCtxNewWordDefinitor.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_727C5ED83D51_var*
//#UC END# *551544E2001A_727C5ED83D51_var*
begin
//#UC START# *551544E2001A_727C5ED83D51_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_727C5ED83D51_impl*
end;//TkwCtxNewWordDefinitor.GetResultTypeInfo

function TkwCtxNewWordDefinitor.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_727C5ED83D51_var*
//#UC END# *559687E6025A_727C5ED83D51_var*
begin
//#UC START# *559687E6025A_727C5ED83D51_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_727C5ED83D51_impl*
end;//TkwCtxNewWordDefinitor.GetAllParamsCount

function TkwCtxNewWordDefinitor.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_727C5ED83D51_var*
//#UC END# *5617F4D00243_727C5ED83D51_var*
begin
//#UC START# *5617F4D00243_727C5ED83D51_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_727C5ED83D51_impl*
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
//#UC START# *551544E2001A_A118FE89A230_var*
//#UC END# *551544E2001A_A118FE89A230_var*
begin
//#UC START# *551544E2001A_A118FE89A230_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_A118FE89A230_impl*
end;//TkwCtxClearTypeInfo.GetResultTypeInfo

function TkwCtxClearTypeInfo.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_A118FE89A230_var*
//#UC END# *559687E6025A_A118FE89A230_var*
begin
//#UC START# *559687E6025A_A118FE89A230_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_A118FE89A230_impl*
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
//#UC START# *4DAEEDE10285_6940038A26AA_var*
//#UC END# *4DAEEDE10285_6940038A26AA_var*
begin
//#UC START# *4DAEEDE10285_6940038A26AA_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_6940038A26AA_impl*
end;//TkwCtxSetWordProducerForCompiledClass.DoDoIt

class function TkwCtxSetWordProducerForCompiledClass.GetWordNameForRegister: AnsiString;
begin
 Result := 'Ctx:SetWordProducerForCompiledClass';
end;//TkwCtxSetWordProducerForCompiledClass.GetWordNameForRegister

function TkwCtxSetWordProducerForCompiledClass.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_6940038A26AA_var*
//#UC END# *551544E2001A_6940038A26AA_var*
begin
//#UC START# *551544E2001A_6940038A26AA_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_6940038A26AA_impl*
end;//TkwCtxSetWordProducerForCompiledClass.GetResultTypeInfo

function TkwCtxSetWordProducerForCompiledClass.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_6940038A26AA_var*
//#UC END# *559687E6025A_6940038A26AA_var*
begin
//#UC START# *559687E6025A_6940038A26AA_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_6940038A26AA_impl*
end;//TkwCtxSetWordProducerForCompiledClass.GetAllParamsCount

function TkwCtxSetWordProducerForCompiledClass.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_6940038A26AA_var*
//#UC END# *5617F4D00243_6940038A26AA_var*
begin
//#UC START# *5617F4D00243_6940038A26AA_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_6940038A26AA_impl*
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
//#UC START# *4DAEEDE10285_C23B404259CC_var*
//#UC END# *4DAEEDE10285_C23B404259CC_var*
begin
//#UC START# *4DAEEDE10285_C23B404259CC_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_C23B404259CC_impl*
end;//TkwCtxSetNewWordName.DoDoIt

class function TkwCtxSetNewWordName.GetWordNameForRegister: AnsiString;
begin
 Result := 'Ctx:SetNewWordName';
end;//TkwCtxSetNewWordName.GetWordNameForRegister

function TkwCtxSetNewWordName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_C23B404259CC_var*
//#UC END# *551544E2001A_C23B404259CC_var*
begin
//#UC START# *551544E2001A_C23B404259CC_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_C23B404259CC_impl*
end;//TkwCtxSetNewWordName.GetResultTypeInfo

function TkwCtxSetNewWordName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_C23B404259CC_var*
//#UC END# *559687E6025A_C23B404259CC_var*
begin
//#UC START# *559687E6025A_C23B404259CC_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_C23B404259CC_impl*
end;//TkwCtxSetNewWordName.GetAllParamsCount

function TkwCtxSetNewWordName.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_C23B404259CC_var*
//#UC END# *5617F4D00243_C23B404259CC_var*
begin
//#UC START# *5617F4D00243_C23B404259CC_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_C23B404259CC_impl*
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
//#UC START# *4DAEEDE10285_286CAF6C6B6A_var*
//#UC END# *4DAEEDE10285_286CAF6C6B6A_var*
begin
//#UC START# *4DAEEDE10285_286CAF6C6B6A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_286CAF6C6B6A_impl*
end;//TkwCtxIncludeTypeModifier.DoDoIt

class function TkwCtxIncludeTypeModifier.GetWordNameForRegister: AnsiString;
begin
 Result := 'Ctx:IncludeTypeModifier';
end;//TkwCtxIncludeTypeModifier.GetWordNameForRegister

function TkwCtxIncludeTypeModifier.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_286CAF6C6B6A_var*
//#UC END# *551544E2001A_286CAF6C6B6A_var*
begin
//#UC START# *551544E2001A_286CAF6C6B6A_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_286CAF6C6B6A_impl*
end;//TkwCtxIncludeTypeModifier.GetResultTypeInfo

function TkwCtxIncludeTypeModifier.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_286CAF6C6B6A_var*
//#UC END# *559687E6025A_286CAF6C6B6A_var*
begin
//#UC START# *559687E6025A_286CAF6C6B6A_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_286CAF6C6B6A_impl*
end;//TkwCtxIncludeTypeModifier.GetAllParamsCount

function TkwCtxIncludeTypeModifier.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_286CAF6C6B6A_var*
//#UC END# *5617F4D00243_286CAF6C6B6A_var*
begin
//#UC START# *5617F4D00243_286CAF6C6B6A_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_286CAF6C6B6A_impl*
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
//#UC START# *4DAEEDE10285_F9DC6877556A_var*
//#UC END# *4DAEEDE10285_F9DC6877556A_var*
begin
//#UC START# *4DAEEDE10285_F9DC6877556A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_F9DC6877556A_impl*
end;//TkwCtxWordDefiningNow.DoDoIt

class function TkwCtxWordDefiningNow.GetWordNameForRegister: AnsiString;
begin
 Result := 'Ctx:WordDefiningNow';
end;//TkwCtxWordDefiningNow.GetWordNameForRegister

function TkwCtxWordDefiningNow.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_F9DC6877556A_var*
//#UC END# *551544E2001A_F9DC6877556A_var*
begin
//#UC START# *551544E2001A_F9DC6877556A_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_F9DC6877556A_impl*
end;//TkwCtxWordDefiningNow.GetResultTypeInfo

function TkwCtxWordDefiningNow.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_F9DC6877556A_var*
//#UC END# *559687E6025A_F9DC6877556A_var*
begin
//#UC START# *559687E6025A_F9DC6877556A_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_F9DC6877556A_impl*
end;//TkwCtxWordDefiningNow.GetAllParamsCount

function TkwCtxWordDefiningNow.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_F9DC6877556A_var*
//#UC END# *5617F4D00243_F9DC6877556A_var*
begin
//#UC START# *5617F4D00243_F9DC6877556A_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_F9DC6877556A_impl*
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
//#UC START# *4DAEEDE10285_1C2D3DEAE952_var*
//#UC END# *4DAEEDE10285_1C2D3DEAE952_var*
begin
//#UC START# *4DAEEDE10285_1C2D3DEAE952_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_1C2D3DEAE952_impl*
end;//TkwCtxKeyWordDefiningNow.DoDoIt

class function TkwCtxKeyWordDefiningNow.GetWordNameForRegister: AnsiString;
begin
 Result := 'Ctx:KeyWordDefiningNow';
end;//TkwCtxKeyWordDefiningNow.GetWordNameForRegister

function TkwCtxKeyWordDefiningNow.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_1C2D3DEAE952_var*
//#UC END# *551544E2001A_1C2D3DEAE952_var*
begin
//#UC START# *551544E2001A_1C2D3DEAE952_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_1C2D3DEAE952_impl*
end;//TkwCtxKeyWordDefiningNow.GetResultTypeInfo

function TkwCtxKeyWordDefiningNow.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_1C2D3DEAE952_var*
//#UC END# *559687E6025A_1C2D3DEAE952_var*
begin
//#UC START# *559687E6025A_1C2D3DEAE952_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_1C2D3DEAE952_impl*
end;//TkwCtxKeyWordDefiningNow.GetAllParamsCount

function TkwCtxKeyWordDefiningNow.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_1C2D3DEAE952_var*
//#UC END# *5617F4D00243_1C2D3DEAE952_var*
begin
//#UC START# *5617F4D00243_1C2D3DEAE952_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_1C2D3DEAE952_impl*
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
//#UC START# *4DAEEDE10285_7AAC4F1C32BA_var*
//#UC END# *4DAEEDE10285_7AAC4F1C32BA_var*
begin
//#UC START# *4DAEEDE10285_7AAC4F1C32BA_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_7AAC4F1C32BA_impl*
end;//TkwCtxIncludeAccessType.DoDoIt

class function TkwCtxIncludeAccessType.GetWordNameForRegister: AnsiString;
begin
 Result := 'Ctx:IncludeAccessType';
end;//TkwCtxIncludeAccessType.GetWordNameForRegister

function TkwCtxIncludeAccessType.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_7AAC4F1C32BA_var*
//#UC END# *551544E2001A_7AAC4F1C32BA_var*
begin
//#UC START# *551544E2001A_7AAC4F1C32BA_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_7AAC4F1C32BA_impl*
end;//TkwCtxIncludeAccessType.GetResultTypeInfo

function TkwCtxIncludeAccessType.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_7AAC4F1C32BA_var*
//#UC END# *559687E6025A_7AAC4F1C32BA_var*
begin
//#UC START# *559687E6025A_7AAC4F1C32BA_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_7AAC4F1C32BA_impl*
end;//TkwCtxIncludeAccessType.GetAllParamsCount

function TkwCtxIncludeAccessType.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_7AAC4F1C32BA_var*
//#UC END# *5617F4D00243_7AAC4F1C32BA_var*
begin
//#UC START# *5617F4D00243_7AAC4F1C32BA_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_7AAC4F1C32BA_impl*
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
//#UC START# *4DAEEDE10285_53FBB3F9AAFD_var*
//#UC END# *4DAEEDE10285_53FBB3F9AAFD_var*
begin
//#UC START# *4DAEEDE10285_53FBB3F9AAFD_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_53FBB3F9AAFD_impl*
end;//TkwCtxIncludeLinkType.DoDoIt

class function TkwCtxIncludeLinkType.GetWordNameForRegister: AnsiString;
begin
 Result := 'Ctx:IncludeLinkType';
end;//TkwCtxIncludeLinkType.GetWordNameForRegister

function TkwCtxIncludeLinkType.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_53FBB3F9AAFD_var*
//#UC END# *551544E2001A_53FBB3F9AAFD_var*
begin
//#UC START# *551544E2001A_53FBB3F9AAFD_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_53FBB3F9AAFD_impl*
end;//TkwCtxIncludeLinkType.GetResultTypeInfo

function TkwCtxIncludeLinkType.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_53FBB3F9AAFD_var*
//#UC END# *559687E6025A_53FBB3F9AAFD_var*
begin
//#UC START# *559687E6025A_53FBB3F9AAFD_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_53FBB3F9AAFD_impl*
end;//TkwCtxIncludeLinkType.GetAllParamsCount

function TkwCtxIncludeLinkType.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_53FBB3F9AAFD_var*
//#UC END# *5617F4D00243_53FBB3F9AAFD_var*
begin
//#UC START# *5617F4D00243_53FBB3F9AAFD_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_53FBB3F9AAFD_impl*
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
//#UC START# *4DAEEDE10285_2701D2795604_var*
//#UC END# *4DAEEDE10285_2701D2795604_var*
begin
//#UC START# *4DAEEDE10285_2701D2795604_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_2701D2795604_impl*
end;//TkwCtxValueTypes.DoDoIt

class function TkwCtxValueTypes.GetWordNameForRegister: AnsiString;
begin
 Result := 'Ctx:ValueTypes';
end;//TkwCtxValueTypes.GetWordNameForRegister

function TkwCtxValueTypes.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_2701D2795604_var*
//#UC END# *551544E2001A_2701D2795604_var*
begin
//#UC START# *551544E2001A_2701D2795604_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_2701D2795604_impl*
end;//TkwCtxValueTypes.GetResultTypeInfo

function TkwCtxValueTypes.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_2701D2795604_var*
//#UC END# *559687E6025A_2701D2795604_var*
begin
//#UC START# *559687E6025A_2701D2795604_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_2701D2795604_impl*
end;//TkwCtxValueTypes.GetAllParamsCount

function TkwCtxValueTypes.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_2701D2795604_var*
//#UC END# *5617F4D00243_2701D2795604_var*
begin
//#UC START# *5617F4D00243_2701D2795604_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_2701D2795604_impl*
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
//#UC START# *4DAEEDE10285_0501B6DEBAE2_var*
//#UC END# *4DAEEDE10285_0501B6DEBAE2_var*
begin
//#UC START# *4DAEEDE10285_0501B6DEBAE2_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_0501B6DEBAE2_impl*
end;//TkwCtxSetValueTypes.DoDoIt

class function TkwCtxSetValueTypes.GetWordNameForRegister: AnsiString;
begin
 Result := 'Ctx:SetValueTypes';
end;//TkwCtxSetValueTypes.GetWordNameForRegister

function TkwCtxSetValueTypes.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_0501B6DEBAE2_var*
//#UC END# *551544E2001A_0501B6DEBAE2_var*
begin
//#UC START# *551544E2001A_0501B6DEBAE2_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_0501B6DEBAE2_impl*
end;//TkwCtxSetValueTypes.GetResultTypeInfo

function TkwCtxSetValueTypes.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_0501B6DEBAE2_var*
//#UC END# *559687E6025A_0501B6DEBAE2_var*
begin
//#UC START# *559687E6025A_0501B6DEBAE2_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_0501B6DEBAE2_impl*
end;//TkwCtxSetValueTypes.GetAllParamsCount

function TkwCtxSetValueTypes.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_0501B6DEBAE2_var*
//#UC END# *5617F4D00243_0501B6DEBAE2_var*
begin
//#UC START# *5617F4D00243_0501B6DEBAE2_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_0501B6DEBAE2_impl*
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
//#UC START# *4DAEEDE10285_183633344722_var*
//#UC END# *4DAEEDE10285_183633344722_var*
begin
//#UC START# *4DAEEDE10285_183633344722_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_183633344722_impl*
end;//TkwCtxIncludeValueTypes.DoDoIt

class function TkwCtxIncludeValueTypes.GetWordNameForRegister: AnsiString;
begin
 Result := 'Ctx:IncludeValueTypes';
end;//TkwCtxIncludeValueTypes.GetWordNameForRegister

function TkwCtxIncludeValueTypes.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_183633344722_var*
//#UC END# *551544E2001A_183633344722_var*
begin
//#UC START# *551544E2001A_183633344722_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_183633344722_impl*
end;//TkwCtxIncludeValueTypes.GetResultTypeInfo

function TkwCtxIncludeValueTypes.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_183633344722_var*
//#UC END# *559687E6025A_183633344722_var*
begin
//#UC START# *559687E6025A_183633344722_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_183633344722_impl*
end;//TkwCtxIncludeValueTypes.GetAllParamsCount

function TkwCtxIncludeValueTypes.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_183633344722_var*
//#UC END# *5617F4D00243_183633344722_var*
begin
//#UC START# *5617F4D00243_183633344722_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_183633344722_impl*
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
//#UC START# *4DAEEDE10285_3BE27B131D46_var*
//#UC END# *4DAEEDE10285_3BE27B131D46_var*
begin
//#UC START# *4DAEEDE10285_3BE27B131D46_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_3BE27B131D46_impl*
end;//TkwCtxWordInfo.DoDoIt

class function TkwCtxWordInfo.GetWordNameForRegister: AnsiString;
begin
 Result := 'Ctx:WordInfo';
end;//TkwCtxWordInfo.GetWordNameForRegister

function TkwCtxWordInfo.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_3BE27B131D46_var*
//#UC END# *551544E2001A_3BE27B131D46_var*
begin
//#UC START# *551544E2001A_3BE27B131D46_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_3BE27B131D46_impl*
end;//TkwCtxWordInfo.GetResultTypeInfo

function TkwCtxWordInfo.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_3BE27B131D46_var*
//#UC END# *559687E6025A_3BE27B131D46_var*
begin
//#UC START# *559687E6025A_3BE27B131D46_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_3BE27B131D46_impl*
end;//TkwCtxWordInfo.GetAllParamsCount

function TkwCtxWordInfo.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_3BE27B131D46_var*
//#UC END# *5617F4D00243_3BE27B131D46_var*
begin
//#UC START# *5617F4D00243_3BE27B131D46_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_3BE27B131D46_impl*
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
//#UC START# *4DAEEDE10285_880CCE28EDF4_var*
//#UC END# *4DAEEDE10285_880CCE28EDF4_var*
begin
//#UC START# *4DAEEDE10285_880CCE28EDF4_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_880CCE28EDF4_impl*
end;//TkwCtxResolveIncludedFilePath.DoDoIt

class function TkwCtxResolveIncludedFilePath.GetWordNameForRegister: AnsiString;
begin
 Result := 'Ctx:ResolveIncludedFilePath';
end;//TkwCtxResolveIncludedFilePath.GetWordNameForRegister

function TkwCtxResolveIncludedFilePath.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_880CCE28EDF4_var*
//#UC END# *551544E2001A_880CCE28EDF4_var*
begin
//#UC START# *551544E2001A_880CCE28EDF4_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_880CCE28EDF4_impl*
end;//TkwCtxResolveIncludedFilePath.GetResultTypeInfo

function TkwCtxResolveIncludedFilePath.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_880CCE28EDF4_var*
//#UC END# *559687E6025A_880CCE28EDF4_var*
begin
//#UC START# *559687E6025A_880CCE28EDF4_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_880CCE28EDF4_impl*
end;//TkwCtxResolveIncludedFilePath.GetAllParamsCount

function TkwCtxResolveIncludedFilePath.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_880CCE28EDF4_var*
//#UC END# *5617F4D00243_880CCE28EDF4_var*
begin
//#UC START# *5617F4D00243_880CCE28EDF4_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_880CCE28EDF4_impl*
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
//#UC START# *4DAEEDE10285_F387799EAE1E_var*
//#UC END# *4DAEEDE10285_F387799EAE1E_var*
begin
//#UC START# *4DAEEDE10285_F387799EAE1E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_F387799EAE1E_impl*
end;//TkwCtxMainDictionary.DoDoIt

class function TkwCtxMainDictionary.GetWordNameForRegister: AnsiString;
begin
 Result := 'Ctx:MainDictionary';
end;//TkwCtxMainDictionary.GetWordNameForRegister

function TkwCtxMainDictionary.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_F387799EAE1E_var*
//#UC END# *551544E2001A_F387799EAE1E_var*
begin
//#UC START# *551544E2001A_F387799EAE1E_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_F387799EAE1E_impl*
end;//TkwCtxMainDictionary.GetResultTypeInfo

function TkwCtxMainDictionary.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_F387799EAE1E_var*
//#UC END# *559687E6025A_F387799EAE1E_var*
begin
//#UC START# *559687E6025A_F387799EAE1E_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_F387799EAE1E_impl*
end;//TkwCtxMainDictionary.GetAllParamsCount

function TkwCtxMainDictionary.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_F387799EAE1E_var*
//#UC END# *5617F4D00243_F387799EAE1E_var*
begin
//#UC START# *5617F4D00243_F387799EAE1E_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_F387799EAE1E_impl*
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
//#UC START# *4DAEEDE10285_7FC312875F45_var*
//#UC END# *4DAEEDE10285_7FC312875F45_var*
begin
//#UC START# *4DAEEDE10285_7FC312875F45_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_7FC312875F45_impl*
end;//TkwCtxStandardDictionaries.DoDoIt

class function TkwCtxStandardDictionaries.GetWordNameForRegister: AnsiString;
begin
 Result := 'Ctx:StandardDictionaries';
end;//TkwCtxStandardDictionaries.GetWordNameForRegister

function TkwCtxStandardDictionaries.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_7FC312875F45_var*
//#UC END# *551544E2001A_7FC312875F45_var*
begin
//#UC START# *551544E2001A_7FC312875F45_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_7FC312875F45_impl*
end;//TkwCtxStandardDictionaries.GetResultTypeInfo

function TkwCtxStandardDictionaries.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_7FC312875F45_var*
//#UC END# *559687E6025A_7FC312875F45_var*
begin
//#UC START# *559687E6025A_7FC312875F45_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_7FC312875F45_impl*
end;//TkwCtxStandardDictionaries.GetAllParamsCount

function TkwCtxStandardDictionaries.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_7FC312875F45_var*
//#UC END# *5617F4D00243_7FC312875F45_var*
begin
//#UC START# *5617F4D00243_7FC312875F45_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_7FC312875F45_impl*
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
//#UC START# *4DAEEDE10285_2A2848913C0E_var*
//#UC END# *4DAEEDE10285_2A2848913C0E_var*
begin
//#UC START# *4DAEEDE10285_2A2848913C0E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_2A2848913C0E_impl*
end;//TkwCtxDictionaries.DoDoIt

class function TkwCtxDictionaries.GetWordNameForRegister: AnsiString;
begin
 Result := 'Ctx:Dictionaries';
end;//TkwCtxDictionaries.GetWordNameForRegister

function TkwCtxDictionaries.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_2A2848913C0E_var*
//#UC END# *551544E2001A_2A2848913C0E_var*
begin
//#UC START# *551544E2001A_2A2848913C0E_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_2A2848913C0E_impl*
end;//TkwCtxDictionaries.GetResultTypeInfo

function TkwCtxDictionaries.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_2A2848913C0E_var*
//#UC END# *559687E6025A_2A2848913C0E_var*
begin
//#UC START# *559687E6025A_2A2848913C0E_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_2A2848913C0E_impl*
end;//TkwCtxDictionaries.GetAllParamsCount

function TkwCtxDictionaries.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_2A2848913C0E_var*
//#UC END# *5617F4D00243_2A2848913C0E_var*
begin
//#UC START# *5617F4D00243_2A2848913C0E_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_2A2848913C0E_impl*
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
//#UC START# *4DAEEDE10285_2B152A45C4EE_var*
//#UC END# *4DAEEDE10285_2B152A45C4EE_var*
begin
//#UC START# *4DAEEDE10285_2B152A45C4EE_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_2B152A45C4EE_impl*
end;//TkwCtxInitedDictionaries.DoDoIt

class function TkwCtxInitedDictionaries.GetWordNameForRegister: AnsiString;
begin
 Result := 'Ctx:InitedDictionaries';
end;//TkwCtxInitedDictionaries.GetWordNameForRegister

function TkwCtxInitedDictionaries.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_2B152A45C4EE_var*
//#UC END# *551544E2001A_2B152A45C4EE_var*
begin
//#UC START# *551544E2001A_2B152A45C4EE_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_2B152A45C4EE_impl*
end;//TkwCtxInitedDictionaries.GetResultTypeInfo

function TkwCtxInitedDictionaries.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_2B152A45C4EE_var*
//#UC END# *559687E6025A_2B152A45C4EE_var*
begin
//#UC START# *559687E6025A_2B152A45C4EE_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_2B152A45C4EE_impl*
end;//TkwCtxInitedDictionaries.GetAllParamsCount

function TkwCtxInitedDictionaries.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_2B152A45C4EE_var*
//#UC END# *5617F4D00243_2B152A45C4EE_var*
begin
//#UC START# *5617F4D00243_2B152A45C4EE_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_2B152A45C4EE_impl*
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
//#UC START# *4DAEEDE10285_DDA19C1F4E5B_var*
//#UC END# *4DAEEDE10285_DDA19C1F4E5B_var*
begin
//#UC START# *4DAEEDE10285_DDA19C1F4E5B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_DDA19C1F4E5B_impl*
end;//TkwCtxDisabledForHelp.DoDoIt

class function TkwCtxDisabledForHelp.GetWordNameForRegister: AnsiString;
begin
 Result := 'Ctx:DisabledForHelp';
end;//TkwCtxDisabledForHelp.GetWordNameForRegister

function TkwCtxDisabledForHelp.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_DDA19C1F4E5B_var*
//#UC END# *551544E2001A_DDA19C1F4E5B_var*
begin
//#UC START# *551544E2001A_DDA19C1F4E5B_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_DDA19C1F4E5B_impl*
end;//TkwCtxDisabledForHelp.GetResultTypeInfo

function TkwCtxDisabledForHelp.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_DDA19C1F4E5B_var*
//#UC END# *559687E6025A_DDA19C1F4E5B_var*
begin
//#UC START# *559687E6025A_DDA19C1F4E5B_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_DDA19C1F4E5B_impl*
end;//TkwCtxDisabledForHelp.GetAllParamsCount

function TkwCtxDisabledForHelp.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_DDA19C1F4E5B_var*
//#UC END# *5617F4D00243_DDA19C1F4E5B_var*
begin
//#UC START# *5617F4D00243_DDA19C1F4E5B_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_DDA19C1F4E5B_impl*
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
