unit WordsRTTIPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\WordsRTTIPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwScriptingInterfaces
 , l3Interfaces
 , tfwDictionary
 , l3CProtoObject
 , tfwAxiomaticsResNameGetter
 , tfwClassLike
 , TypInfo
 , tfwPropertyLike
 , tfwTypeInfo
;

type
 ItfwWordBox = interface
  ['{16F9981D-A4AE-47B8-940F-7ED27AF34B87}']
  function Get_Boxed: TtfwWord;
  property Boxed: TtfwWord
   read Get_Boxed;
 end;//ItfwWordBox

 TtfwWordBox = class(Tl3CProtoObject, ItfwWordBox)
  private
   f_Boxed: TtfwWord;
  protected
   function Get_Boxed: TtfwWord;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(aWord: TtfwWord); reintroduce;
   class function Make(aWord: TtfwWord): ItfwWordBox; reintroduce;
 end;//TtfwWordBox
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
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
 //#UC START# *BD54BA1C4F00ci*
 //#UC END# *BD54BA1C4F00ci*
 //#UC START# *BD54BA1C4F00cit*
 //#UC END# *BD54BA1C4F00cit*
 TWordsRTTIPackResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
  public
   class function ResName: AnsiString; override;
 //#UC START# *BD54BA1C4F00publ*
 //#UC END# *BD54BA1C4F00publ*
 end;//TWordsRTTIPackResNameGetter

 TkwPopWordGetLeftWordRefValue = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Word:GetLeftWordRefValue
*Тип результата:* TtfwWord
*Пример:*
[code]
OBJECT VAR l_TtfwWord
 anIndex aWord pop:Word:GetLeftWordRefValue >>> l_TtfwWord
[code]  }
  private
   function GetLeftWordRefValue(const aCtx: TtfwContext;
    aWord: TtfwWord;
    anIndex: Integer): TtfwWord;
    {* Реализация слова скрипта pop:Word:GetLeftWordRefValue }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordGetLeftWordRefValue

 TkwPopWordGetParam = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Word:GetParam
*Тип результата:* TtfwWord
*Пример:*
[code]
OBJECT VAR l_TtfwWord
 anIndex aWord pop:Word:GetParam >>> l_TtfwWord
[code]  }
  private
   function GetParam(const aCtx: TtfwContext;
    aWord: TtfwWord;
    anIndex: Integer): TtfwWord;
    {* Реализация слова скрипта pop:Word:GetParam }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordGetParam

 TkwPopWordPublicateInMainDictionary = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Word:PublicateInMainDictionary
[panel]Публикует вложенное слово в основном словаре. Если такое слово там уже есть, то создаётся переопределение (Redifinition)[panel]
*Пример:*
[code]
 aWord pop:Word:PublicateInMainDictionary
[code]  }
  private
   procedure PublicateInMainDictionary(const aCtx: TtfwContext;
    aWord: TtfwWord);
    {* Реализация слова скрипта pop:Word:PublicateInMainDictionary }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordPublicateInMainDictionary

 TkwPopWordSetProducer = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Word:SetProducer
*Пример:*
[code]
 aProducer aWord pop:Word:SetProducer
[code]  }
  private
   procedure SetProducer(const aCtx: TtfwContext;
    aWord: TtfwWord;
    aProducer: TtfwWord);
    {* Реализация слова скрипта pop:Word:SetProducer }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordSetProducer

 TkwPopWordFindMember = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Word:FindMember
*Тип результата:* TtfwKeyWord
*Пример:*
[code]
OBJECT VAR l_TtfwKeyWord
 aName aWord pop:Word:FindMember >>> l_TtfwKeyWord
[code]  }
  private
   function FindMember(const aCtx: TtfwContext;
    aWord: TtfwWord;
    const aName: Il3CString): TtfwKeyWord;
    {* Реализация слова скрипта pop:Word:FindMember }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordFindMember

 TkwPopWordGetRef = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Word:GetRef
*Тип результата:* TtfwWord
*Пример:*
[code]
OBJECT VAR l_TtfwWord
 aWord pop:Word:GetRef >>> l_TtfwWord
[code]  }
  private
   function GetRef(const aCtx: TtfwContext;
    aWord: TtfwWord): TtfwWord;
    {* Реализация слова скрипта pop:Word:GetRef }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordGetRef

 TkwPopWordSourcePointString = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Word:SourcePointString
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 aWord pop:Word:SourcePointString >>> l_String
[code]  }
  private
   function SourcePointString(const aCtx: TtfwContext;
    aWord: TtfwWord): AnsiString;
    {* Реализация слова скрипта pop:Word:SourcePointString }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordSourcePointString

 TkwPopWordIsVarLike = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Word:IsVarLike
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aWord pop:Word:IsVarLike >>> l_Boolean
[code]  }
  private
   function IsVarLike(const aCtx: TtfwContext;
    aWord: TtfwWord): Boolean;
    {* Реализация слова скрипта pop:Word:IsVarLike }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordIsVarLike

 TkwPopWordIsInParam = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Word:IsInParam
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aWord pop:Word:IsInParam >>> l_Boolean
[code]  }
  private
   function IsInParam(const aCtx: TtfwContext;
    aWord: TtfwWord): Boolean;
    {* Реализация слова скрипта pop:Word:IsInParam }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordIsInParam

 TkwPopWordSetValue = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Word:SetValue
*Пример:*
[code]
 aValue aWord pop:Word:SetValue
[code]  }
  private
   procedure SetValue(const aCtx: TtfwContext;
    aWord: TtfwWord;
    const aValue: TtfwStackValue);
    {* Реализация слова скрипта pop:Word:SetValue }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordSetValue

 TkwPopWordInfo = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Word:Info
*Тип результата:* TtfwWordInfo
*Пример:*
[code]
OBJECT VAR l_TtfwWordInfo
 aWord pop:Word:Info >>> l_TtfwWordInfo
[code]  }
  private
   function Info(const aCtx: TtfwContext;
    aWord: TtfwWord): TtfwWordInfo;
    {* Реализация слова скрипта pop:Word:Info }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordInfo

 TkwPopWordIsForHelp = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Word:IsForHelp
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aWord pop:Word:IsForHelp >>> l_Boolean
[code]  }
  private
   function IsForHelp(const aCtx: TtfwContext;
    aWord: TtfwWord): Boolean;
    {* Реализация слова скрипта pop:Word:IsForHelp }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordIsForHelp

 TkwPopWordIsImmediate = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Word:IsImmediate
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aWord pop:Word:IsImmediate >>> l_Boolean
[code]  }
  private
   function IsImmediate(const aCtx: TtfwContext;
    aWord: TtfwWord): Boolean;
    {* Реализация слова скрипта pop:Word:IsImmediate }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordIsImmediate

 TkwPopWordIncRef = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Word:IncRef
[panel]Увеличивает счётчик ссылок[panel]
*Пример:*
[code]
 aWord pop:Word:IncRef
[code]  }
  private
   procedure IncRef(const aCtx: TtfwContext;
    aWord: TtfwWord);
    {* Реализация слова скрипта pop:Word:IncRef }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordIncRef

 TkwPopWordDecRef = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Word:DecRef
[panel]Уменьшает счётчик ссылок[panel]
*Пример:*
[code]
 aWord pop:Word:DecRef
[code]  }
  private
   procedure DecRef(const aCtx: TtfwContext;
    aWord: TtfwWord);
    {* Реализация слова скрипта pop:Word:DecRef }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordDecRef

 TkwPopWordMembersIterator = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Word:MembersIterator
*Тип результата:* ItfwValueList
*Пример:*
[code]
ARRAY VAR l_ItfwValueList
 aWord pop:Word:MembersIterator >>> l_ItfwValueList
[code]  }
  private
   function MembersIterator(const aCtx: TtfwContext;
    aWord: TtfwWord): ItfwValueList;
    {* Реализация слова скрипта pop:Word:MembersIterator }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordMembersIterator

 TkwPopWordInnerDictionary = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Word:InnerDictionary
*Тип результата:* TtfwDictionary
*Пример:*
[code]
OBJECT VAR l_TtfwDictionary
 aWord pop:Word:InnerDictionary >>> l_TtfwDictionary
[code]  }
  private
   function InnerDictionary(const aCtx: TtfwContext;
    aWord: TtfwWord): TtfwDictionary;
    {* Реализация слова скрипта pop:Word:InnerDictionary }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordInnerDictionary

 TkwPopWordCodeIterator = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Word:CodeIterator
*Тип результата:* ItfwValueList
*Пример:*
[code]
ARRAY VAR l_ItfwValueList
 aWord pop:Word:CodeIterator >>> l_ItfwValueList
[code]  }
  private
   function CodeIterator(const aCtx: TtfwContext;
    aWord: TtfwWord): ItfwValueList;
    {* Реализация слова скрипта pop:Word:CodeIterator }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordCodeIterator

 TkwPopWordSetValuePrim = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Word:SetValuePrim
*Пример:*
[code]
 aValue aWord pop:Word:SetValuePrim
[code]  }
  private
   procedure SetValuePrim(const aCtx: TtfwContext;
    aWord: TtfwWord;
    const aValue: TtfwStackValue);
    {* Реализация слова скрипта pop:Word:SetValuePrim }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordSetValuePrim

 TkwPopWordKeyWord = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Word:KeyWord
*Тип результата:* TtfwKeyWord
*Пример:*
[code]
OBJECT VAR l_TtfwKeyWord
 aWord pop:Word:KeyWord >>> l_TtfwKeyWord
[code]  }
  private
   function KeyWord(const aCtx: TtfwContext;
    aWord: TtfwWord): TtfwKeyWord;
    {* Реализация слова скрипта pop:Word:KeyWord }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordKeyWord

 TkwPopWordSetParent = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Word:SetParent
*Пример:*
[code]
 aParent aWord pop:Word:SetParent
[code]  }
  private
   procedure SetParent(const aCtx: TtfwContext;
    aWord: TtfwWord;
    aParent: TtfwWord);
    {* Реализация слова скрипта pop:Word:SetParent }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordSetParent

 TkwPopWordSetKey = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Word:SetKey
*Пример:*
[code]
 aKey aWord pop:Word:SetKey
[code]  }
  private
   procedure SetKey(const aCtx: TtfwContext;
    aWord: TtfwWord;
    aKey: TtfwKeyWord);
    {* Реализация слова скрипта pop:Word:SetKey }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordSetKey

 TkwPopWordBox = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Word:Box
*Тип результата:* ItfwWordBox
*Пример:*
[code]
INTERFACE VAR l_ItfwWordBox
 aWord pop:Word:Box >>> l_ItfwWordBox
[code]  }
  private
   function Box(const aCtx: TtfwContext;
    aWord: TtfwWord): ItfwWordBox;
    {* Реализация слова скрипта pop:Word:Box }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordBox

 TkwPopWordDirectives = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Word:Directives
