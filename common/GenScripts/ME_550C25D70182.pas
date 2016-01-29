unit WordsRTTIPack;

interface

uses
 l3IntfUses
 , tfwScriptingInterfaces
 , l3Interfaces
 , tfwDictionary
 , tfwAxiomaticsResNameGetter
 , tfwClassLike
 , TypInfo
 , tfwPropertyLike
 , tfwTypeInfo
;

implementation

uses
 l3ImplUses
 , seWordsInfo
 , tfwMembersIterator
 , kwForwardDeclaration
 , tfwCodeIterator
 , kwCompiledWordPrim
 , kwCompiledWordContainer
 , kwDualCompiledWordContainer
 , kwRuntimeWordWithCode
 , kwForwardDeclarationHolder
 , kwCompiledWordWorker
 , tfwWordRefList
 , tfwScriptEngineExInterfaces
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , kwCompiledWordWorkerWordRunner
 , kwCompiledWordWorkerWord
 , kwCompiledIfElse
 , SysUtils
;

type
 TWordsRTTIPackResNameGetter = class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
  function ResName: AnsiString;
 end;//TWordsRTTIPackResNameGetter
 
 TkwPopWordGetLeftWordRefValue = class(TtfwClassLike)
  {* Слово скрипта pop:Word:GetLeftWordRefValue
*Тип результата:* TtfwWord
*Пример:*
[code]
OBJECT VAR l_TtfwWord
 anIndex aWord pop:Word:GetLeftWordRefValue >>> l_TtfwWord
[code]  }
  function GetLeftWordRefValue(const aCtx: TtfwContext;
   aWord: TtfwWord;
   anIndex: Integer): TtfwWord;
   {* Реализация слова скрипта pop:Word:GetLeftWordRefValue }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopWordGetLeftWordRefValue
 
 TkwPopWordGetParam = class(TtfwClassLike)
  {* Слово скрипта pop:Word:GetParam
*Тип результата:* TtfwWord
*Пример:*
[code]
OBJECT VAR l_TtfwWord
 anIndex aWord pop:Word:GetParam >>> l_TtfwWord
[code]  }
  function GetParam(const aCtx: TtfwContext;
   aWord: TtfwWord;
   anIndex: Integer): TtfwWord;
   {* Реализация слова скрипта pop:Word:GetParam }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopWordGetParam
 
 TkwPopWordPublicateInMainDictionary = class(TtfwClassLike)
  {* Слово скрипта pop:Word:PublicateInMainDictionary
[panel]Публикует вложенное слово в основном словаре. Если такое слово там уже есть, то создаётся переопределение (Redifinition)[panel]
*Пример:*
[code]
 aWord pop:Word:PublicateInMainDictionary
[code]  }
  procedure PublicateInMainDictionary(const aCtx: TtfwContext;
   aWord: TtfwWord);
   {* Реализация слова скрипта pop:Word:PublicateInMainDictionary }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopWordPublicateInMainDictionary
 
 TkwPopWordSetProducer = class(TtfwClassLike)
  {* Слово скрипта pop:Word:SetProducer
*Пример:*
[code]
 aProducer aWord pop:Word:SetProducer
[code]  }
  procedure SetProducer(const aCtx: TtfwContext;
   aWord: TtfwWord;
   aProducer: TtfwWord);
   {* Реализация слова скрипта pop:Word:SetProducer }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopWordSetProducer
 
 TkwPopWordFindMember = class(TtfwClassLike)
  {* Слово скрипта pop:Word:FindMember
*Тип результата:* TtfwKeyWord
*Пример:*
[code]
OBJECT VAR l_TtfwKeyWord
 aName aWord pop:Word:FindMember >>> l_TtfwKeyWord
[code]  }
  function FindMember(const aCtx: TtfwContext;
   aWord: TtfwWord;
   const aName: Il3CString): TtfwKeyWord;
   {* Реализация слова скрипта pop:Word:FindMember }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopWordFindMember
 
 TkwPopWordGetRef = class(TtfwClassLike)
  {* Слово скрипта pop:Word:GetRef
*Тип результата:* TtfwWord
*Пример:*
[code]
OBJECT VAR l_TtfwWord
 aWord pop:Word:GetRef >>> l_TtfwWord
[code]  }
  function GetRef(const aCtx: TtfwContext;
   aWord: TtfwWord): TtfwWord;
   {* Реализация слова скрипта pop:Word:GetRef }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopWordGetRef
 
 TkwPopWordSourcePointString = class(TtfwClassLike)
  {* Слово скрипта pop:Word:SourcePointString
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 aWord pop:Word:SourcePointString >>> l_String
[code]  }
  function SourcePointString(const aCtx: TtfwContext;
   aWord: TtfwWord): AnsiString;
   {* Реализация слова скрипта pop:Word:SourcePointString }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopWordSourcePointString
 
 TkwPopWordIsVarLike = class(TtfwClassLike)
  {* Слово скрипта pop:Word:IsVarLike
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aWord pop:Word:IsVarLike >>> l_Boolean
[code]  }
  function IsVarLike(const aCtx: TtfwContext;
   aWord: TtfwWord): Boolean;
   {* Реализация слова скрипта pop:Word:IsVarLike }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopWordIsVarLike
 
 TkwPopWordIsInParam = class(TtfwClassLike)
  {* Слово скрипта pop:Word:IsInParam
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aWord pop:Word:IsInParam >>> l_Boolean
[code]  }
  function IsInParam(const aCtx: TtfwContext;
   aWord: TtfwWord): Boolean;
   {* Реализация слова скрипта pop:Word:IsInParam }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopWordIsInParam
 
 TkwPopWordSetValue = class(TtfwClassLike)
  {* Слово скрипта pop:Word:SetValue
*Пример:*
[code]
 aValue aWord pop:Word:SetValue
[code]  }
  procedure SetValue(const aCtx: TtfwContext;
   aWord: TtfwWord;
   const aValue: TtfwStackValue);
   {* Реализация слова скрипта pop:Word:SetValue }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopWordSetValue
 
 TkwPopWordInfo = class(TtfwClassLike)
  {* Слово скрипта pop:Word:Info
*Тип результата:* TtfwWordInfo
*Пример:*
[code]
OBJECT VAR l_TtfwWordInfo
 aWord pop:Word:Info >>> l_TtfwWordInfo
[code]  }
  function Info(const aCtx: TtfwContext;
   aWord: TtfwWord): TtfwWordInfo;
   {* Реализация слова скрипта pop:Word:Info }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopWordInfo
 
 TkwPopWordIsForHelp = class(TtfwClassLike)
  {* Слово скрипта pop:Word:IsForHelp
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aWord pop:Word:IsForHelp >>> l_Boolean
[code]  }
  function IsForHelp(const aCtx: TtfwContext;
   aWord: TtfwWord): Boolean;
   {* Реализация слова скрипта pop:Word:IsForHelp }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopWordIsForHelp
 
 TkwPopWordIsImmediate = class(TtfwClassLike)
  {* Слово скрипта pop:Word:IsImmediate
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aWord pop:Word:IsImmediate >>> l_Boolean
[code]  }
  function IsImmediate(const aCtx: TtfwContext;
   aWord: TtfwWord): Boolean;
   {* Реализация слова скрипта pop:Word:IsImmediate }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopWordIsImmediate
 
 TkwPopWordIncRef = class(TtfwClassLike)
  {* Слово скрипта pop:Word:IncRef
[panel]Увеличивает счётчик ссылок[panel]
*Пример:*
[code]
 aWord pop:Word:IncRef
[code]  }
  procedure IncRef(const aCtx: TtfwContext;
   aWord: TtfwWord);
   {* Реализация слова скрипта pop:Word:IncRef }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopWordIncRef
 
 TkwPopWordDecRef = class(TtfwClassLike)
  {* Слово скрипта pop:Word:DecRef
[panel]Уменьшает счётчик ссылок[panel]
*Пример:*
[code]
 aWord pop:Word:DecRef
[code]  }
  procedure DecRef(const aCtx: TtfwContext;
   aWord: TtfwWord);
   {* Реализация слова скрипта pop:Word:DecRef }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopWordDecRef
 
 TkwPopWordMembersIterator = class(TtfwClassLike)
  {* Слово скрипта pop:Word:MembersIterator
*Тип результата:* ItfwValueList
*Пример:*
[code]
ARRAY VAR l_ItfwValueList
 aWord pop:Word:MembersIterator >>> l_ItfwValueList
[code]  }
  function MembersIterator(const aCtx: TtfwContext;
   aWord: TtfwWord): ItfwValueList;
   {* Реализация слова скрипта pop:Word:MembersIterator }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopWordMembersIterator
 
 TkwPopWordInnerDictionary = class(TtfwClassLike)
  {* Слово скрипта pop:Word:InnerDictionary
*Тип результата:* TtfwDictionary
*Пример:*
[code]
OBJECT VAR l_TtfwDictionary
 aWord pop:Word:InnerDictionary >>> l_TtfwDictionary
[code]  }
  function InnerDictionary(const aCtx: TtfwContext;
   aWord: TtfwWord): TtfwDictionary;
   {* Реализация слова скрипта pop:Word:InnerDictionary }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopWordInnerDictionary
 
 TkwPopWordCodeIterator = class(TtfwClassLike)
  {* Слово скрипта pop:Word:CodeIterator
*Тип результата:* ItfwValueList
*Пример:*
[code]
ARRAY VAR l_ItfwValueList
 aWord pop:Word:CodeIterator >>> l_ItfwValueList
[code]  }
  function CodeIterator(const aCtx: TtfwContext;
   aWord: TtfwWord): ItfwValueList;
   {* Реализация слова скрипта pop:Word:CodeIterator }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopWordCodeIterator
 
 TkwPopWordSetValuePrim = class(TtfwClassLike)
  {* Слово скрипта pop:Word:SetValuePrim
*Пример:*
[code]
 aValue aWord pop:Word:SetValuePrim
[code]  }
  procedure SetValuePrim(const aCtx: TtfwContext;
   aWord: TtfwWord;
   const aValue: TtfwStackValue);
   {* Реализация слова скрипта pop:Word:SetValuePrim }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopWordSetValuePrim
 
 TkwPopWordKeyWord = class(TtfwClassLike)
  {* Слово скрипта pop:Word:KeyWord
*Тип результата:* TtfwKeyWord
*Пример:*
[code]
OBJECT VAR l_TtfwKeyWord
 aWord pop:Word:KeyWord >>> l_TtfwKeyWord
[code]  }
  function KeyWord(const aCtx: TtfwContext;
   aWord: TtfwWord): TtfwKeyWord;
   {* Реализация слова скрипта pop:Word:KeyWord }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopWordKeyWord
 
 TkwPopWordDirectives = class(TtfwPropertyLike)
  {* Слово скрипта pop:Word:Directives
*Тип результата:* Il3CString
*Пример:*
[code]
STRING VAR l_Il3CString
 aWord pop:Word:Directives >>> l_Il3CString
[code]  }
  function Directives(const aCtx: TtfwContext;
   aWord: TtfwWord): Il3CString;
   {* Реализация слова скрипта pop:Word:Directives }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopWordDirectives
 
 TkwPopWordEndBracket = class(TtfwPropertyLike)
  {* Слово скрипта pop:Word:EndBracket
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 aWord pop:Word:EndBracket >>> l_String
[code]  }
  function EndBracket(const aCtx: TtfwContext;
   aWord: TtfwWord): AnsiString;
   {* Реализация слова скрипта pop:Word:EndBracket }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopWordEndBracket
 
 TkwPopWordLeftWordRefValuesCount = class(TtfwPropertyLike)
  {* Слово скрипта pop:Word:LeftWordRefValuesCount
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aWord pop:Word:LeftWordRefValuesCount >>> l_Integer
[code]  }
  function LeftWordRefValuesCount(const aCtx: TtfwContext;
   aWord: TtfwWord): Integer;
   {* Реализация слова скрипта pop:Word:LeftWordRefValuesCount }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopWordLeftWordRefValuesCount
 
 TkwPopWordName = class(TtfwPropertyLike)
  {* Слово скрипта pop:Word:Name
*Тип результата:* Il3CString
*Пример:*
[code]
STRING VAR l_Il3CString
 aWord pop:Word:Name >>> l_Il3CString
[code]  }
  function Name(const aCtx: TtfwContext;
   aWord: TtfwWord): Il3CString;
   {* Реализация слова скрипта pop:Word:Name }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopWordName
 
 TkwPopWordParent = class(TtfwPropertyLike)
  {* Слово скрипта pop:Word:Parent
*Тип результата:* TtfwWord
*Пример:*
[code]
OBJECT VAR l_TtfwWord
 aWord pop:Word:Parent >>> l_TtfwWord
[code]  }
  function Parent(const aCtx: TtfwContext;
   aWord: TtfwWord): TtfwWord;
   {* Реализация слова скрипта pop:Word:Parent }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopWordParent
 
 TkwPopWordProducer = class(TtfwPropertyLike)
  {* Слово скрипта pop:Word:Producer
*Тип результата:* TtfwWord
*Пример:*
[code]
OBJECT VAR l_TtfwWord
 aWord pop:Word:Producer >>> l_TtfwWord
[code]  }
  function Producer(const aCtx: TtfwContext;
   aWord: TtfwWord): TtfwWord;
   {* Реализация слова скрипта pop:Word:Producer }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopWordProducer
 
 TkwPopWordRedefines = class(TtfwPropertyLike)
  {* Слово скрипта pop:Word:Redefines
*Тип результата:* TtfwWord
*Пример:*
[code]
OBJECT VAR l_TtfwWord
 aWord pop:Word:Redefines >>> l_TtfwWord
[code]  }
  function Redefines(const aCtx: TtfwContext;
   aWord: TtfwWord): TtfwWord;
   {* Реализация слова скрипта pop:Word:Redefines }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopWordRedefines
 
end.
