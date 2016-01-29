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
  {* ����������� ������������ ����������� }
  function ResName: AnsiString;
 end;//TTypeInfoPackResNameGetter
 
 TkwIsArray = class(TtfwClassLike)
  {* ����� ������� IsArray
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aSV IsArray >>> l_Boolean
[code]  }
  function IsArray(const aCtx: TtfwContext;
   const aSV: TtfwStackValue): Boolean;
   {* ���������� ����� ������� IsArray }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwIsArray
 
 TkwIsVoid = class(TtfwClassLike)
  {* ����� ������� IsVoid
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aSV IsVoid >>> l_Boolean
[code]  }
  function IsVoid(const aCtx: TtfwContext;
   const aSV: TtfwStackValue): Boolean;
   {* ���������� ����� ������� IsVoid }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwIsVoid
 
 TkwIsObj = class(TtfwClassLike)
  {* ����� ������� IsObj
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aSV IsObj >>> l_Boolean
[code]  }
  function IsObj(const aCtx: TtfwContext;
   const aSV: TtfwStackValue): Boolean;
   {* ���������� ����� ������� IsObj }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwIsObj
 
 TkwIsIntf = class(TtfwClassLike)
  {* ����� ������� IsIntf
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aSV IsIntf >>> l_Boolean
[code]  }
  function IsIntf(const aCtx: TtfwContext;
   const aSV: TtfwStackValue): Boolean;
   {* ���������� ����� ������� IsIntf }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwIsIntf
 
 TkwIsChar = class(TtfwClassLike)
  {* ����� ������� IsChar
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aSV IsChar >>> l_Boolean
[code]  }
  function IsChar(const aCtx: TtfwContext;
   const aSV: TtfwStackValue): Boolean;
   {* ���������� ����� ������� IsChar }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwIsChar
 
 TkwIsString = class(TtfwClassLike)
  {* ����� ������� IsString
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aSV IsString >>> l_Boolean
[code]  }
  function IsString(const aCtx: TtfwContext;
   const aSV: TtfwStackValue): Boolean;
   {* ���������� ����� ������� IsString }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwIsString
 
 TkwIsInt = class(TtfwClassLike)
  {* ����� ������� IsInt
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aSV IsInt >>> l_Boolean
[code]  }
  function IsInt(const aCtx: TtfwContext;
   const aSV: TtfwStackValue): Boolean;
   {* ���������� ����� ������� IsInt }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwIsInt
 
 TkwIsClass = class(TtfwClassLike)
  {* ����� ������� IsClass
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aSV IsClass >>> l_Boolean
[code]  }
  function IsClass(const aCtx: TtfwContext;
   const aSV: TtfwStackValue): Boolean;
   {* ���������� ����� ������� IsClass }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwIsClass
 
 TkwToPrintable = class(TtfwClassLike)
  {* ����� ������� ToPrintable
*��� ����������:* Il3CString
*������:*
[code]
STRING VAR l_Il3CString
 aSV ToPrintable >>> l_Il3CString
[code]  }
  function ToPrintable(const aCtx: TtfwContext;
   const aSV: TtfwStackValue): Il3CString;
   {* ���������� ����� ������� ToPrintable }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwToPrintable
 
 TkwIsBool = class(TtfwClassLike)
  {* ����� ������� IsBool
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aSV IsBool >>> l_Boolean
[code]  }
  function IsBool(const aCtx: TtfwContext;
   const aSV: TtfwStackValue): Boolean;
   {* ���������� ����� ������� IsBool }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwIsBool
 
 TkwIsTypeOf = class(TtfwClassLike)
  {* ����� ������� IsTypeOf
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aType aSV IsTypeOf >>> l_Boolean
[code]  }
  function IsTypeOf(const aCtx: TtfwContext;
   const aSV: TtfwStackValue;
   aType: TtfwValueType): Boolean;
   {* ���������� ����� ������� IsTypeOf }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwIsTypeOf
 
 TkwIsNil = class(TtfwClassLike)
  {* ����� ������� IsNil
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aSV IsNil >>> l_Boolean
[code]  }
  function IsNil(const aCtx: TtfwContext;
   const aSV: TtfwStackValue): Boolean;
   {* ���������� ����� ������� IsNil }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwIsNil
 
 TkwCtxIncludeModifier = class(TtfwGlobalKeyWord)
  {* ����� ������� Ctx:IncludeModifier
[panel]�������� ����������� � ���������� � ����[panel]
*������:*
[code]
 aModifier Ctx:IncludeModifier
[code]  }
  procedure Ctx_IncludeModifier(const aCtx: TtfwContext;
   aModifier: TtfwWordModifier);
   {* ���������� ����� ������� Ctx:IncludeModifier }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCtxIncludeModifier
 
 TkwCtxPushCompiler = class(TtfwGlobalKeyWord)
  {* ����� ������� Ctx:PushCompiler
*��� ����������:* TtfwCompiler
*������:*
[code]
OBJECT VAR l_TtfwCompiler
 Ctx:PushCompiler >>> l_TtfwCompiler
[code]  }
  function Ctx_PushCompiler(const aCtx: TtfwContext): TtfwCompiler;
   {* ���������� ����� ������� Ctx:PushCompiler }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCtxPushCompiler
 
 TkwCtxPushFinder = class(TtfwGlobalKeyWord)
  {* ����� ������� Ctx:PushFinder
*��� ����������:* TtfwKeywordFinder
*������:*
[code]
OBJECT VAR l_TtfwKeywordFinder
 Ctx:PushFinder >>> l_TtfwKeywordFinder
[code]  }
  function Ctx_PushFinder(const aCtx: TtfwContext): TtfwKeywordFinder;
   {* ���������� ����� ������� Ctx:PushFinder }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCtxPushFinder
 
 TkwPopCompilerSetToCtx = class(TtfwGlobalKeyWord)
  {* ����� ������� pop:Compiler:SetToCtx
*������:*
[code]
 aCompiler pop:Compiler:SetToCtx
[code]  }
  procedure pop_Compiler_SetToCtx(const aCtx: TtfwContext;
   aCompiler: TtfwCompiler);
   {* ���������� ����� ������� pop:Compiler:SetToCtx }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopCompilerSetToCtx
 
 TkwPopFinderSetToCtx = class(TtfwGlobalKeyWord)
  {* ����� ������� pop:Finder:SetToCtx
*������:*
[code]
 aFinder pop:Finder:SetToCtx
[code]  }
  procedure pop_Finder_SetToCtx(const aCtx: TtfwContext;
   aFinder: TtfwKeywordFinder);
   {* ���������� ����� ������� pop:Finder:SetToCtx }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopFinderSetToCtx
 
 TkwNotImplemented = class(TtfwGlobalKeyWord)
  {* ����� ������� NotImplemented
*������:*
[code]
 NotImplemented
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwNotImplemented
 
 TkwCtxNewWordDefinitor = class(TtfwGlobalKeyWord)
  {* ����� ������� Ctx:NewWordDefinitor
*��� ����������:* TtfwNewWordDefinitor
*������:*
[code]
OBJECT VAR l_TtfwNewWordDefinitor
 Ctx:NewWordDefinitor >>> l_TtfwNewWordDefinitor
[code]  }
  function Ctx_NewWordDefinitor(const aCtx: TtfwContext): TtfwNewWordDefinitor;
   {* ���������� ����� ������� Ctx:NewWordDefinitor }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCtxNewWordDefinitor
 
 TkwCtxClearTypeInfo = class(TtfwGlobalKeyWord)
  {* ����� ������� Ctx:ClearTypeInfo
*������:*
[code]
 Ctx:ClearTypeInfo
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCtxClearTypeInfo
 
 TkwCtxSetWordProducerForCompiledClass = class(TtfwGlobalKeyWord)
  {* ����� ������� Ctx:SetWordProducerForCompiledClass
*������:*
[code]
 aProducer Ctx:SetWordProducerForCompiledClass
[code]  }
  procedure Ctx_SetWordProducerForCompiledClass(const aCtx: TtfwContext;
   aProducer: TtfwWord);
   {* ���������� ����� ������� Ctx:SetWordProducerForCompiledClass }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCtxSetWordProducerForCompiledClass
 
 TkwCtxSetNewWordName = class(TtfwGlobalKeyWord)
  {* ����� ������� Ctx:SetNewWordName
*������:*
[code]
 aValue Ctx:SetNewWordName
[code]  }
  procedure Ctx_SetNewWordName(const aCtx: TtfwContext;
   const aValue: Il3CString);
   {* ���������� ����� ������� Ctx:SetNewWordName }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCtxSetNewWordName
 
 TkwCtxIncludeTypeModifier = class(TtfwGlobalKeyWord)
  {* ����� ������� Ctx:IncludeTypeModifier
*������:*
[code]
 aType Ctx:IncludeTypeModifier
[code]  }
  procedure Ctx_IncludeTypeModifier(const aCtx: TtfwContext;
   aType: TtfwValueType);
   {* ���������� ����� ������� Ctx:IncludeTypeModifier }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCtxIncludeTypeModifier
 
 TkwCtxWordDefiningNow = class(TtfwGlobalKeyWord)
  {* ����� ������� Ctx:WordDefiningNow
*��� ����������:* TtfwWord
*������:*
[code]
OBJECT VAR l_TtfwWord
 Ctx:WordDefiningNow >>> l_TtfwWord
[code]  }
  function Ctx_WordDefiningNow(const aCtx: TtfwContext): TtfwWord;
   {* ���������� ����� ������� Ctx:WordDefiningNow }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCtxWordDefiningNow
 
 TkwCtxKeyWordDefiningNow = class(TtfwGlobalKeyWord)
  {* ����� ������� Ctx:KeyWordDefiningNow
*��� ����������:* TtfwKeyWord
*������:*
[code]
OBJECT VAR l_TtfwKeyWord
 Ctx:KeyWordDefiningNow >>> l_TtfwKeyWord
[code]  }
  function Ctx_KeyWordDefiningNow(const aCtx: TtfwContext): TtfwKeyWord;
   {* ���������� ����� ������� Ctx:KeyWordDefiningNow }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCtxKeyWordDefiningNow
 
 TkwCtxIncludeAccessType = class(TtfwGlobalKeyWord)
  {* ����� ������� Ctx:IncludeAccessType
*������:*
[code]
 anAccess Ctx:IncludeAccessType
[code]  }
  procedure Ctx_IncludeAccessType(const aCtx: TtfwContext;
   anAccess: TtfwAccessType);
   {* ���������� ����� ������� Ctx:IncludeAccessType }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCtxIncludeAccessType
 
 TkwCtxIncludeLinkType = class(TtfwGlobalKeyWord)
  {* ����� ������� Ctx:IncludeLinkType
*������:*
[code]
 aLinkType Ctx:IncludeLinkType
[code]  }
  procedure Ctx_IncludeLinkType(const aCtx: TtfwContext;
   aLinkType: TtfwLinkType);
   {* ���������� ����� ������� Ctx:IncludeLinkType }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCtxIncludeLinkType
 
 TkwCtxValueTypes = class(TtfwGlobalKeyWord)
  {* ����� ������� Ctx:ValueTypes
*��� ����������:* TtfwValueTypes
*������:*
[code]
OBJECT VAR l_TtfwValueTypes
 Ctx:ValueTypes >>> l_TtfwValueTypes
[code]  }
  function Ctx_ValueTypes(const aCtx: TtfwContext): TtfwValueTypes;
   {* ���������� ����� ������� Ctx:ValueTypes }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCtxValueTypes
 
 TkwCtxSetValueTypes = class(TtfwGlobalKeyWord)
  {* ����� ������� Ctx:SetValueTypes
*������:*
[code]
 aTypes Ctx:SetValueTypes
[code]  }
  procedure Ctx_SetValueTypes(const aCtx: TtfwContext;
   aTypes: TtfwValueTypes);
   {* ���������� ����� ������� Ctx:SetValueTypes }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCtxSetValueTypes
 
 TkwCtxIncludeValueTypes = class(TtfwGlobalKeyWord)
  {* ����� ������� Ctx:IncludeValueTypes
*������:*
[code]
 aTypes Ctx:IncludeValueTypes
[code]  }
  procedure Ctx_IncludeValueTypes(const aCtx: TtfwContext;
   aTypes: TtfwValueTypes);
   {* ���������� ����� ������� Ctx:IncludeValueTypes }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCtxIncludeValueTypes
 
 TkwCtxWordInfo = class(TtfwGlobalKeyWord)
  {* ����� ������� Ctx:WordInfo
*��� ����������:* TtfwWordInfo
*������:*
[code]
OBJECT VAR l_TtfwWordInfo
 Ctx:WordInfo >>> l_TtfwWordInfo
[code]  }
  function Ctx_WordInfo(const aCtx: TtfwContext): TtfwWordInfo;
   {* ���������� ����� ������� Ctx:WordInfo }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCtxWordInfo
 
 TkwCtxResolveIncludedFilePath = class(TtfwGlobalKeyWord)
  {* ����� ������� Ctx:ResolveIncludedFilePath
*��� ����������:* String
*������:*
[code]
STRING VAR l_String
 aFileName Ctx:ResolveIncludedFilePath >>> l_String
[code]  }
  function Ctx_ResolveIncludedFilePath(const aCtx: TtfwContext;
   const aFileName: AnsiString): AnsiString;
   {* ���������� ����� ������� Ctx:ResolveIncludedFilePath }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCtxResolveIncludedFilePath
 
 TkwCtxMainDictionary = class(TtfwGlobalKeyWord)
  {* ����� ������� Ctx:MainDictionary
*��� ����������:* TtfwMainDictionary
*������:*
[code]
OBJECT VAR l_TtfwMainDictionary
 Ctx:MainDictionary >>> l_TtfwMainDictionary
[code]  }
  function Ctx_MainDictionary(const aCtx: TtfwContext): TtfwMainDictionary;
   {* ���������� ����� ������� Ctx:MainDictionary }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCtxMainDictionary
 
 TkwCtxStandardDictionaries = class(TtfwGlobalKeyWord)
  {* ����� ������� Ctx:StandardDictionaries
*��� ����������:* ItfwValueList
*������:*
[code]
ARRAY VAR l_ItfwValueList
 Ctx:StandardDictionaries >>> l_ItfwValueList
[code]  }
  function Ctx_StandardDictionaries(const aCtx: TtfwContext): ItfwValueList;
   {* ���������� ����� ������� Ctx:StandardDictionaries }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCtxStandardDictionaries
 
 TkwCtxDictionaries = class(TtfwGlobalKeyWord)
  {* ����� ������� Ctx:Dictionaries
*��� ����������:* ItfwValueList
*������:*
[code]
ARRAY VAR l_ItfwValueList
 Ctx:Dictionaries >>> l_ItfwValueList
[code]  }
  function Ctx_Dictionaries(const aCtx: TtfwContext): ItfwValueList;
   {* ���������� ����� ������� Ctx:Dictionaries }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCtxDictionaries
 
 TkwCtxInitedDictionaries = class(TtfwGlobalKeyWord)
  {* ����� ������� Ctx:InitedDictionaries
*��� ����������:* ItfwValueList
*������:*
[code]
ARRAY VAR l_ItfwValueList
 Ctx:InitedDictionaries >>> l_ItfwValueList
[code]  }
  function Ctx_InitedDictionaries(const aCtx: TtfwContext): ItfwValueList;
   {* ���������� ����� ������� Ctx:InitedDictionaries }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCtxInitedDictionaries
 
 TkwCtxDisabledForHelp = class(TtfwGlobalKeyWord)
  {* ����� ������� Ctx:DisabledForHelp
*��� ����������:* ItfwValueList
*������:*
[code]
ARRAY VAR l_ItfwValueList
 Ctx:DisabledForHelp >>> l_ItfwValueList
[code]  }
  function Ctx_DisabledForHelp(const aCtx: TtfwContext): ItfwValueList;
   {* ���������� ����� ������� Ctx:DisabledForHelp }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCtxDisabledForHelp
 
end.