*Тип результата:* Il3CString
*Пример:*
[code]
STRING VAR l_Il3CString
 aWord pop:Word:Directives >>> l_Il3CString
[code]  }
  private
   function Directives(const aCtx: TtfwContext;
    aWord: TtfwWord): Il3CString;
    {* Реализация слова скрипта pop:Word:Directives }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordDirectives

 TkwPopWordEndBracket = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Word:EndBracket
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 aWord pop:Word:EndBracket >>> l_String
[code]  }
  private
   function EndBracket(const aCtx: TtfwContext;
    aWord: TtfwWord): AnsiString;
    {* Реализация слова скрипта pop:Word:EndBracket }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordEndBracket

 TkwPopWordLeftWordRefValuesCount = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Word:LeftWordRefValuesCount
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aWord pop:Word:LeftWordRefValuesCount >>> l_Integer
[code]  }
  private
   function LeftWordRefValuesCount(const aCtx: TtfwContext;
    aWord: TtfwWord): Integer;
    {* Реализация слова скрипта pop:Word:LeftWordRefValuesCount }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordLeftWordRefValuesCount

 TkwPopWordName = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Word:Name
*Тип результата:* Il3CString
*Пример:*
[code]
STRING VAR l_Il3CString
 aWord pop:Word:Name >>> l_Il3CString
[code]  }
  private
   function Name(const aCtx: TtfwContext;
    aWord: TtfwWord): Il3CString;
    {* Реализация слова скрипта pop:Word:Name }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordName

 TkwPopWordParent = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Word:Parent
*Тип результата:* TtfwWord
*Пример:*
[code]
OBJECT VAR l_TtfwWord
 aWord pop:Word:Parent >>> l_TtfwWord
[code]  }
  private
   function Parent(const aCtx: TtfwContext;
    aWord: TtfwWord): TtfwWord;
    {* Реализация слова скрипта pop:Word:Parent }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordParent

 TkwPopWordProducer = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Word:Producer
*Тип результата:* TtfwWord
*Пример:*
[code]
OBJECT VAR l_TtfwWord
 aWord pop:Word:Producer >>> l_TtfwWord
[code]  }
  private
   function Producer(const aCtx: TtfwContext;
    aWord: TtfwWord): TtfwWord;
    {* Реализация слова скрипта pop:Word:Producer }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordProducer

 TkwPopWordRedefines = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Word:Redefines
*Тип результата:* TtfwWord
*Пример:*
[code]
OBJECT VAR l_TtfwWord
 aWord pop:Word:Redefines >>> l_TtfwWord
[code]  }
  private
   function Redefines(const aCtx: TtfwContext;
    aWord: TtfwWord): TtfwWord;
    {* Реализация слова скрипта pop:Word:Redefines }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordRedefines

constructor TtfwWordBox.Create(aWord: TtfwWord);
//#UC START# *567A8DFB0357_567A8DB002B6_var*
//#UC END# *567A8DFB0357_567A8DB002B6_var*
begin
//#UC START# *567A8DFB0357_567A8DB002B6_impl*
 inherited Create;
 aWord.SetrefTo(f_Boxed);
//#UC END# *567A8DFB0357_567A8DB002B6_impl*
end;//TtfwWordBox.Create

class function TtfwWordBox.Make(aWord: TtfwWord): ItfwWordBox;
var
 l_Inst : TtfwWordBox;
begin
 l_Inst := Create(aWord);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TtfwWordBox.Make

function TtfwWordBox.Get_Boxed: TtfwWord;
//#UC START# *567A8D840243_567A8DB002B6get_var*
//#UC END# *567A8D840243_567A8DB002B6get_var*
begin
//#UC START# *567A8D840243_567A8DB002B6get_impl*
 Result := f_Boxed;
//#UC END# *567A8D840243_567A8DB002B6get_impl*
end;//TtfwWordBox.Get_Boxed

procedure TtfwWordBox.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_567A8DB002B6_var*
//#UC END# *479731C50290_567A8DB002B6_var*
begin
//#UC START# *479731C50290_567A8DB002B6_impl*
 FreeAndNil(f_Boxed);
 inherited;
//#UC END# *479731C50290_567A8DB002B6_impl*
end;//TtfwWordBox.Cleanup

class function TWordsRTTIPackResNameGetter.ResName: AnsiString;
begin
  Result := 'WordsRTTIPack';
end;//TWordsRTTIPackResNameGetter.ResName

 {$R WordsRTTIPack.res}

function TkwPopWordGetLeftWordRefValue.GetLeftWordRefValue(const aCtx: TtfwContext;
 aWord: TtfwWord;
 anIndex: Integer): TtfwWord;
 {* Реализация слова скрипта pop:Word:GetLeftWordRefValue }
//#UC START# *77728EE03A69_082046A8DE7B_var*
//#UC END# *77728EE03A69_082046A8DE7B_var*
begin
//#UC START# *77728EE03A69_082046A8DE7B_impl*
 Result := aWord.GetLeftWordRefValue(aCtx, anIndex);
//#UC END# *77728EE03A69_082046A8DE7B_impl*
end;//TkwPopWordGetLeftWordRefValue.GetLeftWordRefValue

procedure TkwPopWordGetLeftWordRefValue.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_082046A8DE7B_var*
//#UC END# *4DAEEDE10285_082046A8DE7B_var*
begin
//#UC START# *4DAEEDE10285_082046A8DE7B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_082046A8DE7B_impl*
end;//TkwPopWordGetLeftWordRefValue.DoDoIt

class function TkwPopWordGetLeftWordRefValue.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Word:GetLeftWordRefValue';
end;//TkwPopWordGetLeftWordRefValue.GetWordNameForRegister

function TkwPopWordGetLeftWordRefValue.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_082046A8DE7B_var*
//#UC END# *551544E2001A_082046A8DE7B_var*
begin
//#UC START# *551544E2001A_082046A8DE7B_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_082046A8DE7B_impl*
end;//TkwPopWordGetLeftWordRefValue.GetResultTypeInfo

function TkwPopWordGetLeftWordRefValue.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_082046A8DE7B_var*
//#UC END# *559687E6025A_082046A8DE7B_var*
begin
//#UC START# *559687E6025A_082046A8DE7B_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_082046A8DE7B_impl*
end;//TkwPopWordGetLeftWordRefValue.GetAllParamsCount

function TkwPopWordGetLeftWordRefValue.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_082046A8DE7B_var*
//#UC END# *5617F4D00243_082046A8DE7B_var*
begin
//#UC START# *5617F4D00243_082046A8DE7B_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_082046A8DE7B_impl*
end;//TkwPopWordGetLeftWordRefValue.ParamsTypes

function TkwPopWordGetParam.GetParam(const aCtx: TtfwContext;
 aWord: TtfwWord;
 anIndex: Integer): TtfwWord;
 {* Реализация слова скрипта pop:Word:GetParam }
//#UC START# *0E50B5B72F85_18E1A6E1AA33_var*
//#UC END# *0E50B5B72F85_18E1A6E1AA33_var*
begin
//#UC START# *0E50B5B72F85_18E1A6E1AA33_impl*
 Result := aWord.GetInParam(aCtx, anIndex);
//#UC END# *0E50B5B72F85_18E1A6E1AA33_impl*
end;//TkwPopWordGetParam.GetParam

procedure TkwPopWordGetParam.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_18E1A6E1AA33_var*
//#UC END# *4DAEEDE10285_18E1A6E1AA33_var*
begin
//#UC START# *4DAEEDE10285_18E1A6E1AA33_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_18E1A6E1AA33_impl*
end;//TkwPopWordGetParam.DoDoIt

class function TkwPopWordGetParam.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Word:GetParam';
end;//TkwPopWordGetParam.GetWordNameForRegister

function TkwPopWordGetParam.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_18E1A6E1AA33_var*
//#UC END# *551544E2001A_18E1A6E1AA33_var*
begin
//#UC START# *551544E2001A_18E1A6E1AA33_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_18E1A6E1AA33_impl*
end;//TkwPopWordGetParam.GetResultTypeInfo

function TkwPopWordGetParam.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_18E1A6E1AA33_var*
//#UC END# *559687E6025A_18E1A6E1AA33_var*
begin
//#UC START# *559687E6025A_18E1A6E1AA33_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_18E1A6E1AA33_impl*
end;//TkwPopWordGetParam.GetAllParamsCount

function TkwPopWordGetParam.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_18E1A6E1AA33_var*
//#UC END# *5617F4D00243_18E1A6E1AA33_var*
begin
//#UC START# *5617F4D00243_18E1A6E1AA33_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_18E1A6E1AA33_impl*
end;//TkwPopWordGetParam.ParamsTypes

procedure TkwPopWordPublicateInMainDictionary.PublicateInMainDictionary(const aCtx: TtfwContext;
 aWord: TtfwWord);
 {* Реализация слова скрипта pop:Word:PublicateInMainDictionary }
//#UC START# *9AE555BD5A21_F598008DBB04_var*
var
 l_KW : TtfwKeyword;
 l_Key : TtfwKeyWord;
 l_PrevWord : TtfwWord;
 l_PrevWordKW : TtfwKeyWord;
//#UC END# *9AE555BD5A21_F598008DBB04_var*
begin
//#UC START# *9AE555BD5A21_F598008DBB04_impl*
 l_Key := TtfwKeyWord(aWord.Key);
 l_KW := aCtx.rEngine.KeywordFinder(aCtx).CheckWord(l_Key.AsCStr);
 Assert(aWord <> l_KW.Word);
 try
  l_PrevWord := l_KW.Word;
  if (l_PrevWord <> nil) then
   l_PrevWordKW := TtfwKeyWord(l_PrevWord.Key)
  else
   l_PrevWordKW := nil;
  aWord.Redefines := l_PrevWord;
  // - говорим, что слово (наверное) имеет переопределение
  l_KW.SetWord(aCtx, aWord);
  // - регистрируем алиас слова в словаре
  if (l_PrevWord <> nil) then
   l_PrevWord.Key := l_PrevWordKW;
 finally
  aWord.Key := l_Key;
  // - восстанавливаем слову предыдущее значение ключа
 end;//try..finally
//#UC END# *9AE555BD5A21_F598008DBB04_impl*
end;//TkwPopWordPublicateInMainDictionary.PublicateInMainDictionary

procedure TkwPopWordPublicateInMainDictionary.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_F598008DBB04_var*
//#UC END# *4DAEEDE10285_F598008DBB04_var*
begin
//#UC START# *4DAEEDE10285_F598008DBB04_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_F598008DBB04_impl*
end;//TkwPopWordPublicateInMainDictionary.DoDoIt

