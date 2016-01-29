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
  {* ����������� ������������ ����������� }
  function ResName: AnsiString;
 end;//TWordsRTTIPackResNameGetter
 
 TkwPopWordGetLeftWordRefValue = class(TtfwClassLike)
  {* ����� ������� pop:Word:GetLeftWordRefValue
*��� ����������:* TtfwWord
*������:*
[code]
OBJECT VAR l_TtfwWord
 anIndex aWord pop:Word:GetLeftWordRefValue >>> l_TtfwWord
[code]  }
  function GetLeftWordRefValue(const aCtx: TtfwContext;
   aWord: TtfwWord;
   anIndex: Integer): TtfwWord;
   {* ���������� ����� ������� pop:Word:GetLeftWordRefValue }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopWordGetLeftWordRefValue
 
 TkwPopWordGetParam = class(TtfwClassLike)
  {* ����� ������� pop:Word:GetParam
*��� ����������:* TtfwWord
*������:*
[code]
OBJECT VAR l_TtfwWord
 anIndex aWord pop:Word:GetParam >>> l_TtfwWord
[code]  }
  function GetParam(const aCtx: TtfwContext;
   aWord: TtfwWord;
   anIndex: Integer): TtfwWord;
   {* ���������� ����� ������� pop:Word:GetParam }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopWordGetParam
 
 TkwPopWordPublicateInMainDictionary = class(TtfwClassLike)
  {* ����� ������� pop:Word:PublicateInMainDictionary
[panel]��������� ��������� ����� � �������� �������. ���� ����� ����� ��� ��� ����, �� �������� ��������������� (Redifinition)[panel]
*������:*
[code]
 aWord pop:Word:PublicateInMainDictionary
[code]  }
  procedure PublicateInMainDictionary(const aCtx: TtfwContext;
   aWord: TtfwWord);
   {* ���������� ����� ������� pop:Word:PublicateInMainDictionary }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopWordPublicateInMainDictionary
 
 TkwPopWordSetProducer = class(TtfwClassLike)
  {* ����� ������� pop:Word:SetProducer
*������:*
[code]
 aProducer aWord pop:Word:SetProducer
[code]  }
  procedure SetProducer(const aCtx: TtfwContext;
   aWord: TtfwWord;
   aProducer: TtfwWord);
   {* ���������� ����� ������� pop:Word:SetProducer }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopWordSetProducer
 
 TkwPopWordFindMember = class(TtfwClassLike)
  {* ����� ������� pop:Word:FindMember
*��� ����������:* TtfwKeyWord
*������:*
[code]
OBJECT VAR l_TtfwKeyWord
 aName aWord pop:Word:FindMember >>> l_TtfwKeyWord
[code]  }
  function FindMember(const aCtx: TtfwContext;
   aWord: TtfwWord;
   const aName: Il3CString): TtfwKeyWord;
   {* ���������� ����� ������� pop:Word:FindMember }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopWordFindMember
 
 TkwPopWordGetRef = class(TtfwClassLike)
  {* ����� ������� pop:Word:GetRef
*��� ����������:* TtfwWord
*������:*
[code]
OBJECT VAR l_TtfwWord
 aWord pop:Word:GetRef >>> l_TtfwWord
[code]  }
  function GetRef(const aCtx: TtfwContext;
   aWord: TtfwWord): TtfwWord;
   {* ���������� ����� ������� pop:Word:GetRef }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopWordGetRef
 
 TkwPopWordSourcePointString = class(TtfwClassLike)
  {* ����� ������� pop:Word:SourcePointString
*��� ����������:* String
*������:*
[code]
STRING VAR l_String
 aWord pop:Word:SourcePointString >>> l_String
[code]  }
  function SourcePointString(const aCtx: TtfwContext;
   aWord: TtfwWord): AnsiString;
   {* ���������� ����� ������� pop:Word:SourcePointString }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopWordSourcePointString
 
 TkwPopWordIsVarLike = class(TtfwClassLike)
  {* ����� ������� pop:Word:IsVarLike
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aWord pop:Word:IsVarLike >>> l_Boolean
[code]  }
  function IsVarLike(const aCtx: TtfwContext;
   aWord: TtfwWord): Boolean;
   {* ���������� ����� ������� pop:Word:IsVarLike }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopWordIsVarLike
 
 TkwPopWordIsInParam = class(TtfwClassLike)
  {* ����� ������� pop:Word:IsInParam
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aWord pop:Word:IsInParam >>> l_Boolean
[code]  }
  function IsInParam(const aCtx: TtfwContext;
   aWord: TtfwWord): Boolean;
   {* ���������� ����� ������� pop:Word:IsInParam }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopWordIsInParam
 
 TkwPopWordSetValue = class(TtfwClassLike)
  {* ����� ������� pop:Word:SetValue
*������:*
[code]
 aValue aWord pop:Word:SetValue
[code]  }
  procedure SetValue(const aCtx: TtfwContext;
   aWord: TtfwWord;
   const aValue: TtfwStackValue);
   {* ���������� ����� ������� pop:Word:SetValue }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopWordSetValue
 
 TkwPopWordInfo = class(TtfwClassLike)
  {* ����� ������� pop:Word:Info
*��� ����������:* TtfwWordInfo
*������:*
[code]
OBJECT VAR l_TtfwWordInfo
 aWord pop:Word:Info >>> l_TtfwWordInfo
[code]  }
  function Info(const aCtx: TtfwContext;
   aWord: TtfwWord): TtfwWordInfo;
   {* ���������� ����� ������� pop:Word:Info }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopWordInfo
 
 TkwPopWordIsForHelp = class(TtfwClassLike)
  {* ����� ������� pop:Word:IsForHelp
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aWord pop:Word:IsForHelp >>> l_Boolean
[code]  }
  function IsForHelp(const aCtx: TtfwContext;
   aWord: TtfwWord): Boolean;
   {* ���������� ����� ������� pop:Word:IsForHelp }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopWordIsForHelp
 
 TkwPopWordIsImmediate = class(TtfwClassLike)
  {* ����� ������� pop:Word:IsImmediate
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aWord pop:Word:IsImmediate >>> l_Boolean
[code]  }
  function IsImmediate(const aCtx: TtfwContext;
   aWord: TtfwWord): Boolean;
   {* ���������� ����� ������� pop:Word:IsImmediate }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopWordIsImmediate
 
 TkwPopWordIncRef = class(TtfwClassLike)
  {* ����� ������� pop:Word:IncRef
[panel]����������� ������� ������[panel]
*������:*
[code]
 aWord pop:Word:IncRef
[code]  }
  procedure IncRef(const aCtx: TtfwContext;
   aWord: TtfwWord);
   {* ���������� ����� ������� pop:Word:IncRef }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopWordIncRef
 
 TkwPopWordDecRef = class(TtfwClassLike)
  {* ����� ������� pop:Word:DecRef
[panel]��������� ������� ������[panel]
*������:*
[code]
 aWord pop:Word:DecRef
[code]  }
  procedure DecRef(const aCtx: TtfwContext;
   aWord: TtfwWord);
   {* ���������� ����� ������� pop:Word:DecRef }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopWordDecRef
 
 TkwPopWordMembersIterator = class(TtfwClassLike)
  {* ����� ������� pop:Word:MembersIterator
*��� ����������:* ItfwValueList
*������:*
[code]
ARRAY VAR l_ItfwValueList
 aWord pop:Word:MembersIterator >>> l_ItfwValueList
[code]  }
  function MembersIterator(const aCtx: TtfwContext;
   aWord: TtfwWord): ItfwValueList;
   {* ���������� ����� ������� pop:Word:MembersIterator }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopWordMembersIterator
 
 TkwPopWordInnerDictionary = class(TtfwClassLike)
  {* ����� ������� pop:Word:InnerDictionary
*��� ����������:* TtfwDictionary
*������:*
[code]
OBJECT VAR l_TtfwDictionary
 aWord pop:Word:InnerDictionary >>> l_TtfwDictionary
[code]  }
  function InnerDictionary(const aCtx: TtfwContext;
   aWord: TtfwWord): TtfwDictionary;
   {* ���������� ����� ������� pop:Word:InnerDictionary }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopWordInnerDictionary
 
 TkwPopWordCodeIterator = class(TtfwClassLike)
  {* ����� ������� pop:Word:CodeIterator
*��� ����������:* ItfwValueList
*������:*
[code]
ARRAY VAR l_ItfwValueList
 aWord pop:Word:CodeIterator >>> l_ItfwValueList
[code]  }
  function CodeIterator(const aCtx: TtfwContext;
   aWord: TtfwWord): ItfwValueList;
   {* ���������� ����� ������� pop:Word:CodeIterator }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopWordCodeIterator
 
 TkwPopWordSetValuePrim = class(TtfwClassLike)
  {* ����� ������� pop:Word:SetValuePrim
*������:*
[code]
 aValue aWord pop:Word:SetValuePrim
[code]  }
  procedure SetValuePrim(const aCtx: TtfwContext;
   aWord: TtfwWord;
   const aValue: TtfwStackValue);
   {* ���������� ����� ������� pop:Word:SetValuePrim }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopWordSetValuePrim
 
 TkwPopWordKeyWord = class(TtfwClassLike)
  {* ����� ������� pop:Word:KeyWord
*��� ����������:* TtfwKeyWord
*������:*
[code]
OBJECT VAR l_TtfwKeyWord
 aWord pop:Word:KeyWord >>> l_TtfwKeyWord
[code]  }
  function KeyWord(const aCtx: TtfwContext;
   aWord: TtfwWord): TtfwKeyWord;
   {* ���������� ����� ������� pop:Word:KeyWord }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopWordKeyWord
 
 TkwPopWordDirectives = class(TtfwPropertyLike)
  {* ����� ������� pop:Word:Directives
*��� ����������:* Il3CString
*������:*
[code]
STRING VAR l_Il3CString
 aWord pop:Word:Directives >>> l_Il3CString
[code]  }
  function Directives(const aCtx: TtfwContext;
   aWord: TtfwWord): Il3CString;
   {* ���������� ����� ������� pop:Word:Directives }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopWordDirectives
 
 TkwPopWordEndBracket = class(TtfwPropertyLike)
  {* ����� ������� pop:Word:EndBracket
*��� ����������:* String
*������:*
[code]
STRING VAR l_String
 aWord pop:Word:EndBracket >>> l_String
[code]  }
  function EndBracket(const aCtx: TtfwContext;
   aWord: TtfwWord): AnsiString;
   {* ���������� ����� ������� pop:Word:EndBracket }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopWordEndBracket
 
 TkwPopWordLeftWordRefValuesCount = class(TtfwPropertyLike)
  {* ����� ������� pop:Word:LeftWordRefValuesCount
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aWord pop:Word:LeftWordRefValuesCount >>> l_Integer
[code]  }
  function LeftWordRefValuesCount(const aCtx: TtfwContext;
   aWord: TtfwWord): Integer;
   {* ���������� ����� ������� pop:Word:LeftWordRefValuesCount }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopWordLeftWordRefValuesCount
 
 TkwPopWordName = class(TtfwPropertyLike)
  {* ����� ������� pop:Word:Name
*��� ����������:* Il3CString
*������:*
[code]
STRING VAR l_Il3CString
 aWord pop:Word:Name >>> l_Il3CString
[code]  }
  function Name(const aCtx: TtfwContext;
   aWord: TtfwWord): Il3CString;
   {* ���������� ����� ������� pop:Word:Name }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopWordName
 
 TkwPopWordParent = class(TtfwPropertyLike)
  {* ����� ������� pop:Word:Parent
*��� ����������:* TtfwWord
*������:*
[code]
OBJECT VAR l_TtfwWord
 aWord pop:Word:Parent >>> l_TtfwWord
[code]  }
  function Parent(const aCtx: TtfwContext;
   aWord: TtfwWord): TtfwWord;
   {* ���������� ����� ������� pop:Word:Parent }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopWordParent
 
 TkwPopWordProducer = class(TtfwPropertyLike)
  {* ����� ������� pop:Word:Producer
*��� ����������:* TtfwWord
*������:*
[code]
OBJECT VAR l_TtfwWord
 aWord pop:Word:Producer >>> l_TtfwWord
[code]  }
  function Producer(const aCtx: TtfwContext;
   aWord: TtfwWord): TtfwWord;
   {* ���������� ����� ������� pop:Word:Producer }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopWordProducer
 
 TkwPopWordRedefines = class(TtfwPropertyLike)
  {* ����� ������� pop:Word:Redefines
*��� ����������:* TtfwWord
*������:*
[code]
OBJECT VAR l_TtfwWord
 aWord pop:Word:Redefines >>> l_TtfwWord
[code]  }
  function Redefines(const aCtx: TtfwContext;
   aWord: TtfwWord): TtfwWord;
   {* ���������� ����� ������� pop:Word:Redefines }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopWordRedefines
 
end.
