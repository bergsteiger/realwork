unit TypeInfoPack;

interface

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

implementation

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
 TTypeInfoPackResNameGetter = class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
  function ResName: AnsiString;
 end;//TTypeInfoPackResNameGetter
 
 TkwIsArray = class(TtfwClassLike)
  {* Слово скрипта IsArray
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aSV IsArray >>> l_Boolean
[code]  }
  function IsArray(const aCtx: TtfwContext;
   const aSV: TtfwStackValue): Boolean;
   {* Реализация слова скрипта IsArray }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwIsArray
 
 TkwIsVoid = class(TtfwClassLike)
  {* Слово скрипта IsVoid
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aSV IsVoid >>> l_Boolean
[code]  }
  function IsVoid(const aCtx: TtfwContext;
   const aSV: TtfwStackValue): Boolean;
   {* Реализация слова скрипта IsVoid }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwIsVoid
 
 TkwIsObj = class(TtfwClassLike)
  {* Слово скрипта IsObj
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aSV IsObj >>> l_Boolean
[code]  }
  function IsObj(const aCtx: TtfwContext;
   const aSV: TtfwStackValue): Boolean;
   {* Реализация слова скрипта IsObj }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwIsObj
 
 TkwIsIntf = class(TtfwClassLike)
  {* Слово скрипта IsIntf
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aSV IsIntf >>> l_Boolean
[code]  }
  function IsIntf(const aCtx: TtfwContext;
   const aSV: TtfwStackValue): Boolean;
   {* Реализация слова скрипта IsIntf }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwIsIntf
 
 TkwIsChar = class(TtfwClassLike)
  {* Слово скрипта IsChar
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aSV IsChar >>> l_Boolean
[code]  }
  function IsChar(const aCtx: TtfwContext;
   const aSV: TtfwStackValue): Boolean;
   {* Реализация слова скрипта IsChar }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwIsChar
 
 TkwIsString = class(TtfwClassLike)
  {* Слово скрипта IsString
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aSV IsString >>> l_Boolean
[code]  }
  function IsString(const aCtx: TtfwContext;
   const aSV: TtfwStackValue): Boolean;
   {* Реализация слова скрипта IsString }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwIsString
 
 TkwIsInt = class(TtfwClassLike)
  {* Слово скрипта IsInt
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aSV IsInt >>> l_Boolean
[code]  }
  function IsInt(const aCtx: TtfwContext;
   const aSV: TtfwStackValue): Boolean;
   {* Реализация слова скрипта IsInt }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwIsInt
 
 TkwIsClass = class(TtfwClassLike)
  {* Слово скрипта IsClass
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aSV IsClass >>> l_Boolean
[code]  }
  function IsClass(const aCtx: TtfwContext;
   const aSV: TtfwStackValue): Boolean;
   {* Реализация слова скрипта IsClass }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwIsClass
 
 TkwToPrintable = class(TtfwClassLike)
  {* Слово скрипта ToPrintable
*Тип результата:* Il3CString
*Пример:*
[code]
STRING VAR l_Il3CString
 aSV ToPrintable >>> l_Il3CString
[code]  }
  function ToPrintable(const aCtx: TtfwContext;
   const aSV: TtfwStackValue): Il3CString;
   {* Реализация слова скрипта ToPrintable }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwToPrintable
 
 TkwIsBool = class(TtfwClassLike)
  {* Слово скрипта IsBool
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aSV IsBool >>> l_Boolean
[code]  }
  function IsBool(const aCtx: TtfwContext;
   const aSV: TtfwStackValue): Boolean;
   {* Реализация слова скрипта IsBool }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwIsBool
 
 TkwIsTypeOf = class(TtfwClassLike)
  {* Слово скрипта IsTypeOf
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aType aSV IsTypeOf >>> l_Boolean
[code]  }
  function IsTypeOf(const aCtx: TtfwContext;
   const aSV: TtfwStackValue;
   aType: TtfwValueType): Boolean;
   {* Реализация слова скрипта IsTypeOf }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwIsTypeOf
 
 TkwIsNil = class(TtfwClassLike)
  {* Слово скрипта IsNil
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aSV IsNil >>> l_Boolean
[code]  }
  function IsNil(const aCtx: TtfwContext;
   const aSV: TtfwStackValue): Boolean;
   {* Реализация слова скрипта IsNil }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwIsNil
 
 TkwCtxIncludeModifier = class(TtfwGlobalKeyWord)
  {* Слово скрипта Ctx:IncludeModifier
[panel]Включает модификатор в информацию о типе[panel]
*Пример:*
[code]
 aModifier Ctx:IncludeModifier
[code]  }
  procedure Ctx_IncludeModifier(const aCtx: TtfwContext;
   aModifier: TtfwWordModifier);
   {* Реализация слова скрипта Ctx:IncludeModifier }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCtxIncludeModifier
 
 TkwCtxPushCompiler = class(TtfwGlobalKeyWord)
  {* Слово скрипта Ctx:PushCompiler
*Тип результата:* TtfwCompiler
*Пример:*
[code]
OBJECT VAR l_TtfwCompiler
 Ctx:PushCompiler >>> l_TtfwCompiler
[code]  }
  function Ctx_PushCompiler(const aCtx: TtfwContext): TtfwCompiler;
   {* Реализация слова скрипта Ctx:PushCompiler }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCtxPushCompiler
 
 TkwCtxPushFinder = class(TtfwGlobalKeyWord)
  {* Слово скрипта Ctx:PushFinder
*Тип результата:* TtfwKeywordFinder
*Пример:*
[code]
OBJECT VAR l_TtfwKeywordFinder
 Ctx:PushFinder >>> l_TtfwKeywordFinder
[code]  }
  function Ctx_PushFinder(const aCtx: TtfwContext): TtfwKeywordFinder;
   {* Реализация слова скрипта Ctx:PushFinder }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCtxPushFinder
 
 TkwPopCompilerSetToCtx = class(TtfwGlobalKeyWord)
  {* Слово скрипта pop:Compiler:SetToCtx
*Пример:*
[code]
 aCompiler pop:Compiler:SetToCtx
[code]  }
  procedure pop_Compiler_SetToCtx(const aCtx: TtfwContext;
   aCompiler: TtfwCompiler);
   {* Реализация слова скрипта pop:Compiler:SetToCtx }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopCompilerSetToCtx
 
 TkwPopFinderSetToCtx = class(TtfwGlobalKeyWord)
  {* Слово скрипта pop:Finder:SetToCtx
*Пример:*
[code]
 aFinder pop:Finder:SetToCtx
[code]  }
  procedure pop_Finder_SetToCtx(const aCtx: TtfwContext;
   aFinder: TtfwKeywordFinder);
   {* Реализация слова скрипта pop:Finder:SetToCtx }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopFinderSetToCtx
 
 TkwNotImplemented = class(TtfwGlobalKeyWord)
  {* Слово скрипта NotImplemented
*Пример:*
[code]
 NotImplemented
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwNotImplemented
 
 TkwCtxNewWordDefinitor = class(TtfwGlobalKeyWord)
  {* Слово скрипта Ctx:NewWordDefinitor
*Тип результата:* TtfwNewWordDefinitor
*Пример:*
[code]
OBJECT VAR l_TtfwNewWordDefinitor
 Ctx:NewWordDefinitor >>> l_TtfwNewWordDefinitor
[code]  }
  function Ctx_NewWordDefinitor(const aCtx: TtfwContext): TtfwNewWordDefinitor;
   {* Реализация слова скрипта Ctx:NewWordDefinitor }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCtxNewWordDefinitor
 
 TkwCtxClearTypeInfo = class(TtfwGlobalKeyWord)
  {* Слово скрипта Ctx:ClearTypeInfo
*Пример:*
[code]
 Ctx:ClearTypeInfo
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCtxClearTypeInfo
 
 TkwCtxSetWordProducerForCompiledClass = class(TtfwGlobalKeyWord)
  {* Слово скрипта Ctx:SetWordProducerForCompiledClass
*Пример:*
[code]
 aProducer Ctx:SetWordProducerForCompiledClass
[code]  }
  procedure Ctx_SetWordProducerForCompiledClass(const aCtx: TtfwContext;
   aProducer: TtfwWord);
   {* Реализация слова скрипта Ctx:SetWordProducerForCompiledClass }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCtxSetWordProducerForCompiledClass
 
 TkwCtxSetNewWordName = class(TtfwGlobalKeyWord)
  {* Слово скрипта Ctx:SetNewWordName
*Пример:*
[code]
 aValue Ctx:SetNewWordName
[code]  }
  procedure Ctx_SetNewWordName(const aCtx: TtfwContext;
   const aValue: Il3CString);
   {* Реализация слова скрипта Ctx:SetNewWordName }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCtxSetNewWordName
 
 TkwCtxIncludeTypeModifier = class(TtfwGlobalKeyWord)
  {* Слово скрипта Ctx:IncludeTypeModifier
*Пример:*
[code]
 aType Ctx:IncludeTypeModifier
[code]  }
  procedure Ctx_IncludeTypeModifier(const aCtx: TtfwContext;
   aType: TtfwValueType);
   {* Реализация слова скрипта Ctx:IncludeTypeModifier }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCtxIncludeTypeModifier
 
 TkwCtxWordDefiningNow = class(TtfwGlobalKeyWord)
  {* Слово скрипта Ctx:WordDefiningNow
*Тип результата:* TtfwWord
*Пример:*
[code]
OBJECT VAR l_TtfwWord
 Ctx:WordDefiningNow >>> l_TtfwWord
[code]  }
  function Ctx_WordDefiningNow(const aCtx: TtfwContext): TtfwWord;
   {* Реализация слова скрипта Ctx:WordDefiningNow }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCtxWordDefiningNow
 
 TkwCtxKeyWordDefiningNow = class(TtfwGlobalKeyWord)
  {* Слово скрипта Ctx:KeyWordDefiningNow
*Тип результата:* TtfwKeyWord
*Пример:*
[code]
OBJECT VAR l_TtfwKeyWord
 Ctx:KeyWordDefiningNow >>> l_TtfwKeyWord
[code]  }
  function Ctx_KeyWordDefiningNow(const aCtx: TtfwContext): TtfwKeyWord;
   {* Реализация слова скрипта Ctx:KeyWordDefiningNow }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCtxKeyWordDefiningNow
 
 TkwCtxIncludeAccessType = class(TtfwGlobalKeyWord)
  {* Слово скрипта Ctx:IncludeAccessType
*Пример:*
[code]
 anAccess Ctx:IncludeAccessType
[code]  }
  procedure Ctx_IncludeAccessType(const aCtx: TtfwContext;
   anAccess: TtfwAccessType);
   {* Реализация слова скрипта Ctx:IncludeAccessType }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCtxIncludeAccessType
 
 TkwCtxIncludeLinkType = class(TtfwGlobalKeyWord)
  {* Слово скрипта Ctx:IncludeLinkType
*Пример:*
[code]
 aLinkType Ctx:IncludeLinkType
[code]  }
  procedure Ctx_IncludeLinkType(const aCtx: TtfwContext;
   aLinkType: TtfwLinkType);
   {* Реализация слова скрипта Ctx:IncludeLinkType }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCtxIncludeLinkType
 
 TkwCtxValueTypes = class(TtfwGlobalKeyWord)
  {* Слово скрипта Ctx:ValueTypes
*Тип результата:* TtfwValueTypes
*Пример:*
[code]
OBJECT VAR l_TtfwValueTypes
 Ctx:ValueTypes >>> l_TtfwValueTypes
[code]  }
  function Ctx_ValueTypes(const aCtx: TtfwContext): TtfwValueTypes;
   {* Реализация слова скрипта Ctx:ValueTypes }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCtxValueTypes
 
 TkwCtxSetValueTypes = class(TtfwGlobalKeyWord)
  {* Слово скрипта Ctx:SetValueTypes
*Пример:*
[code]
 aTypes Ctx:SetValueTypes
[code]  }
  procedure Ctx_SetValueTypes(const aCtx: TtfwContext;
   aTypes: TtfwValueTypes);
   {* Реализация слова скрипта Ctx:SetValueTypes }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCtxSetValueTypes
 
 TkwCtxIncludeValueTypes = class(TtfwGlobalKeyWord)
  {* Слово скрипта Ctx:IncludeValueTypes
*Пример:*
[code]
 aTypes Ctx:IncludeValueTypes
[code]  }
  procedure Ctx_IncludeValueTypes(const aCtx: TtfwContext;
   aTypes: TtfwValueTypes);
   {* Реализация слова скрипта Ctx:IncludeValueTypes }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCtxIncludeValueTypes
 
 TkwCtxWordInfo = class(TtfwGlobalKeyWord)
  {* Слово скрипта Ctx:WordInfo
*Тип результата:* TtfwWordInfo
*Пример:*
[code]
OBJECT VAR l_TtfwWordInfo
 Ctx:WordInfo >>> l_TtfwWordInfo
[code]  }
  function Ctx_WordInfo(const aCtx: TtfwContext): TtfwWordInfo;
   {* Реализация слова скрипта Ctx:WordInfo }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCtxWordInfo
 
 TkwCtxResolveIncludedFilePath = class(TtfwGlobalKeyWord)
  {* Слово скрипта Ctx:ResolveIncludedFilePath
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 aFileName Ctx:ResolveIncludedFilePath >>> l_String
[code]  }
  function Ctx_ResolveIncludedFilePath(const aCtx: TtfwContext;
   const aFileName: AnsiString): AnsiString;
   {* Реализация слова скрипта Ctx:ResolveIncludedFilePath }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCtxResolveIncludedFilePath
 
 TkwCtxMainDictionary = class(TtfwGlobalKeyWord)
  {* Слово скрипта Ctx:MainDictionary
*Тип результата:* TtfwMainDictionary
*Пример:*
[code]
OBJECT VAR l_TtfwMainDictionary
 Ctx:MainDictionary >>> l_TtfwMainDictionary
[code]  }
  function Ctx_MainDictionary(const aCtx: TtfwContext): TtfwMainDictionary;
   {* Реализация слова скрипта Ctx:MainDictionary }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCtxMainDictionary
 
 TkwCtxStandardDictionaries = class(TtfwGlobalKeyWord)
  {* Слово скрипта Ctx:StandardDictionaries
*Тип результата:* ItfwValueList
*Пример:*
[code]
ARRAY VAR l_ItfwValueList
 Ctx:StandardDictionaries >>> l_ItfwValueList
[code]  }
  function Ctx_StandardDictionaries(const aCtx: TtfwContext): ItfwValueList;
   {* Реализация слова скрипта Ctx:StandardDictionaries }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCtxStandardDictionaries
 
 TkwCtxDictionaries = class(TtfwGlobalKeyWord)
  {* Слово скрипта Ctx:Dictionaries
*Тип результата:* ItfwValueList
*Пример:*
[code]
ARRAY VAR l_ItfwValueList
 Ctx:Dictionaries >>> l_ItfwValueList
[code]  }
  function Ctx_Dictionaries(const aCtx: TtfwContext): ItfwValueList;
   {* Реализация слова скрипта Ctx:Dictionaries }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCtxDictionaries
 
 TkwCtxInitedDictionaries = class(TtfwGlobalKeyWord)
  {* Слово скрипта Ctx:InitedDictionaries
*Тип результата:* ItfwValueList
*Пример:*
[code]
ARRAY VAR l_ItfwValueList
 Ctx:InitedDictionaries >>> l_ItfwValueList
[code]  }
  function Ctx_InitedDictionaries(const aCtx: TtfwContext): ItfwValueList;
   {* Реализация слова скрипта Ctx:InitedDictionaries }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCtxInitedDictionaries
 
 TkwCtxDisabledForHelp = class(TtfwGlobalKeyWord)
  {* Слово скрипта Ctx:DisabledForHelp
*Тип результата:* ItfwValueList
*Пример:*
[code]
ARRAY VAR l_ItfwValueList
 Ctx:DisabledForHelp >>> l_ItfwValueList
[code]  }
  function Ctx_DisabledForHelp(const aCtx: TtfwContext): ItfwValueList;
   {* Реализация слова скрипта Ctx:DisabledForHelp }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCtxDisabledForHelp
 
end.