class function TkwPopWordPublicateInMainDictionary.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Word:PublicateInMainDictionary';
end;//TkwPopWordPublicateInMainDictionary.GetWordNameForRegister

function TkwPopWordPublicateInMainDictionary.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_F598008DBB04_var*
//#UC END# *551544E2001A_F598008DBB04_var*
begin
//#UC START# *551544E2001A_F598008DBB04_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_F598008DBB04_impl*
end;//TkwPopWordPublicateInMainDictionary.GetResultTypeInfo

function TkwPopWordPublicateInMainDictionary.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_F598008DBB04_var*
//#UC END# *559687E6025A_F598008DBB04_var*
begin
//#UC START# *559687E6025A_F598008DBB04_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_F598008DBB04_impl*
end;//TkwPopWordPublicateInMainDictionary.GetAllParamsCount

function TkwPopWordPublicateInMainDictionary.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_F598008DBB04_var*
//#UC END# *5617F4D00243_F598008DBB04_var*
begin
//#UC START# *5617F4D00243_F598008DBB04_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_F598008DBB04_impl*
end;//TkwPopWordPublicateInMainDictionary.ParamsTypes

procedure TkwPopWordSetProducer.SetProducer(const aCtx: TtfwContext;
 aWord: TtfwWord;
 aProducer: TtfwWord);
 {* Реализация слова скрипта pop:Word:SetProducer }
//#UC START# *76D0ECD79670_8EA9132CC57C_var*
//#UC END# *76D0ECD79670_8EA9132CC57C_var*
begin
//#UC START# *76D0ECD79670_8EA9132CC57C_impl*
 aWord.WordProducer := aProducer;
//#UC END# *76D0ECD79670_8EA9132CC57C_impl*
end;//TkwPopWordSetProducer.SetProducer

procedure TkwPopWordSetProducer.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_8EA9132CC57C_var*
//#UC END# *4DAEEDE10285_8EA9132CC57C_var*
begin
//#UC START# *4DAEEDE10285_8EA9132CC57C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_8EA9132CC57C_impl*
end;//TkwPopWordSetProducer.DoDoIt

class function TkwPopWordSetProducer.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Word:SetProducer';
end;//TkwPopWordSetProducer.GetWordNameForRegister

function TkwPopWordSetProducer.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_8EA9132CC57C_var*
//#UC END# *551544E2001A_8EA9132CC57C_var*
begin
//#UC START# *551544E2001A_8EA9132CC57C_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_8EA9132CC57C_impl*
end;//TkwPopWordSetProducer.GetResultTypeInfo

function TkwPopWordSetProducer.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_8EA9132CC57C_var*
//#UC END# *559687E6025A_8EA9132CC57C_var*
begin
//#UC START# *559687E6025A_8EA9132CC57C_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_8EA9132CC57C_impl*
end;//TkwPopWordSetProducer.GetAllParamsCount

function TkwPopWordSetProducer.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_8EA9132CC57C_var*
//#UC END# *5617F4D00243_8EA9132CC57C_var*
begin
//#UC START# *5617F4D00243_8EA9132CC57C_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_8EA9132CC57C_impl*
end;//TkwPopWordSetProducer.ParamsTypes

function TkwPopWordFindMember.FindMember(const aCtx: TtfwContext;
 aWord: TtfwWord;
 const aName: Il3CString): TtfwKeyWord;
 {* Реализация слова скрипта pop:Word:FindMember }
//#UC START# *A78847AB9E1F_289A2FC7F4D3_var*
//#UC END# *A78847AB9E1F_289A2FC7F4D3_var*
begin
//#UC START# *A78847AB9E1F_289A2FC7F4D3_impl*
 if (aWord.InnerDictionary <> nil) then
  Result := (aWord.InnerDictionary As TtfwDictionary).DRbyCName[aName]
 else
  Result := nil;
//#UC END# *A78847AB9E1F_289A2FC7F4D3_impl*
end;//TkwPopWordFindMember.FindMember

procedure TkwPopWordFindMember.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_289A2FC7F4D3_var*
//#UC END# *4DAEEDE10285_289A2FC7F4D3_var*
begin
//#UC START# *4DAEEDE10285_289A2FC7F4D3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_289A2FC7F4D3_impl*
end;//TkwPopWordFindMember.DoDoIt

class function TkwPopWordFindMember.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Word:FindMember';
end;//TkwPopWordFindMember.GetWordNameForRegister

function TkwPopWordFindMember.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_289A2FC7F4D3_var*
//#UC END# *551544E2001A_289A2FC7F4D3_var*
begin
//#UC START# *551544E2001A_289A2FC7F4D3_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_289A2FC7F4D3_impl*
end;//TkwPopWordFindMember.GetResultTypeInfo

function TkwPopWordFindMember.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_289A2FC7F4D3_var*
//#UC END# *559687E6025A_289A2FC7F4D3_var*
begin
//#UC START# *559687E6025A_289A2FC7F4D3_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_289A2FC7F4D3_impl*
end;//TkwPopWordFindMember.GetAllParamsCount

function TkwPopWordFindMember.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_289A2FC7F4D3_var*
//#UC END# *5617F4D00243_289A2FC7F4D3_var*
begin
//#UC START# *5617F4D00243_289A2FC7F4D3_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_289A2FC7F4D3_impl*
end;//TkwPopWordFindMember.ParamsTypes

function TkwPopWordGetRef.GetRef(const aCtx: TtfwContext;
 aWord: TtfwWord): TtfwWord;
 {* Реализация слова скрипта pop:Word:GetRef }
//#UC START# *40860C2E9C2E_A74A73E17FB3_var*
//#UC END# *40860C2E9C2E_A74A73E17FB3_var*
begin
//#UC START# *40860C2E9C2E_A74A73E17FB3_impl*
 Result := aWord.GetRef(aCtx);
//#UC END# *40860C2E9C2E_A74A73E17FB3_impl*
end;//TkwPopWordGetRef.GetRef

procedure TkwPopWordGetRef.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_A74A73E17FB3_var*
//#UC END# *4DAEEDE10285_A74A73E17FB3_var*
begin
//#UC START# *4DAEEDE10285_A74A73E17FB3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_A74A73E17FB3_impl*
end;//TkwPopWordGetRef.DoDoIt

class function TkwPopWordGetRef.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Word:GetRef';
end;//TkwPopWordGetRef.GetWordNameForRegister

function TkwPopWordGetRef.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_A74A73E17FB3_var*
//#UC END# *551544E2001A_A74A73E17FB3_var*
begin
//#UC START# *551544E2001A_A74A73E17FB3_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_A74A73E17FB3_impl*
end;//TkwPopWordGetRef.GetResultTypeInfo

function TkwPopWordGetRef.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_A74A73E17FB3_var*
//#UC END# *559687E6025A_A74A73E17FB3_var*
begin
//#UC START# *559687E6025A_A74A73E17FB3_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_A74A73E17FB3_impl*
end;//TkwPopWordGetRef.GetAllParamsCount

function TkwPopWordGetRef.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_A74A73E17FB3_var*
//#UC END# *5617F4D00243_A74A73E17FB3_var*
begin
//#UC START# *5617F4D00243_A74A73E17FB3_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_A74A73E17FB3_impl*
end;//TkwPopWordGetRef.ParamsTypes

function TkwPopWordSourcePointString.SourcePointString(const aCtx: TtfwContext;
 aWord: TtfwWord): AnsiString;
 {* Реализация слова скрипта pop:Word:SourcePointString }
//#UC START# *D90ED7F34B68_023E8C15D57F_var*
//#UC END# *D90ED7F34B68_023E8C15D57F_var*
begin
//#UC START# *D90ED7F34B68_023E8C15D57F_impl*
 Result := aWord.SourcePoint.ToString;
//#UC END# *D90ED7F34B68_023E8C15D57F_impl*
end;//TkwPopWordSourcePointString.SourcePointString

procedure TkwPopWordSourcePointString.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_023E8C15D57F_var*
//#UC END# *4DAEEDE10285_023E8C15D57F_var*
begin
//#UC START# *4DAEEDE10285_023E8C15D57F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_023E8C15D57F_impl*
end;//TkwPopWordSourcePointString.DoDoIt

class function TkwPopWordSourcePointString.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Word:SourcePointString';
end;//TkwPopWordSourcePointString.GetWordNameForRegister

function TkwPopWordSourcePointString.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_023E8C15D57F_var*
//#UC END# *551544E2001A_023E8C15D57F_var*
begin
//#UC START# *551544E2001A_023E8C15D57F_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_023E8C15D57F_impl*
end;//TkwPopWordSourcePointString.GetResultTypeInfo

function TkwPopWordSourcePointString.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_023E8C15D57F_var*
//#UC END# *559687E6025A_023E8C15D57F_var*
begin
//#UC START# *559687E6025A_023E8C15D57F_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_023E8C15D57F_impl*
end;//TkwPopWordSourcePointString.GetAllParamsCount

function TkwPopWordSourcePointString.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_023E8C15D57F_var*
//#UC END# *5617F4D00243_023E8C15D57F_var*
begin
//#UC START# *5617F4D00243_023E8C15D57F_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_023E8C15D57F_impl*
end;//TkwPopWordSourcePointString.ParamsTypes

function TkwPopWordIsVarLike.IsVarLike(const aCtx: TtfwContext;
 aWord: TtfwWord): Boolean;
 {* Реализация слова скрипта pop:Word:IsVarLike }
//#UC START# *2E59A9A784D4_D3A8B5A317FE_var*
//#UC END# *2E59A9A784D4_D3A8B5A317FE_var*
begin
//#UC START# *2E59A9A784D4_D3A8B5A317FE_impl*
 Result := aWord.IsVarLike;
//#UC END# *2E59A9A784D4_D3A8B5A317FE_impl*
end;//TkwPopWordIsVarLike.IsVarLike

procedure TkwPopWordIsVarLike.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_D3A8B5A317FE_var*
//#UC END# *4DAEEDE10285_D3A8B5A317FE_var*
begin
//#UC START# *4DAEEDE10285_D3A8B5A317FE_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_D3A8B5A317FE_impl*
end;//TkwPopWordIsVarLike.DoDoIt

class function TkwPopWordIsVarLike.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Word:IsVarLike';
end;//TkwPopWordIsVarLike.GetWordNameForRegister

function TkwPopWordIsVarLike.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_D3A8B5A317FE_var*
//#UC END# *551544E2001A_D3A8B5A317FE_var*
begin
//#UC START# *551544E2001A_D3A8B5A317FE_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_D3A8B5A317FE_impl*
end;//TkwPopWordIsVarLike.GetResultTypeInfo

function TkwPopWordIsVarLike.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_D3A8B5A317FE_var*
//#UC END# *559687E6025A_D3A8B5A317FE_var*
begin
//#UC START# *559687E6025A_D3A8B5A317FE_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_D3A8B5A317FE_impl*
end;//TkwPopWordIsVarLike.GetAllParamsCount

function TkwPopWordIsVarLike.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_D3A8B5A317FE_var*
//#UC END# *5617F4D00243_D3A8B5A317FE_var*
begin
//#UC START# *5617F4D00243_D3A8B5A317FE_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_D3A8B5A317FE_impl*
end;//TkwPopWordIsVarLike.ParamsTypes

function TkwPopWordIsInParam.IsInParam(const aCtx: TtfwContext;
 aWord: TtfwWord): Boolean;
 {* Реализация слова скрипта pop:Word:IsInParam }
//#UC START# *A3681005727A_252F9E4AEA1C_var*
//#UC END# *A3681005727A_252F9E4AEA1C_var*
begin
//#UC START# *A3681005727A_252F9E4AEA1C_impl*
 Result := aWord.IsInParam;
//#UC END# *A3681005727A_252F9E4AEA1C_impl*
end;//TkwPopWordIsInParam.IsInParam

procedure TkwPopWordIsInParam.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_252F9E4AEA1C_var*
//#UC END# *4DAEEDE10285_252F9E4AEA1C_var*
begin
//#UC START# *4DAEEDE10285_252F9E4AEA1C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_252F9E4AEA1C_impl*
end;//TkwPopWordIsInParam.DoDoIt

class function TkwPopWordIsInParam.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Word:IsInParam';
end;//TkwPopWordIsInParam.GetWordNameForRegister

function TkwPopWordIsInParam.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_252F9E4AEA1C_var*
//#UC END# *551544E2001A_252F9E4AEA1C_var*
begin
//#UC START# *551544E2001A_252F9E4AEA1C_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_252F9E4AEA1C_impl*
end;//TkwPopWordIsInParam.GetResultTypeInfo

function TkwPopWordIsInParam.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_252F9E4AEA1C_var*
//#UC END# *559687E6025A_252F9E4AEA1C_var*
begin
//#UC START# *559687E6025A_252F9E4AEA1C_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_252F9E4AEA1C_impl*
end;//TkwPopWordIsInParam.GetAllParamsCount

function TkwPopWordIsInParam.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_252F9E4AEA1C_var*
//#UC END# *5617F4D00243_252F9E4AEA1C_var*
begin
//#UC START# *5617F4D00243_252F9E4AEA1C_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_252F9E4AEA1C_impl*
end;//TkwPopWordIsInParam.ParamsTypes

procedure TkwPopWordSetValue.SetValue(const aCtx: TtfwContext;
 aWord: TtfwWord;
 const aValue: TtfwStackValue);
 {* Реализация слова скрипта pop:Word:SetValue }
//#UC START# *80E6106682BF_FF9BD5F0BEBA_var*
//#UC END# *80E6106682BF_FF9BD5F0BEBA_var*
begin
//#UC START# *80E6106682BF_FF9BD5F0BEBA_impl*
 aWord.SetValue(aValue, aCtx);
//#UC END# *80E6106682BF_FF9BD5F0BEBA_impl*
end;//TkwPopWordSetValue.SetValue

procedure TkwPopWordSetValue.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_FF9BD5F0BEBA_var*
//#UC END# *4DAEEDE10285_FF9BD5F0BEBA_var*
begin
//#UC START# *4DAEEDE10285_FF9BD5F0BEBA_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_FF9BD5F0BEBA_impl*
end;//TkwPopWordSetValue.DoDoIt

class function TkwPopWordSetValue.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Word:SetValue';
end;//TkwPopWordSetValue.GetWordNameForRegister

function TkwPopWordSetValue.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_FF9BD5F0BEBA_var*
//#UC END# *551544E2001A_FF9BD5F0BEBA_var*
begin
//#UC START# *551544E2001A_FF9BD5F0BEBA_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_FF9BD5F0BEBA_impl*
end;//TkwPopWordSetValue.GetResultTypeInfo

function TkwPopWordSetValue.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_FF9BD5F0BEBA_var*
//#UC END# *559687E6025A_FF9BD5F0BEBA_var*
begin
//#UC START# *559687E6025A_FF9BD5F0BEBA_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_FF9BD5F0BEBA_impl*
end;//TkwPopWordSetValue.GetAllParamsCount

function TkwPopWordSetValue.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_FF9BD5F0BEBA_var*
//#UC END# *5617F4D00243_FF9BD5F0BEBA_var*
begin
//#UC START# *5617F4D00243_FF9BD5F0BEBA_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_FF9BD5F0BEBA_impl*
end;//TkwPopWordSetValue.ParamsTypes

function TkwPopWordInfo.Info(const aCtx: TtfwContext;
 aWord: TtfwWord): TtfwWordInfo;
 {* Реализация слова скрипта pop:Word:Info }
//#UC START# *51983D6F5E34_729F2B05F10B_var*
//#UC END# *51983D6F5E34_729F2B05F10B_var*
begin
//#UC START# *51983D6F5E34_729F2B05F10B_impl*
 Result := aWord.ResultTypeInfo[aCtx];
//#UC END# *51983D6F5E34_729F2B05F10B_impl*
end;//TkwPopWordInfo.Info

procedure TkwPopWordInfo.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_729F2B05F10B_var*
//#UC END# *4DAEEDE10285_729F2B05F10B_var*
begin
//#UC START# *4DAEEDE10285_729F2B05F10B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_729F2B05F10B_impl*
end;//TkwPopWordInfo.DoDoIt

class function TkwPopWordInfo.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Word:Info';
end;//TkwPopWordInfo.GetWordNameForRegister

function TkwPopWordInfo.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_729F2B05F10B_var*
//#UC END# *551544E2001A_729F2B05F10B_var*
begin
//#UC START# *551544E2001A_729F2B05F10B_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_729F2B05F10B_impl*
end;//TkwPopWordInfo.GetResultTypeInfo

function TkwPopWordInfo.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_729F2B05F10B_var*
//#UC END# *559687E6025A_729F2B05F10B_var*
begin
//#UC START# *559687E6025A_729F2B05F10B_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_729F2B05F10B_impl*
end;//TkwPopWordInfo.GetAllParamsCount

function TkwPopWordInfo.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_729F2B05F10B_var*
//#UC END# *5617F4D00243_729F2B05F10B_var*
begin
//#UC START# *5617F4D00243_729F2B05F10B_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_729F2B05F10B_impl*
end;//TkwPopWordInfo.ParamsTypes

function TkwPopWordIsForHelp.IsForHelp(const aCtx: TtfwContext;
 aWord: TtfwWord): Boolean;
 {* Реализация слова скрипта pop:Word:IsForHelp }
//#UC START# *83CFF18DA9B9_BD8751956DAF_var*
//#UC END# *83CFF18DA9B9_BD8751956DAF_var*
begin
//#UC START# *83CFF18DA9B9_BD8751956DAF_impl*
 !!! Needs to be implemented !!!
//#UC END# *83CFF18DA9B9_BD8751956DAF_impl*
end;//TkwPopWordIsForHelp.IsForHelp

procedure TkwPopWordIsForHelp.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_BD8751956DAF_var*
//#UC END# *4DAEEDE10285_BD8751956DAF_var*
begin
//#UC START# *4DAEEDE10285_BD8751956DAF_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_BD8751956DAF_impl*
end;//TkwPopWordIsForHelp.DoDoIt

class function TkwPopWordIsForHelp.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Word:IsForHelp';
end;//TkwPopWordIsForHelp.GetWordNameForRegister

function TkwPopWordIsForHelp.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_BD8751956DAF_var*
//#UC END# *551544E2001A_BD8751956DAF_var*
begin
//#UC START# *551544E2001A_BD8751956DAF_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_BD8751956DAF_impl*
end;//TkwPopWordIsForHelp.GetResultTypeInfo

function TkwPopWordIsForHelp.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_BD8751956DAF_var*
//#UC END# *559687E6025A_BD8751956DAF_var*
begin
//#UC START# *559687E6025A_BD8751956DAF_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_BD8751956DAF_impl*
end;//TkwPopWordIsForHelp.GetAllParamsCount

function TkwPopWordIsForHelp.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_BD8751956DAF_var*
//#UC END# *5617F4D00243_BD8751956DAF_var*
begin
//#UC START# *5617F4D00243_BD8751956DAF_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_BD8751956DAF_impl*
end;//TkwPopWordIsForHelp.ParamsTypes

function TkwPopWordIsImmediate.IsImmediate(const aCtx: TtfwContext;
 aWord: TtfwWord): Boolean;
 {* Реализация слова скрипта pop:Word:IsImmediate }
//#UC START# *2FA551E3AF7E_0D83B83BE222_var*
//#UC END# *2FA551E3AF7E_0D83B83BE222_var*
begin
//#UC START# *2FA551E3AF7E_0D83B83BE222_impl*
 Result := aWord.IsImmediate(aCtx);
//#UC END# *2FA551E3AF7E_0D83B83BE222_impl*
end;//TkwPopWordIsImmediate.IsImmediate

procedure TkwPopWordIsImmediate.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_0D83B83BE222_var*
//#UC END# *4DAEEDE10285_0D83B83BE222_var*
begin
//#UC START# *4DAEEDE10285_0D83B83BE222_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_0D83B83BE222_impl*
end;//TkwPopWordIsImmediate.DoDoIt

class function TkwPopWordIsImmediate.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Word:IsImmediate';
end;//TkwPopWordIsImmediate.GetWordNameForRegister

function TkwPopWordIsImmediate.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_0D83B83BE222_var*
//#UC END# *551544E2001A_0D83B83BE222_var*
begin
//#UC START# *551544E2001A_0D83B83BE222_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_0D83B83BE222_impl*
end;//TkwPopWordIsImmediate.GetResultTypeInfo

function TkwPopWordIsImmediate.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_0D83B83BE222_var*
//#UC END# *559687E6025A_0D83B83BE222_var*
begin
//#UC START# *559687E6025A_0D83B83BE222_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_0D83B83BE222_impl*
end;//TkwPopWordIsImmediate.GetAllParamsCount

function TkwPopWordIsImmediate.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_0D83B83BE222_var*
//#UC END# *5617F4D00243_0D83B83BE222_var*
begin
//#UC START# *5617F4D00243_0D83B83BE222_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_0D83B83BE222_impl*
end;//TkwPopWordIsImmediate.ParamsTypes

procedure TkwPopWordIncRef.IncRef(const aCtx: TtfwContext;
 aWord: TtfwWord);
 {* Реализация слова скрипта pop:Word:IncRef }
//#UC START# *E571552281D4_76CDD4A4EF99_var*
//#UC END# *E571552281D4_76CDD4A4EF99_var*
begin
//#UC START# *E571552281D4_76CDD4A4EF99_impl*
 aWord.Use;
//#UC END# *E571552281D4_76CDD4A4EF99_impl*
end;//TkwPopWordIncRef.IncRef

procedure TkwPopWordIncRef.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_76CDD4A4EF99_var*
//#UC END# *4DAEEDE10285_76CDD4A4EF99_var*
begin
//#UC START# *4DAEEDE10285_76CDD4A4EF99_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_76CDD4A4EF99_impl*
end;//TkwPopWordIncRef.DoDoIt

class function TkwPopWordIncRef.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Word:IncRef';
end;//TkwPopWordIncRef.GetWordNameForRegister

function TkwPopWordIncRef.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_76CDD4A4EF99_var*
//#UC END# *551544E2001A_76CDD4A4EF99_var*
begin
//#UC START# *551544E2001A_76CDD4A4EF99_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_76CDD4A4EF99_impl*
end;//TkwPopWordIncRef.GetResultTypeInfo

function TkwPopWordIncRef.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_76CDD4A4EF99_var*
//#UC END# *559687E6025A_76CDD4A4EF99_var*
begin
//#UC START# *559687E6025A_76CDD4A4EF99_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_76CDD4A4EF99_impl*
end;//TkwPopWordIncRef.GetAllParamsCount

function TkwPopWordIncRef.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_76CDD4A4EF99_var*
//#UC END# *5617F4D00243_76CDD4A4EF99_var*
begin
//#UC START# *5617F4D00243_76CDD4A4EF99_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_76CDD4A4EF99_impl*
end;//TkwPopWordIncRef.ParamsTypes

procedure TkwPopWordDecRef.DecRef(const aCtx: TtfwContext;
 aWord: TtfwWord);
 {* Реализация слова скрипта pop:Word:DecRef }
//#UC START# *0F1AAC70C4E6_E5CE67CA0A33_var*
//#UC END# *0F1AAC70C4E6_E5CE67CA0A33_var*
begin
//#UC START# *0F1AAC70C4E6_E5CE67CA0A33_impl*
 aWord.Free;
//#UC END# *0F1AAC70C4E6_E5CE67CA0A33_impl*
end;//TkwPopWordDecRef.DecRef

procedure TkwPopWordDecRef.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_E5CE67CA0A33_var*
//#UC END# *4DAEEDE10285_E5CE67CA0A33_var*
begin
//#UC START# *4DAEEDE10285_E5CE67CA0A33_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_E5CE67CA0A33_impl*
end;//TkwPopWordDecRef.DoDoIt

class function TkwPopWordDecRef.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Word:DecRef';
end;//TkwPopWordDecRef.GetWordNameForRegister

function TkwPopWordDecRef.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_E5CE67CA0A33_var*
//#UC END# *551544E2001A_E5CE67CA0A33_var*
begin
//#UC START# *551544E2001A_E5CE67CA0A33_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_E5CE67CA0A33_impl*
end;//TkwPopWordDecRef.GetResultTypeInfo

function TkwPopWordDecRef.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_E5CE67CA0A33_var*
//#UC END# *559687E6025A_E5CE67CA0A33_var*
begin
//#UC START# *559687E6025A_E5CE67CA0A33_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_E5CE67CA0A33_impl*
end;//TkwPopWordDecRef.GetAllParamsCount

function TkwPopWordDecRef.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_E5CE67CA0A33_var*
//#UC END# *5617F4D00243_E5CE67CA0A33_var*
begin
//#UC START# *5617F4D00243_E5CE67CA0A33_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_E5CE67CA0A33_impl*
end;//TkwPopWordDecRef.ParamsTypes

function TkwPopWordMembersIterator.MembersIterator(const aCtx: TtfwContext;
 aWord: TtfwWord): ItfwValueList;
 {* Реализация слова скрипта pop:Word:MembersIterator }
//#UC START# *092BBE4CCE0C_44A52B9145D9_var*
//#UC END# *092BBE4CCE0C_44A52B9145D9_var*
begin
//#UC START# *092BBE4CCE0C_44A52B9145D9_impl*
 if (aWord = nil) then
  Result := TtfwMembersIterator.Make(nil)
 else
 if (aWord Is TkwForwardDeclaration) then
  Result := TtfwMembersIterator.Make(TkwForwardDeclaration(aWord).RealWord.InnerDictionary)
 else
  Result := TtfwMembersIterator.Make(aWord.InnerDictionary);
//#UC END# *092BBE4CCE0C_44A52B9145D9_impl*
end;//TkwPopWordMembersIterator.MembersIterator

procedure TkwPopWordMembersIterator.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_44A52B9145D9_var*
//#UC END# *4DAEEDE10285_44A52B9145D9_var*
begin
//#UC START# *4DAEEDE10285_44A52B9145D9_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_44A52B9145D9_impl*
end;//TkwPopWordMembersIterator.DoDoIt

class function TkwPopWordMembersIterator.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Word:MembersIterator';
end;//TkwPopWordMembersIterator.GetWordNameForRegister

function TkwPopWordMembersIterator.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_44A52B9145D9_var*
//#UC END# *551544E2001A_44A52B9145D9_var*
begin
//#UC START# *551544E2001A_44A52B9145D9_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_44A52B9145D9_impl*
end;//TkwPopWordMembersIterator.GetResultTypeInfo

function TkwPopWordMembersIterator.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_44A52B9145D9_var*
//#UC END# *559687E6025A_44A52B9145D9_var*
begin
//#UC START# *559687E6025A_44A52B9145D9_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_44A52B9145D9_impl*
end;//TkwPopWordMembersIterator.GetAllParamsCount

function TkwPopWordMembersIterator.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_44A52B9145D9_var*
//#UC END# *5617F4D00243_44A52B9145D9_var*
begin
//#UC START# *5617F4D00243_44A52B9145D9_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_44A52B9145D9_impl*
end;//TkwPopWordMembersIterator.ParamsTypes

function TkwPopWordInnerDictionary.InnerDictionary(const aCtx: TtfwContext;
 aWord: TtfwWord): TtfwDictionary;
 {* Реализация слова скрипта pop:Word:InnerDictionary }
//#UC START# *5F29394A3B0F_3B0F200560B8_var*
//#UC END# *5F29394A3B0F_3B0F200560B8_var*
begin
//#UC START# *5F29394A3B0F_3B0F200560B8_impl*
 Result := aWord.InnerDictionary As TtfwDictionary;
//#UC END# *5F29394A3B0F_3B0F200560B8_impl*
end;//TkwPopWordInnerDictionary.InnerDictionary

procedure TkwPopWordInnerDictionary.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_3B0F200560B8_var*
//#UC END# *4DAEEDE10285_3B0F200560B8_var*
begin
//#UC START# *4DAEEDE10285_3B0F200560B8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_3B0F200560B8_impl*
end;//TkwPopWordInnerDictionary.DoDoIt

class function TkwPopWordInnerDictionary.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Word:InnerDictionary';
end;//TkwPopWordInnerDictionary.GetWordNameForRegister

function TkwPopWordInnerDictionary.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_3B0F200560B8_var*
//#UC END# *551544E2001A_3B0F200560B8_var*
begin
//#UC START# *551544E2001A_3B0F200560B8_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_3B0F200560B8_impl*
end;//TkwPopWordInnerDictionary.GetResultTypeInfo

function TkwPopWordInnerDictionary.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_3B0F200560B8_var*
//#UC END# *559687E6025A_3B0F200560B8_var*
begin
//#UC START# *559687E6025A_3B0F200560B8_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_3B0F200560B8_impl*
end;//TkwPopWordInnerDictionary.GetAllParamsCount

function TkwPopWordInnerDictionary.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_3B0F200560B8_var*
//#UC END# *5617F4D00243_3B0F200560B8_var*
begin
//#UC START# *5617F4D00243_3B0F200560B8_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_3B0F200560B8_impl*
end;//TkwPopWordInnerDictionary.ParamsTypes

function TkwPopWordCodeIterator.CodeIterator(const aCtx: TtfwContext;
 aWord: TtfwWord): ItfwValueList;
 {* Реализация слова скрипта pop:Word:CodeIterator }
//#UC START# *C4C77155D94B_368F6A08F367_var*

 function DoWord(aWord : TtfwWord) : ItfwValueList;
 var
  l_List : TtfwWordRefList;
  l_RightParamsCount : Integer;
  l_Index : Integer;
 begin//DoWord
  if (aWord Is TkwForwardDeclaration) then
   Result := DoWord(TkwForwardDeclaration(aWord).RealWord)
  else
  if (aWord is TkwCompiledWordWorkerWord) then
   Result := DoWord(TkwCompiledWordWorkerWord(aWord).Compiled)
  else
  if (aWord is TkwForwardDeclarationHolder) then
  begin
   l_List := TtfwWordRefList.Create;
   try
    l_List.Add(TkwForwardDeclarationHolder(aWord).Holded);
    Result := TtfwCodeIterator.Make(l_List);
   finally
    FreeAndNil(l_List);
   end;//try..finally
  end//aWord is TkwForwardDeclarationHolder
  else
  if (aWord is TkwCompiledIfElse) then
  begin
   l_List := TtfwWordRefList.Create;
   try
    l_List.Add(TkwCompiledIfElse(aWord).Condition);
    l_List.Add(TkwCompiledIfElse(aWord).WordToWork);
    if (TkwCompiledIfElse(aWord).ElseBranch <> nil) then
     l_List.Add(TkwCompiledIfElse(aWord).ElseBranch);
    Result := TtfwCodeIterator.Make(l_List);
   finally
    FreeAndNil(l_List);
   end;//try..finally
  end//aWord is TkwCompiledIfElse
  else
  if (aWord is TkwDualCompiledWordContainer) then
  begin
   l_List := TtfwWordRefList.Create;
   try
    l_List.Add(TkwDualCompiledWordContainer(aWord).WordToWork);
    if (TkwDualCompiledWordContainer(aWord).ElseBranch <> nil) then
     l_List.Add(TkwDualCompiledWordContainer(aWord).ElseBranch);
    Result := TtfwCodeIterator.Make(l_List);
   finally
    FreeAndNil(l_List);
   end;//try..finally
  end//aWord is TkwDualCompiledWordContainer
  else
  if (aWord is TkwCompiledWordContainer) then
  begin
   l_List := TtfwWordRefList.Create;
   try
    l_List.Add(TkwCompiledWordContainer(aWord).WordToWork);
    Result := TtfwCodeIterator.Make(l_List);
   finally
    FreeAndNil(l_List);
   end;//try..finally
  end//aWord is TkwCompiledWordContainer
  else
  if (aWord is TkwCompiledWordWorkerWordRunner) then
  begin
   l_List := TtfwWordRefList.Create;
   try
    l_RightParamsCount := TkwCompiledWordWorkerWordRunner(aWord).WordToRun.RightParamsCount(aCtx);
    if (l_RightParamsCount = 1) then
     l_List.Add(TkwCompiledWordWorkerWordRunner(aWord).WordToWork)
    else
    begin
     for l_Index := 0 to Pred(l_RightParamsCount) do
      l_List.Add((TkwCompiledWordWorkerWordRunner(aWord).WordToWork As TkwRuntimeWordWithCode).Code[l_Index]);
    end;//l_RightParamsCount = 1
    Result := TtfwCodeIterator.Make(l_List);
   finally
    FreeAndNil(l_List);
   end;//try..finally
  end//aWord is TkwCompiledWordWorkerWordRunner
  else
  if (aWord is TkwCompiledWordWorker) then
  begin
   l_List := TtfwWordRefList.Create;
   try
    l_List.Add(TkwCompiledWordWorker(aWord).WordToWork);
    Result := TtfwCodeIterator.Make(l_List);
   finally
    FreeAndNil(l_List);
   end;//try..finally
  end//aWord is TkwCompiledWordWorker
  else
  if (aWord = nil) OR not (aWord Is TkwRuntimeWordWithCode) then
   Result := TtfwCodeIterator.Make(nil)
  else
   Result := TtfwCodeIterator.Make(TkwCompiledWordPrim(aWord).GetCode(aCtx));
 end;//DoWord

//#UC END# *C4C77155D94B_368F6A08F367_var*
begin
//#UC START# *C4C77155D94B_368F6A08F367_impl*
 Result := DoWord(aWord);
//#UC END# *C4C77155D94B_368F6A08F367_impl*
end;//TkwPopWordCodeIterator.CodeIterator

procedure TkwPopWordCodeIterator.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_368F6A08F367_var*
//#UC END# *4DAEEDE10285_368F6A08F367_var*
begin
//#UC START# *4DAEEDE10285_368F6A08F367_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_368F6A08F367_impl*
end;//TkwPopWordCodeIterator.DoDoIt

class function TkwPopWordCodeIterator.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Word:CodeIterator';
end;//TkwPopWordCodeIterator.GetWordNameForRegister

function TkwPopWordCodeIterator.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_368F6A08F367_var*
//#UC END# *551544E2001A_368F6A08F367_var*
begin
//#UC START# *551544E2001A_368F6A08F367_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_368F6A08F367_impl*
end;//TkwPopWordCodeIterator.GetResultTypeInfo

function TkwPopWordCodeIterator.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_368F6A08F367_var*
//#UC END# *559687E6025A_368F6A08F367_var*
begin
//#UC START# *559687E6025A_368F6A08F367_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_368F6A08F367_impl*
end;//TkwPopWordCodeIterator.GetAllParamsCount

function TkwPopWordCodeIterator.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_368F6A08F367_var*
//#UC END# *5617F4D00243_368F6A08F367_var*
begin
//#UC START# *5617F4D00243_368F6A08F367_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_368F6A08F367_impl*
end;//TkwPopWordCodeIterator.ParamsTypes

procedure TkwPopWordSetValuePrim.SetValuePrim(const aCtx: TtfwContext;
 aWord: TtfwWord;
 const aValue: TtfwStackValue);
 {* Реализация слова скрипта pop:Word:SetValuePrim }
//#UC START# *81B1B00AB03E_B103AAB7CCE4_var*
//#UC END# *81B1B00AB03E_B103AAB7CCE4_var*
begin
//#UC START# *81B1B00AB03E_B103AAB7CCE4_impl*
 aWord.SetValuePrim(aValue, aCtx);
//#UC END# *81B1B00AB03E_B103AAB7CCE4_impl*
end;//TkwPopWordSetValuePrim.SetValuePrim

procedure TkwPopWordSetValuePrim.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_B103AAB7CCE4_var*
//#UC END# *4DAEEDE10285_B103AAB7CCE4_var*
begin
//#UC START# *4DAEEDE10285_B103AAB7CCE4_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_B103AAB7CCE4_impl*
end;//TkwPopWordSetValuePrim.DoDoIt

class function TkwPopWordSetValuePrim.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Word:SetValuePrim';
end;//TkwPopWordSetValuePrim.GetWordNameForRegister

function TkwPopWordSetValuePrim.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_B103AAB7CCE4_var*
//#UC END# *551544E2001A_B103AAB7CCE4_var*
begin
//#UC START# *551544E2001A_B103AAB7CCE4_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_B103AAB7CCE4_impl*
end;//TkwPopWordSetValuePrim.GetResultTypeInfo

function TkwPopWordSetValuePrim.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_B103AAB7CCE4_var*
//#UC END# *559687E6025A_B103AAB7CCE4_var*
begin
//#UC START# *559687E6025A_B103AAB7CCE4_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_B103AAB7CCE4_impl*
end;//TkwPopWordSetValuePrim.GetAllParamsCount

function TkwPopWordSetValuePrim.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_B103AAB7CCE4_var*
//#UC END# *5617F4D00243_B103AAB7CCE4_var*
begin
//#UC START# *5617F4D00243_B103AAB7CCE4_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_B103AAB7CCE4_impl*
end;//TkwPopWordSetValuePrim.ParamsTypes

function TkwPopWordKeyWord.KeyWord(const aCtx: TtfwContext;
 aWord: TtfwWord): TtfwKeyWord;
 {* Реализация слова скрипта pop:Word:KeyWord }
//#UC START# *34F1730D1DCE_E6AF38361418_var*
//#UC END# *34F1730D1DCE_E6AF38361418_var*
begin
//#UC START# *34F1730D1DCE_E6AF38361418_impl*
 Result := aWord.Key As TtfwKeyWord;
//#UC END# *34F1730D1DCE_E6AF38361418_impl*
end;//TkwPopWordKeyWord.KeyWord

procedure TkwPopWordKeyWord.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_E6AF38361418_var*
//#UC END# *4DAEEDE10285_E6AF38361418_var*
begin
//#UC START# *4DAEEDE10285_E6AF38361418_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_E6AF38361418_impl*
end;//TkwPopWordKeyWord.DoDoIt

class function TkwPopWordKeyWord.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Word:KeyWord';
end;//TkwPopWordKeyWord.GetWordNameForRegister

function TkwPopWordKeyWord.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_E6AF38361418_var*
//#UC END# *551544E2001A_E6AF38361418_var*
begin
//#UC START# *551544E2001A_E6AF38361418_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_E6AF38361418_impl*
end;//TkwPopWordKeyWord.GetResultTypeInfo

function TkwPopWordKeyWord.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_E6AF38361418_var*
//#UC END# *559687E6025A_E6AF38361418_var*
begin
//#UC START# *559687E6025A_E6AF38361418_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_E6AF38361418_impl*
end;//TkwPopWordKeyWord.GetAllParamsCount

function TkwPopWordKeyWord.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_E6AF38361418_var*
//#UC END# *5617F4D00243_E6AF38361418_var*
begin
//#UC START# *5617F4D00243_E6AF38361418_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_E6AF38361418_impl*
end;//TkwPopWordKeyWord.ParamsTypes

procedure TkwPopWordSetParent.SetParent(const aCtx: TtfwContext;
 aWord: TtfwWord;
 aParent: TtfwWord);
 {* Реализация слова скрипта pop:Word:SetParent }
//#UC START# *1E3B0BF5E600_69FD1B01AD85_var*
//#UC END# *1E3B0BF5E600_69FD1B01AD85_var*
begin
//#UC START# *1E3B0BF5E600_69FD1B01AD85_impl*
 aWord.SetParent(aParent);
//#UC END# *1E3B0BF5E600_69FD1B01AD85_impl*
end;//TkwPopWordSetParent.SetParent

procedure TkwPopWordSetParent.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_69FD1B01AD85_var*
//#UC END# *4DAEEDE10285_69FD1B01AD85_var*
begin
//#UC START# *4DAEEDE10285_69FD1B01AD85_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_69FD1B01AD85_impl*
end;//TkwPopWordSetParent.DoDoIt

class function TkwPopWordSetParent.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Word:SetParent';
end;//TkwPopWordSetParent.GetWordNameForRegister

function TkwPopWordSetParent.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_69FD1B01AD85_var*
//#UC END# *551544E2001A_69FD1B01AD85_var*
begin
//#UC START# *551544E2001A_69FD1B01AD85_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_69FD1B01AD85_impl*
end;//TkwPopWordSetParent.GetResultTypeInfo

function TkwPopWordSetParent.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_69FD1B01AD85_var*
//#UC END# *559687E6025A_69FD1B01AD85_var*
begin
//#UC START# *559687E6025A_69FD1B01AD85_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_69FD1B01AD85_impl*
end;//TkwPopWordSetParent.GetAllParamsCount

function TkwPopWordSetParent.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_69FD1B01AD85_var*
//#UC END# *5617F4D00243_69FD1B01AD85_var*
begin
//#UC START# *5617F4D00243_69FD1B01AD85_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_69FD1B01AD85_impl*
end;//TkwPopWordSetParent.ParamsTypes

procedure TkwPopWordSetKey.SetKey(const aCtx: TtfwContext;
 aWord: TtfwWord;
 aKey: TtfwKeyWord);
 {* Реализация слова скрипта pop:Word:SetKey }
//#UC START# *EEC2356F711F_E15AE75A5B92_var*
//#UC END# *EEC2356F711F_E15AE75A5B92_var*
begin
//#UC START# *EEC2356F711F_E15AE75A5B92_impl*
 aWord.Key := aKey;
//#UC END# *EEC2356F711F_E15AE75A5B92_impl*
end;//TkwPopWordSetKey.SetKey

procedure TkwPopWordSetKey.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_E15AE75A5B92_var*
//#UC END# *4DAEEDE10285_E15AE75A5B92_var*
begin
//#UC START# *4DAEEDE10285_E15AE75A5B92_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_E15AE75A5B92_impl*
end;//TkwPopWordSetKey.DoDoIt

class function TkwPopWordSetKey.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Word:SetKey';
end;//TkwPopWordSetKey.GetWordNameForRegister

function TkwPopWordSetKey.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_E15AE75A5B92_var*
//#UC END# *551544E2001A_E15AE75A5B92_var*
begin
//#UC START# *551544E2001A_E15AE75A5B92_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_E15AE75A5B92_impl*
end;//TkwPopWordSetKey.GetResultTypeInfo

function TkwPopWordSetKey.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_E15AE75A5B92_var*
//#UC END# *559687E6025A_E15AE75A5B92_var*
begin
//#UC START# *559687E6025A_E15AE75A5B92_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_E15AE75A5B92_impl*
end;//TkwPopWordSetKey.GetAllParamsCount

function TkwPopWordSetKey.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_E15AE75A5B92_var*
//#UC END# *5617F4D00243_E15AE75A5B92_var*
begin
//#UC START# *5617F4D00243_E15AE75A5B92_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_E15AE75A5B92_impl*
end;//TkwPopWordSetKey.ParamsTypes

function TkwPopWordBox.Box(const aCtx: TtfwContext;
 aWord: TtfwWord): ItfwWordBox;
 {* Реализация слова скрипта pop:Word:Box }
//#UC START# *9C15D843AC16_F1A210163CD1_var*
//#UC END# *9C15D843AC16_F1A210163CD1_var*
begin
//#UC START# *9C15D843AC16_F1A210163CD1_impl*
 Result := TtfwWordBox.Make(aWord);
//#UC END# *9C15D843AC16_F1A210163CD1_impl*
end;//TkwPopWordBox.Box

procedure TkwPopWordBox.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_F1A210163CD1_var*
//#UC END# *4DAEEDE10285_F1A210163CD1_var*
begin
//#UC START# *4DAEEDE10285_F1A210163CD1_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_F1A210163CD1_impl*
end;//TkwPopWordBox.DoDoIt

class function TkwPopWordBox.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Word:Box';
end;//TkwPopWordBox.GetWordNameForRegister

function TkwPopWordBox.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_F1A210163CD1_var*
//#UC END# *551544E2001A_F1A210163CD1_var*
begin
//#UC START# *551544E2001A_F1A210163CD1_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_F1A210163CD1_impl*
end;//TkwPopWordBox.GetResultTypeInfo

function TkwPopWordBox.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_F1A210163CD1_var*
//#UC END# *559687E6025A_F1A210163CD1_var*
begin
//#UC START# *559687E6025A_F1A210163CD1_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_F1A210163CD1_impl*
end;//TkwPopWordBox.GetAllParamsCount

function TkwPopWordBox.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_F1A210163CD1_var*
//#UC END# *5617F4D00243_F1A210163CD1_var*
begin
//#UC START# *5617F4D00243_F1A210163CD1_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_F1A210163CD1_impl*
end;//TkwPopWordBox.ParamsTypes

function TkwPopWordDirectives.Directives(const aCtx: TtfwContext;
 aWord: TtfwWord): Il3CString;
 {* Реализация слова скрипта pop:Word:Directives }
//#UC START# *FB7C52FA2B52_3D48CC7059CD_var*
//#UC END# *FB7C52FA2B52_3D48CC7059CD_var*
begin
//#UC START# *FB7C52FA2B52_3D48CC7059CD_impl*
 Result := GetWordDirectives(aCtx, aWord);
//#UC END# *FB7C52FA2B52_3D48CC7059CD_impl*
end;//TkwPopWordDirectives.Directives

procedure TkwPopWordDirectives.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_3D48CC7059CD_var*
//#UC END# *4DAEEDE10285_3D48CC7059CD_var*
begin
//#UC START# *4DAEEDE10285_3D48CC7059CD_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_3D48CC7059CD_impl*
end;//TkwPopWordDirectives.DoDoIt

class function TkwPopWordDirectives.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Word:Directives';
end;//TkwPopWordDirectives.GetWordNameForRegister

procedure TkwPopWordDirectives.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_3D48CC7059CD_var*
//#UC END# *52D00B00031A_3D48CC7059CD_var*
begin
//#UC START# *52D00B00031A_3D48CC7059CD_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_3D48CC7059CD_impl*
end;//TkwPopWordDirectives.SetValuePrim

function TkwPopWordDirectives.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_3D48CC7059CD_var*
//#UC END# *551544E2001A_3D48CC7059CD_var*
begin
//#UC START# *551544E2001A_3D48CC7059CD_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_3D48CC7059CD_impl*
end;//TkwPopWordDirectives.GetResultTypeInfo

function TkwPopWordDirectives.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_3D48CC7059CD_var*
//#UC END# *559687E6025A_3D48CC7059CD_var*
begin
//#UC START# *559687E6025A_3D48CC7059CD_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_3D48CC7059CD_impl*
end;//TkwPopWordDirectives.GetAllParamsCount

function TkwPopWordDirectives.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_3D48CC7059CD_var*
//#UC END# *5617F4D00243_3D48CC7059CD_var*
begin
//#UC START# *5617F4D00243_3D48CC7059CD_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_3D48CC7059CD_impl*
end;//TkwPopWordDirectives.ParamsTypes

function TkwPopWordEndBracket.EndBracket(const aCtx: TtfwContext;
 aWord: TtfwWord): AnsiString;
 {* Реализация слова скрипта pop:Word:EndBracket }
//#UC START# *A2984E82225C_035A954E5F92_var*
var
 l_B : RtfwWord;
//#UC END# *A2984E82225C_035A954E5F92_var*
begin
//#UC START# *A2984E82225C_035A954E5F92_impl*
 try
  if (aWord = nil) then
   l_B := nil
  else
   l_B := aWord.GetEndBracket(aCtx, true);
 except
  l_B := nil;
 end;//try..except
 if (l_B = nil) then
  Result := ''
 else
  Result := aCtx.rEngine.KeywordByName(TtfwCStringFactory.C(l_B.NameForRegister)).AsString;
//#UC END# *A2984E82225C_035A954E5F92_impl*
end;//TkwPopWordEndBracket.EndBracket

procedure TkwPopWordEndBracket.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_035A954E5F92_var*
//#UC END# *4DAEEDE10285_035A954E5F92_var*
begin
//#UC START# *4DAEEDE10285_035A954E5F92_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_035A954E5F92_impl*
end;//TkwPopWordEndBracket.DoDoIt

class function TkwPopWordEndBracket.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Word:EndBracket';
end;//TkwPopWordEndBracket.GetWordNameForRegister

procedure TkwPopWordEndBracket.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_035A954E5F92_var*
//#UC END# *52D00B00031A_035A954E5F92_var*
begin
//#UC START# *52D00B00031A_035A954E5F92_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_035A954E5F92_impl*
end;//TkwPopWordEndBracket.SetValuePrim

function TkwPopWordEndBracket.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_035A954E5F92_var*
//#UC END# *551544E2001A_035A954E5F92_var*
begin
//#UC START# *551544E2001A_035A954E5F92_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_035A954E5F92_impl*
end;//TkwPopWordEndBracket.GetResultTypeInfo

function TkwPopWordEndBracket.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_035A954E5F92_var*
//#UC END# *559687E6025A_035A954E5F92_var*
begin
//#UC START# *559687E6025A_035A954E5F92_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_035A954E5F92_impl*
end;//TkwPopWordEndBracket.GetAllParamsCount

function TkwPopWordEndBracket.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_035A954E5F92_var*
//#UC END# *5617F4D00243_035A954E5F92_var*
begin
//#UC START# *5617F4D00243_035A954E5F92_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_035A954E5F92_impl*
end;//TkwPopWordEndBracket.ParamsTypes

function TkwPopWordLeftWordRefValuesCount.LeftWordRefValuesCount(const aCtx: TtfwContext;
 aWord: TtfwWord): Integer;
 {* Реализация слова скрипта pop:Word:LeftWordRefValuesCount }
//#UC START# *506A313D6D93_699E423B4C87_var*
//#UC END# *506A313D6D93_699E423B4C87_var*
begin
//#UC START# *506A313D6D93_699E423B4C87_impl*
 Result := aWord.LeftWordRefValuesCount(aCtx);
//#UC END# *506A313D6D93_699E423B4C87_impl*
end;//TkwPopWordLeftWordRefValuesCount.LeftWordRefValuesCount

procedure TkwPopWordLeftWordRefValuesCount.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_699E423B4C87_var*
//#UC END# *4DAEEDE10285_699E423B4C87_var*
begin
//#UC START# *4DAEEDE10285_699E423B4C87_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_699E423B4C87_impl*
end;//TkwPopWordLeftWordRefValuesCount.DoDoIt

class function TkwPopWordLeftWordRefValuesCount.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Word:LeftWordRefValuesCount';
end;//TkwPopWordLeftWordRefValuesCount.GetWordNameForRegister

procedure TkwPopWordLeftWordRefValuesCount.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_699E423B4C87_var*
//#UC END# *52D00B00031A_699E423B4C87_var*
begin
//#UC START# *52D00B00031A_699E423B4C87_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_699E423B4C87_impl*
end;//TkwPopWordLeftWordRefValuesCount.SetValuePrim

function TkwPopWordLeftWordRefValuesCount.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_699E423B4C87_var*
//#UC END# *551544E2001A_699E423B4C87_var*
begin
//#UC START# *551544E2001A_699E423B4C87_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_699E423B4C87_impl*
end;//TkwPopWordLeftWordRefValuesCount.GetResultTypeInfo

function TkwPopWordLeftWordRefValuesCount.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_699E423B4C87_var*
//#UC END# *559687E6025A_699E423B4C87_var*
begin
//#UC START# *559687E6025A_699E423B4C87_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_699E423B4C87_impl*
end;//TkwPopWordLeftWordRefValuesCount.GetAllParamsCount

function TkwPopWordLeftWordRefValuesCount.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_699E423B4C87_var*
//#UC END# *5617F4D00243_699E423B4C87_var*
begin
//#UC START# *5617F4D00243_699E423B4C87_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_699E423B4C87_impl*
end;//TkwPopWordLeftWordRefValuesCount.ParamsTypes

function TkwPopWordName.Name(const aCtx: TtfwContext;
 aWord: TtfwWord): Il3CString;
 {* Реализация слова скрипта pop:Word:Name }
//#UC START# *88F83475097B_F6AEFC7115C2_var*
//#UC END# *88F83475097B_F6AEFC7115C2_var*
begin
//#UC START# *88F83475097B_F6AEFC7115C2_impl*
 if (aWord = nil) then
  Result := TtfwCStringFactory.C('??? Unexisting word ???')
 else
  Result := aWord.WordName;
//#UC END# *88F83475097B_F6AEFC7115C2_impl*
end;//TkwPopWordName.Name

procedure TkwPopWordName.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_F6AEFC7115C2_var*
//#UC END# *4DAEEDE10285_F6AEFC7115C2_var*
begin
//#UC START# *4DAEEDE10285_F6AEFC7115C2_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_F6AEFC7115C2_impl*
end;//TkwPopWordName.DoDoIt

class function TkwPopWordName.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Word:Name';
end;//TkwPopWordName.GetWordNameForRegister

procedure TkwPopWordName.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_F6AEFC7115C2_var*
//#UC END# *52D00B00031A_F6AEFC7115C2_var*
begin
//#UC START# *52D00B00031A_F6AEFC7115C2_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_F6AEFC7115C2_impl*
end;//TkwPopWordName.SetValuePrim

function TkwPopWordName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_F6AEFC7115C2_var*
//#UC END# *551544E2001A_F6AEFC7115C2_var*
begin
//#UC START# *551544E2001A_F6AEFC7115C2_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_F6AEFC7115C2_impl*
end;//TkwPopWordName.GetResultTypeInfo

function TkwPopWordName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_F6AEFC7115C2_var*
//#UC END# *559687E6025A_F6AEFC7115C2_var*
begin
//#UC START# *559687E6025A_F6AEFC7115C2_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_F6AEFC7115C2_impl*
end;//TkwPopWordName.GetAllParamsCount

function TkwPopWordName.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_F6AEFC7115C2_var*
//#UC END# *5617F4D00243_F6AEFC7115C2_var*
begin
//#UC START# *5617F4D00243_F6AEFC7115C2_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_F6AEFC7115C2_impl*
end;//TkwPopWordName.ParamsTypes

function TkwPopWordParent.Parent(const aCtx: TtfwContext;
 aWord: TtfwWord): TtfwWord;
 {* Реализация слова скрипта pop:Word:Parent }
//#UC START# *D6565DAC49E7_5AA39503403C_var*
//#UC END# *D6565DAC49E7_5AA39503403C_var*
begin
//#UC START# *D6565DAC49E7_5AA39503403C_impl*
 Result := aWord.ParentWord;
//#UC END# *D6565DAC49E7_5AA39503403C_impl*
end;//TkwPopWordParent.Parent

procedure TkwPopWordParent.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_5AA39503403C_var*
//#UC END# *4DAEEDE10285_5AA39503403C_var*
begin
//#UC START# *4DAEEDE10285_5AA39503403C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_5AA39503403C_impl*
end;//TkwPopWordParent.DoDoIt

class function TkwPopWordParent.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Word:Parent';
end;//TkwPopWordParent.GetWordNameForRegister

procedure TkwPopWordParent.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_5AA39503403C_var*
//#UC END# *52D00B00031A_5AA39503403C_var*
begin
//#UC START# *52D00B00031A_5AA39503403C_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_5AA39503403C_impl*
end;//TkwPopWordParent.SetValuePrim

function TkwPopWordParent.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_5AA39503403C_var*
//#UC END# *551544E2001A_5AA39503403C_var*
begin
//#UC START# *551544E2001A_5AA39503403C_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_5AA39503403C_impl*
end;//TkwPopWordParent.GetResultTypeInfo

function TkwPopWordParent.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_5AA39503403C_var*
//#UC END# *559687E6025A_5AA39503403C_var*
begin
//#UC START# *559687E6025A_5AA39503403C_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_5AA39503403C_impl*
end;//TkwPopWordParent.GetAllParamsCount

function TkwPopWordParent.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_5AA39503403C_var*
//#UC END# *5617F4D00243_5AA39503403C_var*
begin
//#UC START# *5617F4D00243_5AA39503403C_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_5AA39503403C_impl*
end;//TkwPopWordParent.ParamsTypes

function TkwPopWordProducer.Producer(const aCtx: TtfwContext;
 aWord: TtfwWord): TtfwWord;
 {* Реализация слова скрипта pop:Word:Producer }
//#UC START# *8C360D05017B_2979371FE619_var*
//#UC END# *8C360D05017B_2979371FE619_var*
begin
//#UC START# *8C360D05017B_2979371FE619_impl*
 Result := aWord.WordProducer;
//#UC END# *8C360D05017B_2979371FE619_impl*
end;//TkwPopWordProducer.Producer

procedure TkwPopWordProducer.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_2979371FE619_var*
//#UC END# *4DAEEDE10285_2979371FE619_var*
begin
//#UC START# *4DAEEDE10285_2979371FE619_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_2979371FE619_impl*
end;//TkwPopWordProducer.DoDoIt

class function TkwPopWordProducer.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Word:Producer';
end;//TkwPopWordProducer.GetWordNameForRegister

procedure TkwPopWordProducer.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_2979371FE619_var*
//#UC END# *52D00B00031A_2979371FE619_var*
begin
//#UC START# *52D00B00031A_2979371FE619_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_2979371FE619_impl*
end;//TkwPopWordProducer.SetValuePrim

function TkwPopWordProducer.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_2979371FE619_var*
//#UC END# *551544E2001A_2979371FE619_var*
begin
//#UC START# *551544E2001A_2979371FE619_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_2979371FE619_impl*
end;//TkwPopWordProducer.GetResultTypeInfo

function TkwPopWordProducer.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_2979371FE619_var*
//#UC END# *559687E6025A_2979371FE619_var*
begin
//#UC START# *559687E6025A_2979371FE619_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_2979371FE619_impl*
end;//TkwPopWordProducer.GetAllParamsCount

function TkwPopWordProducer.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_2979371FE619_var*
//#UC END# *5617F4D00243_2979371FE619_var*
begin
//#UC START# *5617F4D00243_2979371FE619_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_2979371FE619_impl*
end;//TkwPopWordProducer.ParamsTypes

function TkwPopWordRedefines.Redefines(const aCtx: TtfwContext;
 aWord: TtfwWord): TtfwWord;
 {* Реализация слова скрипта pop:Word:Redefines }
//#UC START# *FFA0775C9845_90152F7BB588_var*
//#UC END# *FFA0775C9845_90152F7BB588_var*
begin
//#UC START# *FFA0775C9845_90152F7BB588_impl*
 !!! Needs to be implemented !!!
//#UC END# *FFA0775C9845_90152F7BB588_impl*
end;//TkwPopWordRedefines.Redefines

procedure TkwPopWordRedefines.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_90152F7BB588_var*
//#UC END# *4DAEEDE10285_90152F7BB588_var*
begin
//#UC START# *4DAEEDE10285_90152F7BB588_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_90152F7BB588_impl*
end;//TkwPopWordRedefines.DoDoIt

class function TkwPopWordRedefines.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Word:Redefines';
end;//TkwPopWordRedefines.GetWordNameForRegister

procedure TkwPopWordRedefines.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_90152F7BB588_var*
//#UC END# *52D00B00031A_90152F7BB588_var*
begin
//#UC START# *52D00B00031A_90152F7BB588_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_90152F7BB588_impl*
end;//TkwPopWordRedefines.SetValuePrim

function TkwPopWordRedefines.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_90152F7BB588_var*
//#UC END# *551544E2001A_90152F7BB588_var*
begin
//#UC START# *551544E2001A_90152F7BB588_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_90152F7BB588_impl*
end;//TkwPopWordRedefines.GetResultTypeInfo

function TkwPopWordRedefines.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_90152F7BB588_var*
//#UC END# *559687E6025A_90152F7BB588_var*
begin
//#UC START# *559687E6025A_90152F7BB588_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_90152F7BB588_impl*
end;//TkwPopWordRedefines.GetAllParamsCount

function TkwPopWordRedefines.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_90152F7BB588_var*
//#UC END# *5617F4D00243_90152F7BB588_var*
begin
//#UC START# *5617F4D00243_90152F7BB588_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_90152F7BB588_impl*
end;//TkwPopWordRedefines.ParamsTypes

initialization
 TWordsRTTIPackResNameGetter.Register;
 {* Регистрация скриптованой аксиоматики }
 TkwPopWordGetLeftWordRefValue.RegisterInEngine;
 {* Регистрация pop_Word_GetLeftWordRefValue }
 TkwPopWordGetParam.RegisterInEngine;
 {* Регистрация pop_Word_GetParam }
 TkwPopWordPublicateInMainDictionary.RegisterInEngine;
 {* Регистрация pop_Word_PublicateInMainDictionary }
 TkwPopWordSetProducer.RegisterInEngine;
 {* Регистрация pop_Word_SetProducer }
 TkwPopWordFindMember.RegisterInEngine;
 {* Регистрация pop_Word_FindMember }
 TkwPopWordGetRef.RegisterInEngine;
 {* Регистрация pop_Word_GetRef }
 TkwPopWordSourcePointString.RegisterInEngine;
 {* Регистрация pop_Word_SourcePointString }
 TkwPopWordIsVarLike.RegisterInEngine;
 {* Регистрация pop_Word_IsVarLike }
 TkwPopWordIsInParam.RegisterInEngine;
 {* Регистрация pop_Word_IsInParam }
 TkwPopWordSetValue.RegisterInEngine;
 {* Регистрация pop_Word_SetValue }
 TkwPopWordInfo.RegisterInEngine;
 {* Регистрация pop_Word_Info }
 TkwPopWordIsForHelp.RegisterInEngine;
 {* Регистрация pop_Word_IsForHelp }
 TkwPopWordIsImmediate.RegisterInEngine;
 {* Регистрация pop_Word_IsImmediate }
 TkwPopWordIncRef.RegisterInEngine;
 {* Регистрация pop_Word_IncRef }
 TkwPopWordDecRef.RegisterInEngine;
 {* Регистрация pop_Word_DecRef }
 TkwPopWordMembersIterator.RegisterInEngine;
 {* Регистрация pop_Word_MembersIterator }
 TkwPopWordInnerDictionary.RegisterInEngine;
 {* Регистрация pop_Word_InnerDictionary }
 TkwPopWordCodeIterator.RegisterInEngine;
 {* Регистрация pop_Word_CodeIterator }
 TkwPopWordSetValuePrim.RegisterInEngine;
 {* Регистрация pop_Word_SetValuePrim }
 TkwPopWordKeyWord.RegisterInEngine;
 {* Регистрация pop_Word_KeyWord }
 TkwPopWordSetParent.RegisterInEngine;
 {* Регистрация pop_Word_SetParent }
 TkwPopWordSetKey.RegisterInEngine;
 {* Регистрация pop_Word_SetKey }
 TkwPopWordBox.RegisterInEngine;
 {* Регистрация pop_Word_Box }
 TkwPopWordDirectives.RegisterInEngine;
 {* Регистрация pop_Word_Directives }
 TkwPopWordEndBracket.RegisterInEngine;
 {* Регистрация pop_Word_EndBracket }
 TkwPopWordLeftWordRefValuesCount.RegisterInEngine;
 {* Регистрация pop_Word_LeftWordRefValuesCount }
 TkwPopWordName.RegisterInEngine;
 {* Регистрация pop_Word_Name }
 TkwPopWordParent.RegisterInEngine;
 {* Регистрация pop_Word_Parent }
 TkwPopWordProducer.RegisterInEngine;
 {* Регистрация pop_Word_Producer }
 TkwPopWordRedefines.RegisterInEngine;
 {* Регистрация pop_Word_Redefines }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwWord));
 {* Регистрация типа TtfwWord }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
 {* Регистрация типа Integer }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа Il3CString }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwKeyWord));
 {* Регистрация типа TtfwKeyWord }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа String }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* Регистрация типа Boolean }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwStackValue }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwWordInfo));
 {* Регистрация типа TtfwWordInfo }
 TtfwTypeRegistrator.RegisterType(TypeInfo(ItfwValueList));
 {* Регистрация типа ItfwValueList }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwDictionary));
 {* Регистрация типа TtfwDictionary }
 TtfwTypeRegistrator.RegisterType(TypeInfo(ItfwWordBox));
 {* Регистрация типа ItfwWordBox }
{$IfEnd} // NOT Defined(NoScripts)

end.
