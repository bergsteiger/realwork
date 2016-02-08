unit tfwScriptingInterfaces;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwScriptingInterfaces.pas"
// Стереотип: "InternalInterfaces"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwTypeInfo
 , tfwScriptingTypes
 , l3Interfaces
 , l3EtalonsWorking
 , tfwScriptingExceptions
 , l3ProtoObject
 , TypInfo
 , tfwValueTypes
 , tfwCStringFactory
 , tfwParserInterfaces
 , SysUtils
 , tfwStreamFactory
 , l3Variant
 , tfwKeyWordPrim
 , tfwDictionaryPrim
 , l3Types
 , Types
 , l3PureMixIns
;

const
 TtfwStackValue_E: TtfwStackValue = (rType : tfw_vtVoid);
 TtfwStackValue_NULL: TtfwStackValue = (rType : tfw_vtNil);
 {* Алиасы для значений tfwTypeInfo.TtfwValueType }
 tfw_vtVoid = tfwTypeInfo.tfw_vtVoid;
 tfw_vtInt = tfwTypeInfo.tfw_vtInt;
 tfw_vtBool = tfwTypeInfo.tfw_vtBool;
 tfw_vtStr = tfwTypeInfo.tfw_vtStr;
 tfw_vtObj = tfwTypeInfo.tfw_vtObj;
 tfw_vtList = tfwTypeInfo.tfw_vtList;
 tfw_vtIntf = tfwTypeInfo.tfw_vtIntf;
  {* Интерфейс }
 tfw_vtNil = tfwTypeInfo.tfw_vtNil;
 tfw_vtFile = tfwTypeInfo.tfw_vtFile;
 tfw_vtChar = tfwTypeInfo.tfw_vtChar;
 tfw_vtClass = tfwTypeInfo.tfw_vtClass;
  {* Ссылка на класс }
 {* Алиасы для значений tfwScriptingTypes.TtfwWordModifier }
 tfw_wmVirtual = tfwScriptingTypes.tfw_wmVirtual;
 tfw_wmAbstract = tfwScriptingTypes.tfw_wmAbstract;
 tfw_wmFinal = tfwScriptingTypes.tfw_wmFinal;
 tfw_wmSummoned = tfwScriptingTypes.tfw_wmSummoned;
 tfw_wmOverride = tfwScriptingTypes.tfw_wmOverride;
 tfw_wmRealize = tfwScriptingTypes.tfw_wmRealize;
 tfw_wmRedefinition = tfwScriptingTypes.tfw_wmRedefinition;
 tfw_wmRedefineable = tfwScriptingTypes.tfw_wmRedefineable;
 tfw_wmSealed = tfwScriptingTypes.tfw_wmSealed;
 tfw_wmRightWordRef = tfwScriptingTypes.tfw_wmRightWordRef;
 tfw_wmLeftWordRef = tfwScriptingTypes.tfw_wmLeftWordRef;
 tfw_wmImmediate = tfwScriptingTypes.tfw_wmImmediate;
 tfw_wmInline = tfwScriptingTypes.tfw_wmInline;
 tfw_wmTreatUnknownAsString = tfwScriptingTypes.tfw_wmTreatUnknownAsString;
 tfw_wmCaller = tfwScriptingTypes.tfw_wmCaller;
 {* Алиасы для значений tfwScriptingTypes.TtfwAccessType }
 tfw_atNone = tfwScriptingTypes.tfw_atNone;
 tfw_atPrivate = tfwScriptingTypes.tfw_atPrivate;
 tfw_atProtected = tfwScriptingTypes.tfw_atProtected;
 tfw_atPublic = tfwScriptingTypes.tfw_atPublic;
 {* Алиасы для значений tfwScriptingTypes.TtfwLinkType }
 tfw_ltNone = tfwScriptingTypes.tfw_ltNone;
 tfw_ltAggregation = tfwScriptingTypes.tfw_ltAggregation;
 tfw_ltLink = tfwScriptingTypes.tfw_ltLink;
 tfw_ltReference = tfwScriptingTypes.tfw_ltReference;

type
 PtfwContext = ^TtfwContext;

 PtfwStoredValue = ^TtfwStoredValue;

 PtfwWordCallContext = ^TtfwWordCallContext;

 (*
 ScriptCaller = interface
  procedure Check(aCondition: Boolean;
   const aMessage: AnsiString = '');
   {* Проверяет инвариант }
  procedure Print(const aStr: Tl3WString); overload;
  procedure Print(const aStr: Il3CString); overload;
 end;//ScriptCaller
 *)

 (*
 PrintingCaller = interface
  function GetIsWritingToK: Boolean;
  function GetIsFakeCVS: Boolean;
  function GetCVSPath: AnsiString;
  procedure DontRaiseIfEtalonCreated;
  procedure TimeToLog(aTime: Cardinal;
   const aSt: AnsiString;
   const aSubName: AnsiString);
  function GetTestSetFolderName: AnsiString;
  function GetEtalonSuffix: AnsiString;
  procedure CheckPrintEtalon(const aLogName: AnsiString;
   const aOutputName: AnsiString);
  function ShouldStop: Boolean;
  procedure CheckTimeout(aNow: Cardinal;
   aTimeout: Cardinal);
  function StartTimer: Longword;
  function StopTimer(const aSt: AnsiString = '';
   const aSubName: AnsiString = '';
   aNeedTimeToLog: Boolean = True): Longword;
 end;//PrintingCaller
 *)

 ItfwScriptCaller = interface
  ['{9A3B1A85-FE74-4761-9100-0FC6F4EE0BD3}']
  function CompileOnly: Boolean;
  function ResolveIncludedFilePath(const aFile: AnsiString): AnsiString;
  function ResolveOutputFilePath(const aFile: AnsiString): AnsiString;
  function ResolveInputFilePath(const aFile: AnsiString): AnsiString;
  function KPage: AnsiString;
  procedure ToLog(const aSt: AnsiString);
  procedure Check(aCondition: Boolean;
   const aMessage: AnsiString = '');
   {* Проверяет инвариант }
  procedure Print(const aStr: Tl3WString); overload;
  procedure Print(const aStr: Il3CString); overload;
  function GetIsWritingToK: Boolean;
  function GetIsFakeCVS: Boolean;
  function GetCVSPath: AnsiString;
  procedure DontRaiseIfEtalonCreated;
  procedure TimeToLog(aTime: Cardinal;
   const aSt: AnsiString;
   const aSubName: AnsiString);
  function GetTestSetFolderName: AnsiString;
  function GetEtalonSuffix: AnsiString;
  procedure CheckPrintEtalon(const aLogName: AnsiString;
   const aOutputName: AnsiString);
  function ShouldStop: Boolean;
  procedure CheckTimeout(aNow: Cardinal;
   aTimeout: Cardinal);
  function StartTimer: Longword;
  function StopTimer(const aSt: AnsiString = '';
   const aSubName: AnsiString = '';
   aNeedTimeToLog: Boolean = True): Longword;
  procedure CheckOutputWithInput(const aIn: AnsiString;
   const aOut: AnsiString;
   aHeaderBegin: AnsiChar;
   aEtalonNeedsComputerName: Boolean;
   aEtalonCanHaveDiff: Boolean;
   const anExtraFileName: AnsiString;
   aNeedsCheck: Boolean); overload;
  procedure CheckOutputWithInput(const aSt: AnsiString;
   aHeaderBegin: AnsiChar = #0;
   const anExtraFileName: AnsiString = '';
   aNeedsCheck: Boolean = True); overload;
  procedure CheckPictureOnly;
  procedure CheckWithEtalon(const aFileName: AnsiString;
   aHeaderBegin: AnsiChar);
 end;//ItfwScriptCaller

 EtfwCodeFlowException = {abstract} class(EtfwException)
 end;//EtfwCodeFlowException

 EtfwCodeFlowError = class(EtfwCodeFlowException)
 end;//EtfwCodeFlowError

 TtfwSuppressNextImmediate = (
  tfw_sniNo
  , tfw_sniYes
  , tfw_sniForce
 );//TtfwSuppressNextImmediate

 (*
 MtfwValueList = interface
  procedure Clear;
 end;//MtfwValueList
 *)

 TtfwSourcePoint = object
  {* Место в исходниках }
  public
   rFileName: Il3CString;
   rLine: Integer;
   rName: Il3CString;
   rProducerName: Il3CString;
  public
   function Empty: Boolean;
   function ToString: AnsiString;
 end;//TtfwSourcePoint

 TtfwAccessType = tfwScriptingTypes.TtfwAccessType;

 EtfwScriptException = class(EtfwException)
  {* Исключение кидаемое скриптом }
 end;//EtfwScriptException

 TtfwLinkType = tfwScriptingTypes.TtfwLinkType;

 TtfwWordInfo = {abstract} class(Tl3ProtoObject)
  {* Информация о типе }
  public
   function IncludeModifier(aModifier: TtfwWordModifier): TtfwWordInfo; virtual; abstract;
   function Empty: Boolean; virtual; abstract;
   function Has(aModifier: TtfwWordModifier): Boolean; overload; virtual; abstract;
   function Clone: TtfwWordInfo; virtual; abstract;
   function pRec: PtfwWordInfoRec; virtual; abstract;
   function IncludeTypeModifier(aType: TtfwValueType): TtfwWordInfo; virtual; abstract;
   function Has(aType: TtfwValueType): Boolean; overload; virtual; abstract;
   function AcceptsValue(const aValue: TtfwStackValue): Boolean; virtual; abstract;
   class function Make(const aTypeInfoRec: TtfwWordInfoRec): TtfwWordInfo; overload;
   class function Make(aTypeInfo: PTypeInfo): TtfwWordInfo; overload;
   function Has(anAccess: TtfwAccessType): Boolean; overload; virtual; abstract;
   function IncludeAccesType(anAccess: TtfwAccessType): TtfwWordInfo; virtual; abstract;
   class function Make(aTypes: TtfwValueTypes;
    aModifiers: TtfwWordModifiers;
    anAccess: TtfwAccessType;
    aLinkType: TtfwLinkType): TtfwWordInfo; overload;
   function EQwm(aValue: TtfwWordModifiers): Boolean; virtual; abstract;
   function IncludeType(const aType: TtfwTypeInfo): TtfwWordInfo; virtual; abstract;
   function TypeName: Il3CString; virtual; abstract;
   class function Make(const aType: TtfwTypeInfo): TtfwWordInfo; overload;
   function ValueTypes: TtfwValueTypes; virtual; abstract;
   function IncludeLinkType(aLinkType: TtfwLinkType): TtfwWordInfo; virtual; abstract;
   function Has(aLinkType: TtfwLinkType): Boolean; overload; virtual; abstract;
   function LinkType: TtfwLinkType; virtual; abstract;
   function AccessType: TtfwAccessType; virtual; abstract;
   function Compare(anOther: TtfwWordInfo): Integer; virtual; abstract;
   function Modifiers: TtfwWordModifiers; virtual; abstract;
   function ToString: Il3CString; virtual; abstract;
 end;//TtfwWordInfo

 EtfwExitOrBreak = {abstract} class(EtfwCodeFlowException)
  public
   AllowFree: Boolean;
  protected
   procedure FreeInstance; override;
  public
   constructor Create(const aMessage: AnsiString); reintroduce; overload;
   constructor Create; reintroduce; overload;
 end;//EtfwExitOrBreak

 EtfwContinue = class(EtfwExitOrBreak)
  public
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   class function Instance: EtfwContinue;
    {* Метод получения экземпляра синглетона EtfwContinue }
 end;//EtfwContinue

 EtfwExit = class(EtfwExitOrBreak)
  public
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   class function Instance: EtfwExit;
    {* Метод получения экземпляра синглетона EtfwExit }
 end;//EtfwExit

 EtfwHalt = class(EtfwExitOrBreak)
  public
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   class function Instance: EtfwHalt;
    {* Метод получения экземпляра синглетона EtfwHalt }
 end;//EtfwHalt

 TtfwStackValue = tfwTypeInfo.TtfwStackValue;

 TtfwCStringFactory = tfwCStringFactory.TtfwCStringFactory;

 TtfwWordInfoArray = array of TtfwWordInfo;

 TtfwWord = class;

 TtfwKeyWord = class;

 ItfwScriptEngine = interface;

 ItfwStoredValuesStack = interface;

 TtfwContext = object
  public
   rCaller: ItfwScriptCaller;
   rEngine: ItfwScriptEngine;
   rParser: ItfwParserEx;
   rException: Exception;
   rTypeInfo: TtfwWordInfo;
    {* Информация о типе слова }
   rStreamFactory: TtfwStreamFactory;
   rKeyWordCompilingNow: TtfwKeyWord;
   rFirstHalfOfDualWord: TtfwWord;
    {* Первая половина двойного слова }
   rStoredValuesStack: ItfwStoredValuesStack;
    {* Стек для сохранения состояния слов при обработке рекурсивных вызовов }
   rWordCompilingNow: TtfwWord;
    {* Текущее компилируемое слово }
   rWordDefiningNow: TtfwWord;
    {* Текущее определяемое ИМЕНОВАННОЕ слово }
   rKeyWordDefiningNow: TtfwKeyWord;
    {* Текущее определяемое ИМЕНОВАННОЕ слово }
   rWasCloseBracket: Boolean;
   rPrev: PtfwContext;
   rWordProducerForCompiledClass: TtfwWord;
   rNewWordName: Il3CString;
   rCompiler: TtfwWord;
   rPrevFinder: TtfwWord;
   rKeyWords: TtfwWord;
  public
   procedure SetWordInfo(aValue: TtfwWordInfo);
   function ResolveIncludedFilePath(const aFile: AnsiString): AnsiString;
 end;//TtfwContext

 TtfwWordPrim = {abstract} class(Tl3ProtoObject)
  private
   f_NestedCallsCount: Integer;
  protected
   procedure StoreState(const aCtx: TtfwContext); virtual;
   procedure RestoreState(const aCtx: TtfwContext); virtual;
   procedure DoDoIt(const aCtx: TtfwContext); virtual; abstract;
   procedure ClearState(const aCtx: TtfwContext); virtual;
   procedure PushAdditionalParams(const aCtx: TtfwContext); virtual;
  public
   function IsCompiled: Boolean; virtual;
   procedure DoIt(const aCtx: TtfwContext);
   function SourcePoint: TtfwSourcePoint; virtual;
 end;//TtfwWordPrim

 (*
 MtfwKeywordFinderSource = interface
  function KeywordFinder(const aCtx: TtfwContext): TtfwWord;
 end;//MtfwKeywordFinderSource
 *)

 (*
 MtfwInParameterDefinitor = interface
  function DefineInParameter(const aCtx: TtfwContext;
   const aParamName: Il3CString;
   aStereo: TtfwWord;
   aTypeInfo: TtfwWordInfo): TtfwWord;
 end;//MtfwInParameterDefinitor
 *)

 (*
 MtfwWordChecker = interface
  function CheckWord(const aName: Il3CString): TtfwKeyWord;
 end;//MtfwWordChecker
 *)

 EtfwBreakIterator = class(EtfwExitOrBreak)
  public
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   class function Instance: EtfwBreakIterator;
    {* Метод получения экземпляра синглетона EtfwBreakIterator }
 end;//EtfwBreakIterator

 (*
 MtfwNewWordDefinitor = interface(MtfwKeywordFinderSource)
 end;//MtfwNewWordDefinitor
 *)

 (*
 MtfwCodeCompiler = interface
  procedure AddCodePart(aWord: TtfwWord;
   const aCtx: TtfwContext;
   aSNI: TtfwSuppressNextImmediate);
   {* Добавляет скомпилированный код к текущему компилируемуму слову }
 end;//MtfwCodeCompiler
 *)

 (*
 MtfwNewWordDefinitorSource = interface
  function NewWordDefinitor: TtfwWord;
 end;//MtfwNewWordDefinitorSource
 *)

 (*
 MtfwCompiler = interface(MtfwKeywordFinderSource)
  procedure CompileInParameterPopCode(const aContext: TtfwContext;
   aParameterToPop: TtfwWord);
   {* Компилирует код извлечения входного параметра в код компилируемого слова }
 end;//MtfwCompiler
 *)

 (*
 MtfwKeywordFinder = interface
  function KeywordByName(const aName: Il3CString): Tl3PrimString;
  function ParentFinder: TtfwWord;
 end;//MtfwKeywordFinder
 *)

 EtfwCompiler = class(EtfwCheck)
 end;//EtfwCompiler

 EtfwRunner = class(EtfwCheck)
 end;//EtfwRunner

 PTypeInfoArray = array of PTypeInfo;

 RtfwWord = class of TtfwWord;

 TtfwWord = {abstract} class(TtfwWordPrim)
  {* Элемент словаря }
  private
   f_Redefines: TtfwWord;
    {* Поле для свойства Redefines }
   f_Key: TtfwKeyWordPrim;
    {* Поле для свойства Key }
  protected
   procedure pm_SetRedefines(aValue: TtfwWord);
   function pm_GetWordProducer: TtfwWord; virtual;
   procedure pm_SetWordProducer(aValue: TtfwWord); virtual;
   function pm_GetInnerDictionary: TtfwDictionaryPrim; virtual;
   function pm_GetResultTypeInfo(const aCtx: TtfwContext): TtfwWordInfo; virtual;
   function pm_GetParentWord: TtfwWord; virtual;
   procedure CompilerAssertFmt(aCondition: Boolean;
    const aMessage: AnsiString;
    const aParams: array of const;
    const aContext: TtfwContext);
   procedure RunnerAssertFmt(aCondition: Boolean;
    const aMessage: AnsiString;
    const aParams: array of const;
    const aContext: TtfwContext);
   procedure DoAddCodePart(aWord: TtfwWord;
    const aCtx: TtfwContext;
    aSNI: TtfwSuppressNextImmediate); virtual;
   procedure BadValueType(aType: TtfwValueType;
    const aCtx: TtfwContext);
   function GetNewWordDefinitor: TtfwWord; virtual;
   procedure DoCompileInParameterPopCode(const aContext: TtfwContext;
    aParameterToPop: TtfwWord;
    aCheckCode: Boolean); virtual;
   procedure CompilerAssert(aCondition: Boolean;
    const aMessage: AnsiString;
    const aContext: TtfwContext);
   class function OpenTypesToTypes(const aTypes: array of PTypeInfo): PTypeInfoArray;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   {$If NOT Defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
    {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
  public
   function IsDefaultBranch: Boolean; virtual;
   procedure RunnerAssert(aCondition: Boolean;
    const aMessage: AnsiString;
    const aContext: TtfwContext);
   function IsAnonimous(const aCtx: TtfwContext): Boolean; virtual;
   function CompiledWordClassPrim(const aCtx: TtfwContext): RtfwWord; virtual;
   function IsForwardDeclaration: Boolean; virtual;
   function GetValue(const aCtx: TtfwContext): PtfwStackValue; virtual;
   function IsVarLike: Boolean; virtual;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); virtual;
   function HasCode: Boolean; virtual;
    {* Есть ли у слова компилированный код }
   function HasLocalDictionary: Boolean; virtual;
    {* Есть ли у слова локальный словарь }
   function CodeCount: Integer; virtual;
    {* Число элементов скомпилированного кода }
   function GetCompiler(const aCtx: TtfwContext): TtfwWord; virtual;
   function DoDefineInParameter(const aCtx: TtfwContext;
    const aParamName: Il3CString;
    aStereo: TtfwWord;
    aTypeInfo: TtfwWordInfo): TtfwWord; virtual;
    {* Определяет слову входной параметр }
   procedure CompileInParameterPopCodeFromString(const aContext: TtfwContext;
    const aParameterToPop: Il3CString); virtual;
   function IsCloseBracket: Boolean; virtual;
   function GetEndBracket(const aContext: TtfwContext;
    aSilent: Boolean): RtfwWord; virtual;
   class function NameForRegister: AnsiString; virtual;
   function AcceptMedianBracket(aBracket: TtfwWord;
    var aCtx: TtfwContext): Boolean; virtual;
   function GetAsCaller(const aCtx: TtfwContext): TtfwWord; virtual;
   function IsRightParam(const aCtx: TtfwContext): Boolean; virtual;
   function RightParamsCount(const aCtx: TtfwContext): Integer; virtual;
   function GetInParam(const aCtx: TtfwContext;
    anIndex: Integer): TtfwWord; virtual;
   procedure SetResultTypeInfo(aValue: TtfwWordInfo;
    const aCtx: TtfwContext); virtual;
   function IsLeftWordRefParam(const aCtx: TtfwContext): Boolean; virtual;
   class procedure RegisterClass;
   function LeftWordRefParamsCount(const aCtx: TtfwContext): Integer; virtual;
   procedure AddLeftWordRefValue(const aCtx: TtfwContext;
    aValue: TtfwWord); virtual;
   function GetLeftWordRefValue(const aCtx: TtfwContext;
    anIndex: Integer): TtfwWord; virtual;
   function LeftWordRefValuesCount(const aCtx: TtfwContext): Integer; virtual;
   procedure RunnerError(const aMessage: AnsiString;
    const aContext: TtfwContext); virtual;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; virtual;
   function GetRightParam(const aCtx: TtfwContext;
    anIndex: Integer): TtfwWord; virtual;
   function GetResultVar(const aCtx: TtfwContext): TtfwWord; virtual;
   constructor Create; reintroduce;
   function GetRef(const aCtx: TtfwContext): TtfwWord; virtual;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; virtual;
   function CanClearInRecursiveCalls: Boolean; virtual;
   function IsInParam: Boolean; virtual;
   procedure InitValue(const aCtx: TtfwContext);
   function GetKeywordFinder(const aCtx: TtfwContext): TtfwWord; virtual;
   function DoCheckWord(const aName: Il3CString): TtfwKeyWord; virtual;
   function GetKeywordByName(const aName: Il3CString): Tl3PrimString; virtual;
   function GetParentFinder: TtfwWord; virtual;
   function WordName: Il3CString; virtual;
   function IsForHelp: Boolean; virtual;
   function MakeRefForCompile(const aCtx: TtfwContext;
    aSNI: TtfwSuppressNextImmediate): TtfwWord; virtual;
   procedure SetValue(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); virtual;
   function IsCompleted(const aCtx: TtfwContext): Boolean; virtual;
   function IsImmediate(const aCtx: TtfwContext): Boolean; virtual;
   function ParamsTypes: PTypeInfoArray; virtual;
   function ParamsInfos: TtfwWordInfoArray; virtual;
   function IsGlobalVar: Boolean; virtual;
   procedure SetParent(aParent: TtfwWord); virtual;
   procedure AddCodePart(aWord: TtfwWord;
    const aCtx: TtfwContext;
    aSNI: TtfwSuppressNextImmediate);
    {* Добавляет скомпилированный код к текущему компилируемуму слову }
   procedure CompileInParameterPopCode(const aContext: TtfwContext;
    aParameterToPop: TtfwWord);
    {* Компилирует код извлечения входного параметра в код компилируемого слова }
   function CheckWord(const aName: Il3CString): TtfwKeyWord;
   function DefineInParameter(const aCtx: TtfwContext;
    const aParamName: Il3CString;
    aStereo: TtfwWord;
    aTypeInfo: TtfwWordInfo): TtfwWord;
   function NewWordDefinitor: TtfwWord;
   function KeywordFinder(const aCtx: TtfwContext): TtfwWord;
   function KeywordByName(const aName: Il3CString): Tl3PrimString;
   function ParentFinder: TtfwWord;
   function SourcePoint: TtfwSourcePoint; override;
  public
   property Redefines: TtfwWord
    read f_Redefines
    write pm_SetRedefines;
    {* Слово, которое переопределяет данное (Self) }
   property WordProducer: TtfwWord
    read pm_GetWordProducer
    write pm_SetWordProducer;
    {* Слово, которое породило данное }
   property Key: TtfwKeyWordPrim
    read f_Key
    write f_Key;
    {* Слово словаря к которому привязан данный код }
   property InnerDictionary: TtfwDictionaryPrim
    read pm_GetInnerDictionary;
    {* Внутренний словарь слова }
   property ResultTypeInfo[const aCtx: TtfwContext]: TtfwWordInfo
    read pm_GetResultTypeInfo;
   property ParentWord: TtfwWord
    read pm_GetParentWord;
 end;//TtfwWord

 TtfwKeyWord = class(TtfwKeyWordPrim)
  private
   f_Word: TtfwWord;
    {* Поле для свойства Word }
   f_Dictionary: TtfwDictionaryPrim;
    {* Поле для свойства Dictionary }
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function GetAsPCharLen: Tl3WString; override;
   procedure DoSetAsPCharLen(const Value: Tl3PCharLen); override;
  public
   constructor Create(aDictionary: TtfwDictionaryPrim;
    const aKeyword: AnsiString;
    aWord: TtfwWord); reintroduce; overload;
   constructor Create(aDictionary: TtfwDictionaryPrim;
    const aKeyword: Tl3WString); reintroduce; overload;
   constructor Create(aDictionary: TtfwDictionaryPrim;
    const aKeyword: Il3CString); reintroduce; overload;
   procedure ChangeDictionary(aValue: TtfwDictionaryPrim);
   procedure SetWord(const aCtx: TtfwContext;
    aWord: TtfwWord);
  public
   property Word: TtfwWord
    read f_Word;
    {* Код данного ключевого слова }
   property Dictionary: TtfwDictionaryPrim
    read f_Dictionary;
 end;//TtfwKeyWord

 EtfwBreak = class(EtfwExitOrBreak)
  public
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   class function Instance: EtfwBreak;
    {* Метод получения экземпляра синглетона EtfwBreak }
 end;//EtfwBreak

 EtfwFail = class(EtfwCheck)
 end;//EtfwFail

 EtfwManualBreak = class(EtfwScriptException)
 end;//EtfwManualBreak

 ItfwValueList = interface;

 ItfwFile = interface;

 (*
 ValueStack = interface
  function Get_ValuesCount: Integer;
  procedure PushString(const aString: Tl3WString); overload;
  procedure PushFile(const aFile: ItfwFile);
  function PopFile: ItfwFile;
  function IsTopObj: Boolean;
  function IsTopChar: Boolean;
  procedure PushChar(aChar: AnsiChar);
  function PopChar: AnsiChar;
  procedure PushWStr(const aStr: Tl3WString);
  function PopPrintable: Il3CString;
  procedure PushClass(aClass: TClass);
  function PopClass: TClass;
  function IsTopClass: Boolean;
  function PopObjAs(aClass: TClass;
   aAllowNil: Boolean = True): Pointer;
  function PopClassAs(aClass: TClass): Pointer;
  function PopWideString: WideString;
  procedure PushWideString(const aValue: WideString);
  function PopPoint: TPoint;
  procedure PushPoint(const aPoint: TPoint);
  procedure PushList(const aList: ItfwValueList);
  function PopList: ItfwValueList;
  procedure DupN(aN: Integer);
  procedure DropN(aN: Integer);
  function Top: PtfwStackValue;
  procedure PushIntf(const anIntf: IUnknown;
   aType: PTypeInfo);
  procedure PushString(aString: Tl3PrimString); overload;
  procedure PushString(const aString: Il3CString); overload;
  procedure PushString(const aString: AnsiString); overload;
  function IsTopString: Boolean;
  function PopDelphiString: AnsiString;
  function PopString: Il3CString;
  function IsTopInt: Boolean;
  procedure Dup;
  procedure Drop;
  procedure Swap;
  procedure Push(const aValue: TtfwStackValue);
  function Pop: TtfwStackValue;
  function IsTopType(aType: TtfwValueType): Boolean;
  procedure PushObj(aValue: TObject);
  function PopObj: TObject;
  procedure DupIfNotZero;
  procedure Rot;
  procedure Pick;
  procedure InvertRot;
  procedure Swap2;
  procedure Over2;
  procedure Dup2;
  procedure Drop2;
  procedure Nip;
  procedure Tuck;
  procedure Over;
  procedure Roll;
  function PopIntf(const aGUID: TGUID): IUnknown; overload;
  function PopIntf: IUnknown; overload;
  function IsTopIntf: Boolean;
   {* Определяет - лежит ли на верхушке стека интерфейс }
  procedure PushInt(aValue: Integer);
  function PopInt: Integer;
  procedure PushBool(aValue: Boolean);
  function PopBool: Boolean;
  function IsTopBool: Boolean;
  property ValuesCount: Integer
   read Get_ValuesCount;
 end;//ValueStack
 *)

 ItfwScriptEngine = interface
  ['{29CD3B5A-963E-4630-AE73-2D2D05667FAA}']
  function Get_ValuesCount: Integer;
  function Clone: ItfwScriptEngine;
  procedure WordFail(const aPoint: TtfwSourcePoint);
  procedure WordSuccess;
  procedure ExceptionStackToLog;
  function ExceptionStack: ItfwValueList;
  procedure FailToLog;
  function OpenDictionary(var aCtx: TtfwContext): Boolean;
  procedure CloseDictionary(const aCtx: TtfwContext);
  procedure AddInitialization(const aCtx: TtfwContext;
   aWord: TtfwWord);
  function CurrentCompilingDictionary: TtfwDictionaryPrim;
  procedure DisableForHelp(aWord: TtfwWord);
  procedure PushString(const aString: Tl3WString); overload;
  procedure PushFile(const aFile: ItfwFile);
  function PopFile: ItfwFile;
  function IsTopObj: Boolean;
  function IsTopChar: Boolean;
  procedure PushChar(aChar: AnsiChar);
  function PopChar: AnsiChar;
  procedure PushWStr(const aStr: Tl3WString);
  function PopPrintable: Il3CString;
  procedure PushClass(aClass: TClass);
  function PopClass: TClass;
  function IsTopClass: Boolean;
  function PopObjAs(aClass: TClass;
   aAllowNil: Boolean = True): Pointer;
  function PopClassAs(aClass: TClass): Pointer;
  function PopWideString: WideString;
  procedure PushWideString(const aValue: WideString);
  function PopPoint: TPoint;
  procedure PushPoint(const aPoint: TPoint);
  procedure PushList(const aList: ItfwValueList);
  function PopList: ItfwValueList;
  procedure DupN(aN: Integer);
  procedure DropN(aN: Integer);
  function Top: PtfwStackValue;
  procedure PushIntf(const anIntf: IUnknown;
   aType: PTypeInfo);
  procedure PushString(aString: Tl3PrimString); overload;
  procedure PushString(const aString: Il3CString); overload;
  procedure PushString(const aString: AnsiString); overload;
  function IsTopString: Boolean;
  function PopDelphiString: AnsiString;
  function PopString: Il3CString;
  function IsTopInt: Boolean;
  procedure Dup;
  procedure Drop;
  procedure Swap;
  procedure Push(const aValue: TtfwStackValue);
  function Pop: TtfwStackValue;
  function IsTopType(aType: TtfwValueType): Boolean;
  procedure PushObj(aValue: TObject);
  function PopObj: TObject;
  procedure DupIfNotZero;
  procedure Rot;
  procedure Pick;
  procedure InvertRot;
  procedure Swap2;
  procedure Over2;
  procedure Dup2;
  procedure Drop2;
  procedure Nip;
  procedure Tuck;
  procedure Over;
  procedure Roll;
  function PopIntf(const aGUID: TGUID): IUnknown; overload;
  function PopIntf: IUnknown; overload;
  function IsTopIntf: Boolean;
   {* Определяет - лежит ли на верхушке стека интерфейс }
  procedure PushInt(aValue: Integer);
  function PopInt: Integer;
  procedure PushBool(aValue: Boolean);
  function PopBool: Boolean;
  function IsTopBool: Boolean;
  function KeywordFinder(const aCtx: TtfwContext): TtfwWord;
  function KeywordByName(const aName: Il3CString): Tl3PrimString;
  function ParentFinder: TtfwWord;
  property ValuesCount: Integer
   read Get_ValuesCount;
 end;//ItfwScriptEngine

 (*
 MtfwIterator = interface
  procedure ForEach(aLambda: TtfwWordPrim;
   const aCtx: TtfwContext);
  procedure ForEachBack(aLambda: TtfwWordPrim;
   const aCtx: TtfwContext);
 end;//MtfwIterator
 *)

 ItfwIterator = interface
  ['{CA80840A-0DB7-4754-842E-BB5BFE93A927}']
  procedure ForEach(aLambda: TtfwWordPrim;
   const aCtx: TtfwContext);
  procedure ForEachBack(aLambda: TtfwWordPrim;
   const aCtx: TtfwContext);
 end;//ItfwIterator

 //_ItemType_ = TtfwStackValue;
 ItfwValueList = interface(ItfwIterator)
  ['{95FE5CAE-0988-49C5-A0E1-BDA62233AA8C}']
  function pm_GetEmpty: Boolean;
  function pm_GetFirst: TtfwStackValue;
  function pm_GetLast: TtfwStackValue;
  function pm_GetItems(anIndex: Integer): TtfwStackValue;
  procedure SetItem(anIndex: Integer;
   const aValue: TtfwStackValue);
  function ItemsCountInSlice: Integer;
  function IndexOf(const anItem: TtfwStackValue): Integer;
  function Add(const anItem: TtfwStackValue): Integer;
  procedure Clear;
  property Empty: Boolean
   read pm_GetEmpty;
  property First: TtfwStackValue
   read pm_GetFirst;
   {* Первый элемент. }
  property Last: TtfwStackValue
   read pm_GetLast;
   {* Последний элемент. }
  property Items[anIndex: Integer]: TtfwStackValue
   read pm_GetItems;
   default;
 end;//ItfwValueList

 TtfwStoredValue = record
  {* Сохранённое значение переменной для восстановления }
  rValue: TtfwStackValue;
   {* Значение для восстановления }
  rWord: TtfwWord;
   {* Переменная для восстановления }
 end;//TtfwStoredValue

 (*
 MtfwStoredValuesStack = interface
  procedure Restore(const aCtx: TtfwContext);
  procedure StoreDictionary(aDictionary: TtfwDictionaryPrim;
   const aCtx: TtfwContext);
 end;//MtfwStoredValuesStack
 *)

 ItfwStoredValues = interface;

 //_ItemType_ = ItfwStoredValues;
 ItfwStoredValuesStack = interface
  ['{DABE9CDD-34A6-43DB-BFB5-4F58BE50A720}']
  function pm_GetEmpty: Boolean;
  function pm_GetFirst: ItfwStoredValues;
  function pm_GetLast: ItfwStoredValues;
  function pm_GetItems(anIndex: Integer): ItfwStoredValues;
  function IndexOf(const anItem: ItfwStoredValues): Integer;
  function Add(const anItem: ItfwStoredValues): Integer;
  procedure Restore(const aCtx: TtfwContext);
  procedure StoreDictionary(aDictionary: TtfwDictionaryPrim;
   const aCtx: TtfwContext);
  property Empty: Boolean
   read pm_GetEmpty;
  property First: ItfwStoredValues
   read pm_GetFirst;
   {* Первый элемент. }
  property Last: ItfwStoredValues
   read pm_GetLast;
   {* Последний элемент. }
  property Items[anIndex: Integer]: ItfwStoredValues
   read pm_GetItems;
   default;
 end;//ItfwStoredValuesStack

 ItfwStoredValues = interface
  ['{39369047-E783-4A4B-9657-6C2450D737C3}']
  procedure Restore(const aCtx: TtfwContext);
  function Grow: PtfwStoredValue;
 end;//ItfwStoredValues

 ItfwFile = interface(ItfwIterator)
  ['{BBB2A3FB-A633-40F3-BE85-9E997623BA12}']
  function ReadLn: Il3CString;
  procedure WriteLn(const aString: Il3CString);
  procedure WriteChar(aChar: AnsiChar);
  function ReadWStrLn: Tl3WString;
  procedure WriteWStrLn(const aStr: Tl3WString);
  procedure WriteWStr(const aStr: Tl3WString);
  function EOF: Boolean;
 end;//ItfwFile

 TtfwWordCallContext = record
  rCtx: PtfwContext;
  rWord: TtfwWord;
 end;//TtfwWordCallContext

 TtfwValueType = tfwTypeInfo.TtfwValueType;

 TtfwWordModifier = tfwScriptingTypes.TtfwWordModifier;

 TtfwWordInfoF = class(TtfwWordInfo)
  private
   f_WordInfo: TtfwWordInfoRec;
  protected
   {$If NOT Defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
    {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
  public
   constructor Create(const aModifiers: TtfwWordInfoRec); reintroduce;
   function IncludeModifier(aModifier: TtfwWordModifier): TtfwWordInfo; override;
   function Empty: Boolean; override;
   function Has(aModifier: TtfwWordModifier): Boolean; override;
   function Clone: TtfwWordInfo; override;
   function pRec: PtfwWordInfoRec; override;
   function IncludeTypeModifier(aType: TtfwValueType): TtfwWordInfo; override;
   function Has(aType: TtfwValueType): Boolean; override;
   function AcceptsValue(const aValue: TtfwStackValue): Boolean; override;
   function Has(anAccess: TtfwAccessType): Boolean; override;
   function IncludeAccesType(anAccess: TtfwAccessType): TtfwWordInfo; override;
   function EQwm(aValue: TtfwWordModifiers): Boolean; override;
   function IncludeType(const aType: TtfwTypeInfo): TtfwWordInfo; override;
   function TypeName: Il3CString; override;
   function ValueTypes: TtfwValueTypes; override;
   function IncludeLinkType(aLinkType: TtfwLinkType): TtfwWordInfo; override;
   function Has(aLinkType: TtfwLinkType): Boolean; override;
   function LinkType: TtfwLinkType; override;
   function AccessType: TtfwAccessType; override;
   function Compare(anOther: TtfwWordInfo): Integer; override;
   function Modifiers: TtfwWordModifiers; override;
   function ToString: Il3CString; override;
 end;//TtfwWordInfoF

 TtfwWordInfoRec = tfwScriptingTypes.TtfwWordInfoRec;

 EtfwException = tfwScriptingExceptions.EtfwException;

 EtfwCheck = tfwScriptingExceptions.EtfwCheck;

 TtfwNewWordDefinitor = TtfwWord;

 TtfwValueTypes = tfwScriptingTypes.TtfwValueTypes;

 TtfwWordInfoE = class(TtfwWordInfo)
  public
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   function IncludeModifier(aModifier: TtfwWordModifier): TtfwWordInfo; override;
   function Empty: Boolean; override;
   function Has(aModifier: TtfwWordModifier): Boolean; override;
   function Clone: TtfwWordInfo; override;
   function pRec: PtfwWordInfoRec; override;
   function IncludeTypeModifier(aType: TtfwValueType): TtfwWordInfo; override;
   function Has(aType: TtfwValueType): Boolean; override;
   function AcceptsValue(const aValue: TtfwStackValue): Boolean; override;
   function Has(anAccess: TtfwAccessType): Boolean; override;
   function IncludeAccesType(anAccess: TtfwAccessType): TtfwWordInfo; override;
   function EQwm(aValue: TtfwWordModifiers): Boolean; override;
   function IncludeType(const aType: TtfwTypeInfo): TtfwWordInfo; override;
   function TypeName: Il3CString; override;
   function ValueTypes: TtfwValueTypes; override;
   function IncludeLinkType(aLinkType: TtfwLinkType): TtfwWordInfo; override;
   function Has(aLinkType: TtfwLinkType): Boolean; override;
   function LinkType: TtfwLinkType; override;
   function AccessType: TtfwAccessType; override;
   function Compare(anOther: TtfwWordInfo): Integer; override;
   function Modifiers: TtfwWordModifiers; override;
   function ToString: Il3CString; override;
   class function Instance: TtfwWordInfoE;
    {* Метод получения экземпляра синглетона TtfwWordInfoE }
 end;//TtfwWordInfoE

 PtfwStackValue = tfwTypeInfo.PtfwStackValue;

 TtfwKeywordFinder = TtfwWord;

 TtfwCStringFactoryEx = class(TtfwCStringFactory)
  public
   class function ViewOf(const aString: Tl3WString): TtfwStackValue; overload;
   class function ViewOf(const aString: AnsiString): TtfwStackValue; overload;
 end;//TtfwCStringFactoryEx

 TtfwCompiler = TtfwWord;

function TtfwSourcePoint_E: TtfwSourcePoint;
function TtfwStackValue_C(const aValue: ItfwFile): TtfwStackValue; overload;
function TtfwStackValue_C(const aValue: ItfwValueList): TtfwStackValue; overload;
function TtfwStackValue_C(aValue: Integer): TtfwStackValue; overload;
function TtfwStackValue_C(aValue: Boolean): TtfwStackValue; overload;
function TtfwStackValue_C(aValue: TObject): TtfwStackValue; overload;
function TtfwStackValue_C(const aValue: Il3CString): TtfwStackValue; overload;
function TtfwStackValue_C(const anIntf: IUnknown): TtfwStackValue; overload;
function TtfwStackValue_C(aClass: TClass): TtfwStackValue; overload;
function TtfwStackValue_C(aValue: AnsiChar): TtfwStackValue; overload;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwWordInfoWordsPack
 , l3Base
 , StrUtils
 , l3Parser
 , tfwClassRef
 , ArrayProcessingPack
 , BasicsPack
 , FileProcessingPack
 , SysUtilsPack
 , WordsRTTIPack
 , l3String
 , kwForwardDeclaration
 , KeyWordPack
 , tfwWordInfoCache
 , NewWordDefinitorPack
 , ItfwKeywordFinderWordsPack
 , ItfwCompilerWordsPack
;

var g_EtfwContinue: EtfwContinue = nil;
 {* Экземпляр синглетона EtfwContinue }
var g_EtfwExit: EtfwExit = nil;
 {* Экземпляр синглетона EtfwExit }
var g_EtfwHalt: EtfwHalt = nil;
 {* Экземпляр синглетона EtfwHalt }
var g_EtfwBreakIterator: EtfwBreakIterator = nil;
 {* Экземпляр синглетона EtfwBreakIterator }
var g_EtfwBreak: EtfwBreak = nil;
 {* Экземпляр синглетона EtfwBreak }
var g_TtfwWordInfoE: TtfwWordInfoE = nil;
 {* Экземпляр синглетона TtfwWordInfoE }

function TtfwSourcePoint_E: TtfwSourcePoint;
//#UC START# *55647E560346_55647DF70372_var*
//#UC END# *55647E560346_55647DF70372_var*
begin
 Finalize(Result);
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *55647E560346_55647DF70372_impl*
 Result.rName := nil;
 Result.rFileName := nil;
 Result.rProducerName := nil;
 Result.rLine := -1;
//#UC END# *55647E560346_55647DF70372_impl*
end;//TtfwSourcePoint_E

procedure EtfwContinueFree;
 {* Метод освобождения экземпляра синглетона EtfwContinue }
begin
 l3Free(g_EtfwContinue);
end;//EtfwContinueFree

procedure EtfwExitFree;
 {* Метод освобождения экземпляра синглетона EtfwExit }
begin
 l3Free(g_EtfwExit);
end;//EtfwExitFree

procedure EtfwHaltFree;
 {* Метод освобождения экземпляра синглетона EtfwHalt }
begin
 l3Free(g_EtfwHalt);
end;//EtfwHaltFree

procedure EtfwBreakIteratorFree;
 {* Метод освобождения экземпляра синглетона EtfwBreakIterator }
begin
 l3Free(g_EtfwBreakIterator);
end;//EtfwBreakIteratorFree

procedure EtfwBreakFree;
 {* Метод освобождения экземпляра синглетона EtfwBreak }
begin
 l3Free(g_EtfwBreak);
end;//EtfwBreakFree

function TtfwStackValue_C(const aValue: ItfwFile): TtfwStackValue;
//#UC START# *4F4E5D6C038D_55C0AEF80328_var*
//#UC END# *4F4E5D6C038D_55C0AEF80328_var*
begin
 Finalize(Result);
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *4F4E5D6C038D_55C0AEF80328_impl*
 Result.rType := tfw_vtFile;
 ItfwFile(Result.rString) := aValue;
//#UC END# *4F4E5D6C038D_55C0AEF80328_impl*
end;//TtfwStackValue_C

function TtfwStackValue_C(const aValue: ItfwValueList): TtfwStackValue;
//#UC START# *4DCC17860019_55C0AEF80328_var*
//#UC END# *4DCC17860019_55C0AEF80328_var*
begin
 Finalize(Result);
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *4DCC17860019_55C0AEF80328_impl*
 Result.rType := tfw_vtList;
 ItfwValueList(Result.rString) := aValue;
//#UC END# *4DCC17860019_55C0AEF80328_impl*
end;//TtfwStackValue_C

function TtfwStackValue_C(aValue: Integer): TtfwStackValue;
//#UC START# *4DB00AAB02FA_55C0AEF80328_var*
//#UC END# *4DB00AAB02FA_55C0AEF80328_var*
begin
 Finalize(Result);
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *4DB00AAB02FA_55C0AEF80328_impl*
 Result.rType := tfw_vtInt;
 Result.rInteger := aValue;
//#UC END# *4DB00AAB02FA_55C0AEF80328_impl*
end;//TtfwStackValue_C

function TtfwStackValue_C(aValue: Boolean): TtfwStackValue;
//#UC START# *4DB01368005C_55C0AEF80328_var*
//#UC END# *4DB01368005C_55C0AEF80328_var*
begin
 Finalize(Result);
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *4DB01368005C_55C0AEF80328_impl*
 Result.rType := tfw_vtBool;
 if aValue then
  Result.rInteger := 1
 else
  Result.rInteger := 0;
//#UC END# *4DB01368005C_55C0AEF80328_impl*
end;//TtfwStackValue_C

function TtfwStackValue_C(aValue: TObject): TtfwStackValue;
//#UC START# *4DBAF9410061_55C0AEF80328_var*
//#UC END# *4DBAF9410061_55C0AEF80328_var*
begin
 Finalize(Result);
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *4DBAF9410061_55C0AEF80328_impl*
 Result.rType := tfw_vtObj;
 Result.rInteger := Integer(aValue);
//#UC END# *4DBAF9410061_55C0AEF80328_impl*
end;//TtfwStackValue_C

function TtfwStackValue_C(const aValue: Il3CString): TtfwStackValue;
//#UC START# *4DB04AC6039F_55C0AEF80328_var*
//#UC END# *4DB04AC6039F_55C0AEF80328_var*
begin
 Finalize(Result);
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *4DB04AC6039F_55C0AEF80328_impl*
 Result.rType := tfw_vtStr;
 Result.rString := aValue;
//#UC END# *4DB04AC6039F_55C0AEF80328_impl*
end;//TtfwStackValue_C

function TtfwStackValue_C(const anIntf: IUnknown): TtfwStackValue;
//#UC START# *4EB275570202_55C0AEF80328_var*
//#UC END# *4EB275570202_55C0AEF80328_var*
begin
 Finalize(Result);
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *4EB275570202_55C0AEF80328_impl*
 Result.rType := tfw_vtIntf;
 IUnknown(Result.rString) := anIntf;
//#UC END# *4EB275570202_55C0AEF80328_impl*
end;//TtfwStackValue_C

function TtfwStackValue_C(aClass: TClass): TtfwStackValue;
//#UC START# *50852D1B015E_55C0AEF80328_var*
//#UC END# *50852D1B015E_55C0AEF80328_var*
begin
 Finalize(Result);
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *50852D1B015E_55C0AEF80328_impl*
 Result.rType := tfw_vtClass;
 Result.rInteger := Integer(aClass);
//#UC END# *50852D1B015E_55C0AEF80328_impl*
end;//TtfwStackValue_C

function TtfwStackValue_C(aValue: AnsiChar): TtfwStackValue;
//#UC START# *4F4FDCD4016D_55C0AEF80328_var*
//#UC END# *4F4FDCD4016D_55C0AEF80328_var*
begin
 Finalize(Result);
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *4F4FDCD4016D_55C0AEF80328_impl*
 Result.rType := tfw_vtChar;
 Result.rInteger := Ord(aValue);
//#UC END# *4F4FDCD4016D_55C0AEF80328_impl*
end;//TtfwStackValue_C

procedure TtfwWordInfoEFree;
 {* Метод освобождения экземпляра синглетона TtfwWordInfoE }
begin
 l3Free(g_TtfwWordInfoE);
end;//TtfwWordInfoEFree

function TtfwSourcePoint.Empty: Boolean;
//#UC START# *55648E7E02DE_55647DF70372_var*
//#UC END# *55648E7E02DE_55647DF70372_var*
begin
//#UC START# *55648E7E02DE_55647DF70372_impl*
 Result := (l3IsNil(rName) AND l3IsNil(rFileName)){ OR (rLine <= 0)};
//#UC END# *55648E7E02DE_55647DF70372_impl*
end;//TtfwSourcePoint.Empty

function TtfwSourcePoint.ToString: AnsiString;
//#UC START# *556493D60163_55647DF70372_var*
var
 l_S : AnsiString;
 l_N : AnsiString;
 l_P : AnsiString;
//#UC END# *556493D60163_55647DF70372_var*
begin
//#UC START# *556493D60163_55647DF70372_impl*
 Result := l3Str(rName);
 if (Result <> '') then
 begin
  l_P := l3Str(Self.rProducerName);
  if (l_P <> '') then
   if (l_P <> Result) then
    Result := l3ConcatText(l_P, Result);
 end;//Result <> ''

 l_S := '';
 if (rLine > 0) then
  l_S := 'Line ' + IntToStr(rLine);

 l_N := ExtractFileName(l3Str(rFileName));
 if (l_N <> '') then
 begin
  if (l_S <> '') then
   l_S := l_S + ', ' + l_N
  else
   l_S := l_N;
 end;//l_N <> ''
 
 if (l_S <> '') then
 begin
  l_S := '(' + l_S + ')';
  Result := l3ConcatText(Result, l_S);
 end;//l_S <> ''
//#UC END# *556493D60163_55647DF70372_impl*
end;//TtfwSourcePoint.ToString

class function TtfwWordInfo.Make(const aTypeInfoRec: TtfwWordInfoRec): TtfwWordInfo;
//#UC START# *55B25CDC00AF_559D504A0081_var*
//#UC END# *55B25CDC00AF_559D504A0081_var*
begin
//#UC START# *55B25CDC00AF_559D504A0081_impl*
 Result := TtfwWordInfoCache.Instance.GetTypeInfo(aTypeInfoRec);
//#UC END# *55B25CDC00AF_559D504A0081_impl*
end;//TtfwWordInfo.Make

class function TtfwWordInfo.Make(aTypeInfo: PTypeInfo): TtfwWordInfo;
//#UC START# *559D51990164_559D504A0081_var*
//#UC END# *559D51990164_559D504A0081_var*
begin
//#UC START# *559D51990164_559D504A0081_impl*
 Result := Make(TtfwWordInfoRec_C(TtfwValueTypes.Make(aTypeInfo), [], tfw_atNone, tfw_ltNone));
//#UC END# *559D51990164_559D504A0081_impl*
end;//TtfwWordInfo.Make

class function TtfwWordInfo.Make(aTypes: TtfwValueTypes;
 aModifiers: TtfwWordModifiers;
 anAccess: TtfwAccessType;
 aLinkType: TtfwLinkType): TtfwWordInfo;
//#UC START# *55BB8EDE02C5_559D504A0081_var*
//#UC END# *55BB8EDE02C5_559D504A0081_var*
begin
//#UC START# *55BB8EDE02C5_559D504A0081_impl*
 Result := Make(TtfwWordInfoRec_C(aTypes, aModifiers, anAccess, aLinkType));
//#UC END# *55BB8EDE02C5_559D504A0081_impl*
end;//TtfwWordInfo.Make

class function TtfwWordInfo.Make(const aType: TtfwTypeInfo): TtfwWordInfo;
//#UC START# *55C0C85702A4_559D504A0081_var*
//#UC END# *55C0C85702A4_559D504A0081_var*
begin
//#UC START# *55C0C85702A4_559D504A0081_impl*
 Result := Make(TtfwWordInfoRec_C(TtfwValueTypes.Make(aType), [], tfw_atNone, tfw_ltNone));
//#UC END# *55C0C85702A4_559D504A0081_impl*
end;//TtfwWordInfo.Make

constructor EtfwExitOrBreak.Create(const aMessage: AnsiString);
//#UC START# *5605555F003E_5596255801C5_var*
//#UC END# *5605555F003E_5596255801C5_var*
begin
//#UC START# *5605555F003E_5596255801C5_impl*
 inherited Create(aMessage);
 AllowFree := true;
//#UC END# *5605555F003E_5596255801C5_impl*
end;//EtfwExitOrBreak.Create

constructor EtfwExitOrBreak.Create;
//#UC START# *560555C3003C_5596255801C5_var*
//#UC END# *560555C3003C_5596255801C5_var*
begin
//#UC START# *560555C3003C_5596255801C5_impl*
 inherited Create('');
 AllowFree := false;
//#UC END# *560555C3003C_5596255801C5_impl*
end;//EtfwExitOrBreak.Create

procedure EtfwExitOrBreak.FreeInstance;
//#UC START# *5161317A0219_5596255801C5_var*
//#UC END# *5161317A0219_5596255801C5_var*
begin
//#UC START# *5161317A0219_5596255801C5_impl*
 if AllowFree OR l3System.IsDown then
  inherited;
//#UC END# *5161317A0219_5596255801C5_impl*
end;//EtfwExitOrBreak.FreeInstance

class function EtfwContinue.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_EtfwContinue <> nil;
end;//EtfwContinue.Exists

class function EtfwContinue.Instance: EtfwContinue;
 {* Метод получения экземпляра синглетона EtfwContinue }
begin
 if (g_EtfwContinue = nil) then
 begin
  l3System.AddExitProc(EtfwContinueFree);
  g_EtfwContinue := Create;
 end;
 Result := g_EtfwContinue;
end;//EtfwContinue.Instance

class function EtfwExit.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_EtfwExit <> nil;
end;//EtfwExit.Exists

class function EtfwExit.Instance: EtfwExit;
 {* Метод получения экземпляра синглетона EtfwExit }
begin
 if (g_EtfwExit = nil) then
 begin
  l3System.AddExitProc(EtfwExitFree);
  g_EtfwExit := Create;
 end;
 Result := g_EtfwExit;
end;//EtfwExit.Instance

class function EtfwHalt.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_EtfwHalt <> nil;
end;//EtfwHalt.Exists

class function EtfwHalt.Instance: EtfwHalt;
 {* Метод получения экземпляра синглетона EtfwHalt }
begin
 if (g_EtfwHalt = nil) then
 begin
  l3System.AddExitProc(EtfwHaltFree);
  g_EtfwHalt := Create;
 end;
 Result := g_EtfwHalt;
end;//EtfwHalt.Instance

procedure TtfwContext.SetWordInfo(aValue: TtfwWordInfo);
//#UC START# *55C386170161_4DB0091E033E_var*
//#UC END# *55C386170161_4DB0091E033E_var*
begin
//#UC START# *55C386170161_4DB0091E033E_impl*
 rTypeInfo := aValue;
//#UC END# *55C386170161_4DB0091E033E_impl*
end;//TtfwContext.SetWordInfo

function TtfwContext.ResolveIncludedFilePath(const aFile: AnsiString): AnsiString;
//#UC START# *55C89C5C015C_4DB0091E033E_var*
//#UC END# *55C89C5C015C_4DB0091E033E_var*
begin
//#UC START# *55C89C5C015C_4DB0091E033E_impl*
 if (ExtractFileDrive(aFile) <> '') OR
    AnsiStartsText('axiom:', aFile) then
 begin
  Result := aFile;
  if (Length(Result) > 2) then
   if (Result[2] = ':') then
    l3MakeLowerCase(@Result[1], 1);
 end//ExtractFileDrive(aFile) <> ''
 else
  Result := rCaller.ResolveIncludedFilePath(aFile);
//#UC END# *55C89C5C015C_4DB0091E033E_impl*
end;//TtfwContext.ResolveIncludedFilePath

function TtfwWordPrim.IsCompiled: Boolean;
//#UC START# *4DB6CF7202CB_52EA594400DD_var*
//#UC END# *4DB6CF7202CB_52EA594400DD_var*
begin
//#UC START# *4DB6CF7202CB_52EA594400DD_impl*
 Result := false;
//#UC END# *4DB6CF7202CB_52EA594400DD_impl*
end;//TtfwWordPrim.IsCompiled

procedure TtfwWordPrim.StoreState(const aCtx: TtfwContext);
//#UC START# *4F49428A01EA_52EA594400DD_var*
//#UC END# *4F49428A01EA_52EA594400DD_var*
begin
//#UC START# *4F49428A01EA_52EA594400DD_impl*
 // - ничего не делаем
//#UC END# *4F49428A01EA_52EA594400DD_impl*
end;//TtfwWordPrim.StoreState

procedure TtfwWordPrim.RestoreState(const aCtx: TtfwContext);
//#UC START# *4F4942C50339_52EA594400DD_var*
//#UC END# *4F4942C50339_52EA594400DD_var*
begin
//#UC START# *4F4942C50339_52EA594400DD_impl*
 // - ничего не делаем
//#UC END# *4F4942C50339_52EA594400DD_impl*
end;//TtfwWordPrim.RestoreState

procedure TtfwWordPrim.DoIt(const aCtx: TtfwContext);
//#UC START# *4F22776902FC_52EA594400DD_var*
//#UC END# *4F22776902FC_52EA594400DD_var*
begin
//#UC START# *4F22776902FC_52EA594400DD_impl*
 EtfwCheck.IsTrue(f_NestedCallsCount >= 0, 'Сломанный счётчик рекурсивных вызовов');
 try
  if (f_NestedCallsCount > 0) then
   if IsCompiled then
   // - отсекаем некомпилированные слова, т.к. с ними наверное всё хорошо
   //   а иначе падает например на том же INCLUDE
    begin
     Self.StoreState(aCtx);
     try
      Inc(f_NestedCallsCount);
      try
       DoDoIt(aCtx);
      finally
       Dec(f_NestedCallsCount);
      end;//try..finally
     finally
      Self.RestoreState(aCtx);
     end;//try..finally
     Exit;
     //raise EtfwRecursionNotSupportedYet.Create('Вложенные вызовы слов пока не поддерживаются');
     // - тут вообще говоря надо сложить значения переменных в стек, вызвать DoDoIt, а потом восстановит переменные
    end;//IsCompiled
  Inc(f_NestedCallsCount);
  try
   try
    DoDoIt(aCtx);
   finally
    ClearState(aCtx);
   end;///try..finally
  finally
   Dec(f_NestedCallsCount);
  end;//try..finally
 except
  on EtfwExitOrBreak do
   raise;
  else
  begin
   aCtx.rEngine.WordFail(SourcePoint);
   raise;
  end;//else 
 end;//try..except
//#UC END# *4F22776902FC_52EA594400DD_impl*
end;//TtfwWordPrim.DoIt

procedure TtfwWordPrim.ClearState(const aCtx: TtfwContext);
//#UC START# *53C90EC00136_52EA594400DD_var*
//#UC END# *53C90EC00136_52EA594400DD_var*
begin
//#UC START# *53C90EC00136_52EA594400DD_impl*
 // - ничего не делаем
//#UC END# *53C90EC00136_52EA594400DD_impl*
end;//TtfwWordPrim.ClearState

function TtfwWordPrim.SourcePoint: TtfwSourcePoint;
//#UC START# *556317DE02B5_52EA594400DD_var*
//#UC END# *556317DE02B5_52EA594400DD_var*
begin
//#UC START# *556317DE02B5_52EA594400DD_impl*
 Result := TtfwSourcePoint_E;
//#UC END# *556317DE02B5_52EA594400DD_impl*
end;//TtfwWordPrim.SourcePoint

procedure TtfwWordPrim.PushAdditionalParams(const aCtx: TtfwContext);
//#UC START# *55EED3920052_52EA594400DD_var*
//#UC END# *55EED3920052_52EA594400DD_var*
begin
//#UC START# *55EED3920052_52EA594400DD_impl*
 EtfwCheck.Fail('Недоделано. Может и не пригодится');
//#UC END# *55EED3920052_52EA594400DD_impl*
end;//TtfwWordPrim.PushAdditionalParams

class function EtfwBreakIterator.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_EtfwBreakIterator <> nil;
end;//EtfwBreakIterator.Exists

class function EtfwBreakIterator.Instance: EtfwBreakIterator;
 {* Метод получения экземпляра синглетона EtfwBreakIterator }
begin
 if (g_EtfwBreakIterator = nil) then
 begin
  l3System.AddExitProc(EtfwBreakIteratorFree);
  g_EtfwBreakIterator := Create;
 end;
 Result := g_EtfwBreakIterator;
end;//EtfwBreakIterator.Instance

procedure TtfwWord.pm_SetRedefines(aValue: TtfwWord);
//#UC START# *4F41FF0C01A6_4DAEED140007set_var*
//#UC END# *4F41FF0C01A6_4DAEED140007set_var*
begin
//#UC START# *4F41FF0C01A6_4DAEED140007set_impl*
 EtfwCheck.IsTrue((f_Redefines = nil) OR (aValue = f_Redefines), 'Слово не может переопределять БОЛЕЕ одного слова');
 EtfwCheck.IsTrue(aValue <> Self, 'Слово не может переопределять самого себя');
 aValue.SetRefTo(f_Redefines);
//#UC END# *4F41FF0C01A6_4DAEED140007set_impl*
end;//TtfwWord.pm_SetRedefines

function TtfwWord.pm_GetWordProducer: TtfwWord;
//#UC START# *4F43C9A10139_4DAEED140007get_var*
//#UC END# *4F43C9A10139_4DAEED140007get_var*
begin
//#UC START# *4F43C9A10139_4DAEED140007get_impl*
 Result := nil;
//#UC END# *4F43C9A10139_4DAEED140007get_impl*
end;//TtfwWord.pm_GetWordProducer

procedure TtfwWord.pm_SetWordProducer(aValue: TtfwWord);
//#UC START# *4F43C9A10139_4DAEED140007set_var*
//#UC END# *4F43C9A10139_4DAEED140007set_var*
begin
//#UC START# *4F43C9A10139_4DAEED140007set_impl*
 Assert(false);
//#UC END# *4F43C9A10139_4DAEED140007set_impl*
end;//TtfwWord.pm_SetWordProducer

function TtfwWord.pm_GetInnerDictionary: TtfwDictionaryPrim;
//#UC START# *52B43311021D_4DAEED140007get_var*
//#UC END# *52B43311021D_4DAEED140007get_var*
begin
//#UC START# *52B43311021D_4DAEED140007get_impl*
 Result := nil;
//#UC END# *52B43311021D_4DAEED140007get_impl*
end;//TtfwWord.pm_GetInnerDictionary

function TtfwWord.pm_GetResultTypeInfo(const aCtx: TtfwContext): TtfwWordInfo;
//#UC START# *52CFC11603C8_4DAEED140007get_var*
//#UC END# *52CFC11603C8_4DAEED140007get_var*
begin
//#UC START# *52CFC11603C8_4DAEED140007get_impl*
 Result := TtfwWordInfo.Make(GetResultTypeInfo(aCtx));
//#UC END# *52CFC11603C8_4DAEED140007get_impl*
end;//TtfwWord.pm_GetResultTypeInfo

function TtfwWord.pm_GetParentWord: TtfwWord;
//#UC START# *52CFCF4B02C6_4DAEED140007get_var*
//#UC END# *52CFCF4B02C6_4DAEED140007get_var*
begin
//#UC START# *52CFCF4B02C6_4DAEED140007get_impl*
 Result := nil;
//#UC END# *52CFCF4B02C6_4DAEED140007get_impl*
end;//TtfwWord.pm_GetParentWord

function TtfwWord.IsDefaultBranch: Boolean;
//#UC START# *4DBAF4630154_4DAEED140007_var*
//#UC END# *4DBAF4630154_4DAEED140007_var*
begin
//#UC START# *4DBAF4630154_4DAEED140007_impl*
 Result := false;
//#UC END# *4DBAF4630154_4DAEED140007_impl*
end;//TtfwWord.IsDefaultBranch

procedure TtfwWord.RunnerAssert(aCondition: Boolean;
 const aMessage: AnsiString;
 const aContext: TtfwContext);
//#UC START# *4EF4AE480303_4DAEED140007_var*
//#UC END# *4EF4AE480303_4DAEED140007_var*
begin
//#UC START# *4EF4AE480303_4DAEED140007_impl*
 CompilerAssert(aCondition, aMessage, aContext);
//#UC END# *4EF4AE480303_4DAEED140007_impl*
end;//TtfwWord.RunnerAssert

function TtfwWord.IsAnonimous(const aCtx: TtfwContext): Boolean;
//#UC START# *4F3AB3600008_4DAEED140007_var*
//#UC END# *4F3AB3600008_4DAEED140007_var*
begin
//#UC START# *4F3AB3600008_4DAEED140007_impl*
 Result := false;
//#UC END# *4F3AB3600008_4DAEED140007_impl*
end;//TtfwWord.IsAnonimous

procedure TtfwWord.CompilerAssertFmt(aCondition: Boolean;
 const aMessage: AnsiString;
 const aParams: array of const;
 const aContext: TtfwContext);
//#UC START# *4F3E369002A2_4DAEED140007_var*
//#UC END# *4F3E369002A2_4DAEED140007_var*
begin
//#UC START# *4F3E369002A2_4DAEED140007_impl*
 CompilerAssert(aCondition, Format(aMessage, aParams), aContext);
//#UC END# *4F3E369002A2_4DAEED140007_impl*
end;//TtfwWord.CompilerAssertFmt

procedure TtfwWord.RunnerAssertFmt(aCondition: Boolean;
 const aMessage: AnsiString;
 const aParams: array of const;
 const aContext: TtfwContext);
//#UC START# *4F3E36A5031F_4DAEED140007_var*
//#UC END# *4F3E36A5031F_4DAEED140007_var*
begin
//#UC START# *4F3E36A5031F_4DAEED140007_impl*
 RunnerAssert(aCondition, Format(aMessage, aParams), aContext);
//#UC END# *4F3E36A5031F_4DAEED140007_impl*
end;//TtfwWord.RunnerAssertFmt

function TtfwWord.CompiledWordClassPrim(const aCtx: TtfwContext): RtfwWord;
//#UC START# *4F477C2C03B9_4DAEED140007_var*
//#UC END# *4F477C2C03B9_4DAEED140007_var*
begin
//#UC START# *4F477C2C03B9_4DAEED140007_impl*
 Result := nil;
//#UC END# *4F477C2C03B9_4DAEED140007_impl*
end;//TtfwWord.CompiledWordClassPrim

function TtfwWord.IsForwardDeclaration: Boolean;
//#UC START# *4F4BB6CD0359_4DAEED140007_var*
//#UC END# *4F4BB6CD0359_4DAEED140007_var*
begin
//#UC START# *4F4BB6CD0359_4DAEED140007_impl*
 Result := false;
//#UC END# *4F4BB6CD0359_4DAEED140007_impl*
end;//TtfwWord.IsForwardDeclaration

function TtfwWord.GetValue(const aCtx: TtfwContext): PtfwStackValue;
//#UC START# *52D399A00173_4DAEED140007_var*
//#UC END# *52D399A00173_4DAEED140007_var*
begin
//#UC START# *52D399A00173_4DAEED140007_impl*
 RunnerError('Невозможно получить значение', aCtx);
 Result := nil;
//#UC END# *52D399A00173_4DAEED140007_impl*
end;//TtfwWord.GetValue

function TtfwWord.IsVarLike: Boolean;
//#UC START# *52D399D40140_4DAEED140007_var*
//#UC END# *52D399D40140_4DAEED140007_var*
begin
//#UC START# *52D399D40140_4DAEED140007_impl*
 Result := false;
//#UC END# *52D399D40140_4DAEED140007_impl*
end;//TtfwWord.IsVarLike

procedure TtfwWord.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_4DAEED140007_var*
//#UC END# *52D00B00031A_4DAEED140007_var*
begin
//#UC START# *52D00B00031A_4DAEED140007_impl*
 RunnerError('Невозможно записать значение', aCtx);
//#UC END# *52D00B00031A_4DAEED140007_impl*
end;//TtfwWord.SetValuePrim

function TtfwWord.HasCode: Boolean;
 {* Есть ли у слова компилированный код }
//#UC START# *52D40F640308_4DAEED140007_var*
//#UC END# *52D40F640308_4DAEED140007_var*
begin
//#UC START# *52D40F640308_4DAEED140007_impl*
 Result := false;
//#UC END# *52D40F640308_4DAEED140007_impl*
end;//TtfwWord.HasCode

function TtfwWord.HasLocalDictionary: Boolean;
 {* Есть ли у слова локальный словарь }
//#UC START# *52D40FAA0073_4DAEED140007_var*
//#UC END# *52D40FAA0073_4DAEED140007_var*
begin
//#UC START# *52D40FAA0073_4DAEED140007_impl*
 Result := false;
//#UC END# *52D40FAA0073_4DAEED140007_impl*
end;//TtfwWord.HasLocalDictionary

function TtfwWord.CodeCount: Integer;
 {* Число элементов скомпилированного кода }
//#UC START# *52D4191402A2_4DAEED140007_var*
//#UC END# *52D4191402A2_4DAEED140007_var*
begin
//#UC START# *52D4191402A2_4DAEED140007_impl*
 Result := 0;
//#UC END# *52D4191402A2_4DAEED140007_impl*
end;//TtfwWord.CodeCount

function TtfwWord.GetCompiler(const aCtx: TtfwContext): TtfwWord;
//#UC START# *52D523A40118_4DAEED140007_var*
//#UC END# *52D523A40118_4DAEED140007_var*
begin
//#UC START# *52D523A40118_4DAEED140007_impl*
 Result := nil;
 CompilerAssert(false, 'Слово некомпилируемое', aCtx);
//#UC END# *52D523A40118_4DAEED140007_impl*
end;//TtfwWord.GetCompiler

function TtfwWord.DoDefineInParameter(const aCtx: TtfwContext;
 const aParamName: Il3CString;
 aStereo: TtfwWord;
 aTypeInfo: TtfwWordInfo): TtfwWord;
 {* Определяет слову входной параметр }
//#UC START# *4F4161BC0024_4DAEED140007_var*
//#UC END# *4F4161BC0024_4DAEED140007_var*
begin
//#UC START# *4F4161BC0024_4DAEED140007_impl*
 Result := nil;
 CompilerAssert(false, 'Слово не может иметь входных параметров', aCtx);
//#UC END# *4F4161BC0024_4DAEED140007_impl*
end;//TtfwWord.DoDefineInParameter

procedure TtfwWord.CompileInParameterPopCodeFromString(const aContext: TtfwContext;
 const aParameterToPop: Il3CString);
//#UC START# *4F4177910352_4DAEED140007_var*
//#UC END# *4F4177910352_4DAEED140007_var*
begin
//#UC START# *4F4177910352_4DAEED140007_impl*
 CompilerAssert(false, 'Слово не может иметь входных параметров и кода для их инициализации', aContext);
//#UC END# *4F4177910352_4DAEED140007_impl*
end;//TtfwWord.CompileInParameterPopCodeFromString

procedure TtfwWord.DoAddCodePart(aWord: TtfwWord;
 const aCtx: TtfwContext;
 aSNI: TtfwSuppressNextImmediate);
//#UC START# *4DB6CB1703AD_4DAEED140007_var*
//#UC END# *4DB6CB1703AD_4DAEED140007_var*
begin
//#UC START# *4DB6CB1703AD_4DAEED140007_impl*
 CompilerAssert(false, 'Слово не может содержать кода', aCtx);
//#UC END# *4DB6CB1703AD_4DAEED140007_impl*
end;//TtfwWord.DoAddCodePart

function TtfwWord.IsCloseBracket: Boolean;
//#UC START# *52D6ABCB0026_4DAEED140007_var*
//#UC END# *52D6ABCB0026_4DAEED140007_var*
begin
//#UC START# *52D6ABCB0026_4DAEED140007_impl*
 Result := false;
//#UC END# *52D6ABCB0026_4DAEED140007_impl*
end;//TtfwWord.IsCloseBracket

function TtfwWord.GetEndBracket(const aContext: TtfwContext;
 aSilent: Boolean): RtfwWord;
//#UC START# *52D6B62E001B_4DAEED140007_var*
//#UC END# *52D6B62E001B_4DAEED140007_var*
begin
//#UC START# *52D6B62E001B_4DAEED140007_impl*
 Result := nil;
//#UC END# *52D6B62E001B_4DAEED140007_impl*
end;//TtfwWord.GetEndBracket

class function TtfwWord.NameForRegister: AnsiString;
//#UC START# *52D7B67501CE_4DAEED140007_var*
//#UC END# *52D7B67501CE_4DAEED140007_var*
begin
//#UC START# *52D7B67501CE_4DAEED140007_impl*
 Result := '';
//#UC END# *52D7B67501CE_4DAEED140007_impl*
end;//TtfwWord.NameForRegister

function TtfwWord.AcceptMedianBracket(aBracket: TtfwWord;
 var aCtx: TtfwContext): Boolean;
//#UC START# *52D7DC84019E_4DAEED140007_var*
//#UC END# *52D7DC84019E_4DAEED140007_var*
begin
//#UC START# *52D7DC84019E_4DAEED140007_impl*
 Result := false;
//#UC END# *52D7DC84019E_4DAEED140007_impl*
end;//TtfwWord.AcceptMedianBracket

function TtfwWord.GetAsCaller(const aCtx: TtfwContext): TtfwWord;
//#UC START# *52DFE48500BB_4DAEED140007_var*
//#UC END# *52DFE48500BB_4DAEED140007_var*
begin
//#UC START# *52DFE48500BB_4DAEED140007_impl*
 Result := aCtx.rCompiler;
(* CompilerAssert(aCtx.rWordDefiningNow = aCtx.rCompiler.GetWordCompilingNow, 'Компилируемое слово не совпадает с определяемым, а должно', aCtx);
 CompilerAssert(aCtx.rWordDefiningNow = Self, 'Текущее слово не совпадает с определяемым, а должно', aCtx);
 Result := Self;*)
//#UC END# *52DFE48500BB_4DAEED140007_impl*
end;//TtfwWord.GetAsCaller

function TtfwWord.IsRightParam(const aCtx: TtfwContext): Boolean;
//#UC START# *52E91D9D0024_4DAEED140007_var*
//#UC END# *52E91D9D0024_4DAEED140007_var*
begin
//#UC START# *52E91D9D0024_4DAEED140007_impl*
 Result := false;
//#UC END# *52E91D9D0024_4DAEED140007_impl*
end;//TtfwWord.IsRightParam

function TtfwWord.RightParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *52E9282B0271_4DAEED140007_var*
//#UC END# *52E9282B0271_4DAEED140007_var*
begin
//#UC START# *52E9282B0271_4DAEED140007_impl*
 Result := 0;
 //CompilerAssert(false, 'Слово не имеет параметров справа', aCtx);
//#UC END# *52E9282B0271_4DAEED140007_impl*
end;//TtfwWord.RightParamsCount

function TtfwWord.GetInParam(const aCtx: TtfwContext;
 anIndex: Integer): TtfwWord;
//#UC START# *52D5425A037F_4DAEED140007_var*
//#UC END# *52D5425A037F_4DAEED140007_var*
begin
//#UC START# *52D5425A037F_4DAEED140007_impl*
 Result := nil;
//#UC END# *52D5425A037F_4DAEED140007_impl*
end;//TtfwWord.GetInParam

procedure TtfwWord.SetResultTypeInfo(aValue: TtfwWordInfo;
 const aCtx: TtfwContext);
//#UC START# *52EA6A2C0111_4DAEED140007_var*
//#UC END# *52EA6A2C0111_4DAEED140007_var*
begin
//#UC START# *52EA6A2C0111_4DAEED140007_impl*
 CompilerAssert(aValue.EQwm([]) AND aValue.ValueTypes.Empty,
                'Непустой список модификаторов в: ' + ClassName, aCtx);
//#UC END# *52EA6A2C0111_4DAEED140007_impl*
end;//TtfwWord.SetResultTypeInfo

function TtfwWord.IsLeftWordRefParam(const aCtx: TtfwContext): Boolean;
//#UC START# *53E389100169_4DAEED140007_var*
//#UC END# *53E389100169_4DAEED140007_var*
begin
//#UC START# *53E389100169_4DAEED140007_impl*
 Result := false;
//#UC END# *53E389100169_4DAEED140007_impl*
end;//TtfwWord.IsLeftWordRefParam

class procedure TtfwWord.RegisterClass;
//#UC START# *53E46C0A033C_4DAEED140007_var*
//#UC END# *53E46C0A033C_4DAEED140007_var*
begin
//#UC START# *53E46C0A033C_4DAEED140007_impl*
 TtfwClassRef.Register(Self);
//#UC END# *53E46C0A033C_4DAEED140007_impl*
end;//TtfwWord.RegisterClass

function TtfwWord.LeftWordRefParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *53E4914101D2_4DAEED140007_var*
//#UC END# *53E4914101D2_4DAEED140007_var*
begin
//#UC START# *53E4914101D2_4DAEED140007_impl*
 Result := 0;
//#UC END# *53E4914101D2_4DAEED140007_impl*
end;//TtfwWord.LeftWordRefParamsCount

procedure TtfwWord.AddLeftWordRefValue(const aCtx: TtfwContext;
 aValue: TtfwWord);
//#UC START# *53E49B2F01E4_4DAEED140007_var*
//#UC END# *53E49B2F01E4_4DAEED140007_var*
begin
//#UC START# *53E49B2F01E4_4DAEED140007_impl*
 CompilerAssert(false, 'Слово не может принимать параметры слева по ссылке', aCtx);
//#UC END# *53E49B2F01E4_4DAEED140007_impl*
end;//TtfwWord.AddLeftWordRefValue

function TtfwWord.GetLeftWordRefValue(const aCtx: TtfwContext;
 anIndex: Integer): TtfwWord;
//#UC START# *53E4A3C100AB_4DAEED140007_var*
//#UC END# *53E4A3C100AB_4DAEED140007_var*
begin
//#UC START# *53E4A3C100AB_4DAEED140007_impl*
 Result := nil;
 CompilerAssert(false, 'Нету значений для левых параметров по ссылке', aCtx);
//#UC END# *53E4A3C100AB_4DAEED140007_impl*
end;//TtfwWord.GetLeftWordRefValue

function TtfwWord.LeftWordRefValuesCount(const aCtx: TtfwContext): Integer;
//#UC START# *53E4A96A0085_4DAEED140007_var*
//#UC END# *53E4A96A0085_4DAEED140007_var*
begin
//#UC START# *53E4A96A0085_4DAEED140007_impl*
 Result := 0;
//#UC END# *53E4A96A0085_4DAEED140007_impl*
end;//TtfwWord.LeftWordRefValuesCount

procedure TtfwWord.RunnerError(const aMessage: AnsiString;
 const aContext: TtfwContext);
//#UC START# *551271AF0112_4DAEED140007_var*
//#UC END# *551271AF0112_4DAEED140007_var*
begin
//#UC START# *551271AF0112_4DAEED140007_impl*
 RunnerAssert(false, aMessage, aContext);
//#UC END# *551271AF0112_4DAEED140007_impl*
end;//TtfwWord.RunnerError

function TtfwWord.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_4DAEED140007_var*
//#UC END# *551544E2001A_4DAEED140007_var*
begin
//#UC START# *551544E2001A_4DAEED140007_impl*
 Result := nil;
//#UC END# *551544E2001A_4DAEED140007_impl*
end;//TtfwWord.GetResultTypeInfo

procedure TtfwWord.BadValueType(aType: TtfwValueType;
 const aCtx: TtfwContext);
//#UC START# *551A8FD70119_4DAEED140007_var*
//#UC END# *551A8FD70119_4DAEED140007_var*
begin
//#UC START# *551A8FD70119_4DAEED140007_impl*
 RunnerError('Неверный тип значения: ' + GetEnumName(TypeInfo(TtfwValueType), Ord(aType)), aCtx);
//#UC END# *551A8FD70119_4DAEED140007_impl*
end;//TtfwWord.BadValueType

function TtfwWord.GetRightParam(const aCtx: TtfwContext;
 anIndex: Integer): TtfwWord;
//#UC START# *55769895035B_4DAEED140007_var*
//#UC END# *55769895035B_4DAEED140007_var*
begin
//#UC START# *55769895035B_4DAEED140007_impl*
 Result := nil;
//#UC END# *55769895035B_4DAEED140007_impl*
end;//TtfwWord.GetRightParam

function TtfwWord.GetResultVar(const aCtx: TtfwContext): TtfwWord;
//#UC START# *558D1A4C0082_4DAEED140007_var*
//#UC END# *558D1A4C0082_4DAEED140007_var*
begin
//#UC START# *558D1A4C0082_4DAEED140007_impl*
 Result := nil;
 RunnerError('Слово не имеет возвращаемого значения', aCtx);
//#UC END# *558D1A4C0082_4DAEED140007_impl*
end;//TtfwWord.GetResultVar

constructor TtfwWord.Create;
//#UC START# *558D4AC70295_4DAEED140007_var*
//#UC END# *558D4AC70295_4DAEED140007_var*
begin
//#UC START# *558D4AC70295_4DAEED140007_impl*
 inherited;
//#UC END# *558D4AC70295_4DAEED140007_impl*
end;//TtfwWord.Create

function TtfwWord.GetRef(const aCtx: TtfwContext): TtfwWord;
//#UC START# *558D2BCA0324_4DAEED140007_var*
//#UC END# *558D2BCA0324_4DAEED140007_var*
begin
//#UC START# *558D2BCA0324_4DAEED140007_impl*
 Result := Self;
//#UC END# *558D2BCA0324_4DAEED140007_impl*
end;//TtfwWord.GetRef

function TtfwWord.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_4DAEED140007_var*
//#UC END# *559687E6025A_4DAEED140007_var*
begin
//#UC START# *559687E6025A_4DAEED140007_impl*
 Result := 0;
//#UC END# *559687E6025A_4DAEED140007_impl*
end;//TtfwWord.GetAllParamsCount

function TtfwWord.CanClearInRecursiveCalls: Boolean;
//#UC START# *559A470F0288_4DAEED140007_var*
//#UC END# *559A470F0288_4DAEED140007_var*
begin
//#UC START# *559A470F0288_4DAEED140007_impl*
 Result := false;
//#UC END# *559A470F0288_4DAEED140007_impl*
end;//TtfwWord.CanClearInRecursiveCalls

function TtfwWord.IsInParam: Boolean;
//#UC START# *559A4C5801D8_4DAEED140007_var*
//#UC END# *559A4C5801D8_4DAEED140007_var*
begin
//#UC START# *559A4C5801D8_4DAEED140007_impl*
 Result := false;
//#UC END# *559A4C5801D8_4DAEED140007_impl*
end;//TtfwWord.IsInParam

procedure TtfwWord.InitValue(const aCtx: TtfwContext);
//#UC START# *55A5244400BD_4DAEED140007_var*
//#UC END# *55A5244400BD_4DAEED140007_var*
begin
//#UC START# *55A5244400BD_4DAEED140007_impl*
 Self.SetValuePrim(Self.ResultTypeInfo[aCtx].ValueTypes.DefaultValue, aCtx);
//#UC END# *55A5244400BD_4DAEED140007_impl*
end;//TtfwWord.InitValue

function TtfwWord.GetNewWordDefinitor: TtfwWord;
//#UC START# *52D56341033B_4DAEED140007_var*
//#UC END# *52D56341033B_4DAEED140007_var*
begin
//#UC START# *52D56341033B_4DAEED140007_impl*
 Result := nil;
//#UC END# *52D56341033B_4DAEED140007_impl*
end;//TtfwWord.GetNewWordDefinitor

function TtfwWord.GetKeywordFinder(const aCtx: TtfwContext): TtfwWord;
//#UC START# *52D5637A031E_4DAEED140007_var*
//#UC END# *52D5637A031E_4DAEED140007_var*
begin
//#UC START# *52D5637A031E_4DAEED140007_impl*
 Result := nil;
//#UC END# *52D5637A031E_4DAEED140007_impl*
end;//TtfwWord.GetKeywordFinder

procedure TtfwWord.DoCompileInParameterPopCode(const aContext: TtfwContext;
 aParameterToPop: TtfwWord;
 aCheckCode: Boolean);
//#UC START# *52D56A980103_4DAEED140007_var*
//#UC END# *52D56A980103_4DAEED140007_var*
begin
//#UC START# *52D56A980103_4DAEED140007_impl*
 CompilerAssert(false, 'Слово не может иметь входные параметры', aContext);
//#UC END# *52D56A980103_4DAEED140007_impl*
end;//TtfwWord.DoCompileInParameterPopCode

function TtfwWord.DoCheckWord(const aName: Il3CString): TtfwKeyWord;
//#UC START# *55A7D34102A0_4DAEED140007_var*

 function locName : AnsiString;
 begin
  if (f_Key <> nil) then
   Result := f_Key.AsString
  else
   Result := '';
 end;

//#UC END# *55A7D34102A0_4DAEED140007_var*
begin
//#UC START# *55A7D34102A0_4DAEED140007_impl*
 Result := nil;
 Assert(false, 'Слово ' + locName + ' не может иметь вложенные слова');
//#UC END# *55A7D34102A0_4DAEED140007_impl*
end;//TtfwWord.DoCheckWord

function TtfwWord.GetKeywordByName(const aName: Il3CString): Tl3PrimString;
//#UC START# *55ACE5210310_4DAEED140007_var*
//#UC END# *55ACE5210310_4DAEED140007_var*
begin
//#UC START# *55ACE5210310_4DAEED140007_impl*
 Result := nil;
//#UC END# *55ACE5210310_4DAEED140007_impl*
end;//TtfwWord.GetKeywordByName

function TtfwWord.GetParentFinder: TtfwWord;
//#UC START# *55ACF0F5025D_4DAEED140007_var*
//#UC END# *55ACF0F5025D_4DAEED140007_var*
begin
//#UC START# *55ACF0F5025D_4DAEED140007_impl*
 Result := nil;
//#UC END# *55ACF0F5025D_4DAEED140007_impl*
end;//TtfwWord.GetParentFinder

function TtfwWord.WordName: Il3CString;
//#UC START# *55AFD7DA0258_4DAEED140007_var*
//#UC END# *55AFD7DA0258_4DAEED140007_var*
begin
//#UC START# *55AFD7DA0258_4DAEED140007_impl*
 if (f_Key = nil) then
  Result := TtfwCStringFactory.C(ClassName)
 else
  Result := f_Key.AsCStr;
//#UC END# *55AFD7DA0258_4DAEED140007_impl*
end;//TtfwWord.WordName

function TtfwWord.IsForHelp: Boolean;
//#UC START# *55C399C9009B_4DAEED140007_var*
//#UC END# *55C399C9009B_4DAEED140007_var*
begin
//#UC START# *55C399C9009B_4DAEED140007_impl*
 Result := true;
//#UC END# *55C399C9009B_4DAEED140007_impl*
end;//TtfwWord.IsForHelp

function TtfwWord.MakeRefForCompile(const aCtx: TtfwContext;
 aSNI: TtfwSuppressNextImmediate): TtfwWord;
//#UC START# *55CB5B8C004E_4DAEED140007_var*
//#UC END# *55CB5B8C004E_4DAEED140007_var*
begin
//#UC START# *55CB5B8C004E_4DAEED140007_impl*
 Result := Use;
//#UC END# *55CB5B8C004E_4DAEED140007_impl*
end;//TtfwWord.MakeRefForCompile

procedure TtfwWord.SetValue(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *56096688024A_4DAEED140007_var*

 function cBadModifier: String;
 begin//cBadModifier
  if (aValue.rType = tfw_vtObj) AND (aValue.AsObject <> nil) then
   Result := 'Неверный тип значения: ' + GetEnumName(TypeInfo(TtfwValueType), Ord(aValue.rType)) + ' ' + aValue.AsObject.ClassName + ' для типа ' + l3Str(pm_GetResultTypeInfo(aCtx).TypeName)
  else
   Result := 'Неверный тип значения: ' + GetEnumName(TypeInfo(TtfwValueType), Ord(aValue.rType)) + ' для типа ' + l3Str(pm_GetResultTypeInfo(aCtx).TypeName);
 end;//cBadModifier

//#UC END# *56096688024A_4DAEED140007_var*
begin
//#UC START# *56096688024A_4DAEED140007_impl*
 //if aNeedCheckType then
 begin
  if not pm_GetResultTypeInfo(aCtx).AcceptsValue(aValue) then
  begin
(*   if (aValue.rType = tfw_vtWStr) then
    if pm_GetResultTypeInfo(aCtx).Has(tfw_vtStr) then
    begin
     f_Value := TtfwCStringFactoryEx.ViewOf(aValue.AsWString);
     Exit;
    end;//pm_GetResultTypeInfo(aCtx).Has(tfw_vtStr)*)
    RunnerError(cBadModifier, aCtx);
  end;//not pm_GetResultTypeInfo(aCtx).AcceptsValue(aValue)
 end;//aNeedCheckType
 SetValuePrim(aValue, aCtx);
//#UC END# *56096688024A_4DAEED140007_impl*
end;//TtfwWord.SetValue

function TtfwWord.IsCompleted(const aCtx: TtfwContext): Boolean;
//#UC START# *5617DBA00377_4DAEED140007_var*
//#UC END# *5617DBA00377_4DAEED140007_var*
begin
//#UC START# *5617DBA00377_4DAEED140007_impl*
 Result := (GetAllParamsCount(aCtx) - LeftWordRefParamsCount(aCtx) - RightParamsCount(aCtx) = 0);
//#UC END# *5617DBA00377_4DAEED140007_impl*
end;//TtfwWord.IsCompleted

function TtfwWord.IsImmediate(const aCtx: TtfwContext): Boolean;
//#UC START# *4DB6D7F70155_4DAEED140007_var*
//#UC END# *4DB6D7F70155_4DAEED140007_var*
begin
//#UC START# *4DB6D7F70155_4DAEED140007_impl*
 Result := false;
//#UC END# *4DB6D7F70155_4DAEED140007_impl*
end;//TtfwWord.IsImmediate

procedure TtfwWord.CompilerAssert(aCondition: Boolean;
 const aMessage: AnsiString;
 const aContext: TtfwContext);
//#UC START# *4EF4A312023F_4DAEED140007_var*

 function locName : AnsiString;
 begin
  if (f_Key <> nil) then
   Result := f_Key.AsString
  else
   Result := '';
 end;

 function locProducer: AnsiString;
 begin
  if (Self.WordProducer = nil) then
   Result := ''
  else
   Result := ' Producer: ' + Self.WordProducer.Key.AsString;
 end;

 function locParent: AnsiString;
 begin
  if (Self.ParentWord = nil) then
   Result := ''
  else
   Result := ' Parent: ' + Self.ParentWord.Key.AsString;
 end;

//#UC END# *4EF4A312023F_4DAEED140007_var*
begin
//#UC START# *4EF4A312023F_4DAEED140007_impl*
 if not aCondition then
 begin
  if (aContext.rParser <> nil) then
   EtfwCompiler.IsTrue(aCondition,
         Format('Ошибка компиляции: "%s". Тип токена: %s : %s в строке %d. Файл: %s. Класс: %s. Слово: %s%s%s',
                [aMessage,
                 GetEnumName(TypeInfo(Tl3TokenType),
                             Ord(aContext.rParser.TokenType)),
                 l3Str(aContext.rParser.TokenLongString),
                 aContext.rParser.SourceLine,
                 aContext.rParser.FileName,
                 ClassName,
                 locName,
                 locProducer,
                 locParent
                ]))
  else
   EtfwRunner.IsTrue(aCondition,
         Format('Ошибка выполнения: "%s". Главный файл: %s. Класс: %s. Слово: %s%s%s',
                [aMessage,
                 aContext.rStreamFactory.FileName,
                 ClassName,
                 locName,
                 locProducer,
                 locParent
                ]));
 end;//not aCondition              
//#UC END# *4EF4A312023F_4DAEED140007_impl*
end;//TtfwWord.CompilerAssert

function TtfwWord.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_4DAEED140007_var*
//#UC END# *5617F4D00243_4DAEED140007_var*
begin
//#UC START# *5617F4D00243_4DAEED140007_impl*
 Result := nil;
//#UC END# *5617F4D00243_4DAEED140007_impl*
end;//TtfwWord.ParamsTypes

class function TtfwWord.OpenTypesToTypes(const aTypes: array of PTypeInfo): PTypeInfoArray;
//#UC START# *5617F4EE00E7_4DAEED140007_var*
var
 l_Index : Integer; 
//#UC END# *5617F4EE00E7_4DAEED140007_var*
begin
//#UC START# *5617F4EE00E7_4DAEED140007_impl*
 SetLength(Result, Length(aTypes));
 for l_Index := 0 to Length(aTypes) - 1 do
  Result[l_Index] := aTypes[l_Index];
//#UC END# *5617F4EE00E7_4DAEED140007_impl*
end;//TtfwWord.OpenTypesToTypes

function TtfwWord.ParamsInfos: TtfwWordInfoArray;
//#UC START# *5619162C0102_4DAEED140007_var*
var
 l_Types : PTypeInfoArray;
 l_Index : Integer;
//#UC END# *5619162C0102_4DAEED140007_var*
begin
//#UC START# *5619162C0102_4DAEED140007_impl*
 l_Types := ParamsTypes;
 SetLength(Result, Length(l_Types));
 for l_Index := 0 to Length(l_Types) - 1 do
  Result[l_Index] := ttfwWordInfo.Make(l_Types[l_Index]);
//#UC END# *5619162C0102_4DAEED140007_impl*
end;//TtfwWord.ParamsInfos

function TtfwWord.IsGlobalVar: Boolean;
//#UC START# *56456DDD037D_4DAEED140007_var*
//#UC END# *56456DDD037D_4DAEED140007_var*
begin
//#UC START# *56456DDD037D_4DAEED140007_impl*
 Result := false;
//#UC END# *56456DDD037D_4DAEED140007_impl*
end;//TtfwWord.IsGlobalVar

procedure TtfwWord.SetParent(aParent: TtfwWord);
//#UC START# *5673E71002C8_4DAEED140007_var*
//#UC END# *5673E71002C8_4DAEED140007_var*
begin
//#UC START# *5673E71002C8_4DAEED140007_impl*
 // - ничего не делаем
//#UC END# *5673E71002C8_4DAEED140007_impl*
end;//TtfwWord.SetParent

procedure TtfwWord.AddCodePart(aWord: TtfwWord;
 const aCtx: TtfwContext;
 aSNI: TtfwSuppressNextImmediate);
 {* Добавляет скомпилированный код к текущему компилируемуму слову }
//#UC START# *4DB6E3090290_4DAEED140007_var*
//#UC END# *4DB6E3090290_4DAEED140007_var*
begin
//#UC START# *4DB6E3090290_4DAEED140007_impl*
 DoAddCodePart(aWord, aCtx, aSNI);
//#UC END# *4DB6E3090290_4DAEED140007_impl*
end;//TtfwWord.AddCodePart

procedure TtfwWord.CompileInParameterPopCode(const aContext: TtfwContext;
 aParameterToPop: TtfwWord);
 {* Компилирует код извлечения входного параметра в код компилируемого слова }
//#UC START# *4F416F900048_4DAEED140007_var*
//#UC END# *4F416F900048_4DAEED140007_var*
begin
//#UC START# *4F416F900048_4DAEED140007_impl*
 DoCompileInParameterPopCode(aContext, aParameterToPop, true);
//#UC END# *4F416F900048_4DAEED140007_impl*
end;//TtfwWord.CompileInParameterPopCode

function TtfwWord.CheckWord(const aName: Il3CString): TtfwKeyWord;
//#UC START# *4F46588B021E_4DAEED140007_var*
//#UC END# *4F46588B021E_4DAEED140007_var*
begin
//#UC START# *4F46588B021E_4DAEED140007_impl*
 Result := DoCheckWord(aName);
//#UC END# *4F46588B021E_4DAEED140007_impl*
end;//TtfwWord.CheckWord

function TtfwWord.DefineInParameter(const aCtx: TtfwContext;
 const aParamName: Il3CString;
 aStereo: TtfwWord;
 aTypeInfo: TtfwWordInfo): TtfwWord;
//#UC START# *559D25E90141_4DAEED140007_var*
//#UC END# *559D25E90141_4DAEED140007_var*
begin
//#UC START# *559D25E90141_4DAEED140007_impl*
 Result := DoDefineInParameter(aCtx, aParamName, aStereo, aTypeInfo);
//#UC END# *559D25E90141_4DAEED140007_impl*
end;//TtfwWord.DefineInParameter

function TtfwWord.NewWordDefinitor: TtfwWord;
//#UC START# *55A7C9680222_4DAEED140007_var*
//#UC END# *55A7C9680222_4DAEED140007_var*
begin
//#UC START# *55A7C9680222_4DAEED140007_impl*
 Result := GetNewWordDefinitor;
//#UC END# *55A7C9680222_4DAEED140007_impl*
end;//TtfwWord.NewWordDefinitor

function TtfwWord.KeywordFinder(const aCtx: TtfwContext): TtfwWord;
//#UC START# *55A7C9EC0295_4DAEED140007_var*
//#UC END# *55A7C9EC0295_4DAEED140007_var*
begin
//#UC START# *55A7C9EC0295_4DAEED140007_impl*
 Result := GetKeywordFinder(aCtx);
//#UC END# *55A7C9EC0295_4DAEED140007_impl*
end;//TtfwWord.KeywordFinder

function TtfwWord.KeywordByName(const aName: Il3CString): Tl3PrimString;
//#UC START# *55ACD5F10301_4DAEED140007_var*
//#UC END# *55ACD5F10301_4DAEED140007_var*
begin
//#UC START# *55ACD5F10301_4DAEED140007_impl*
 Result := GetKeywordByName(aName);
//#UC END# *55ACD5F10301_4DAEED140007_impl*
end;//TtfwWord.KeywordByName

function TtfwWord.ParentFinder: TtfwWord;
//#UC START# *55ACF0CF0320_4DAEED140007_var*
//#UC END# *55ACF0CF0320_4DAEED140007_var*
begin
//#UC START# *55ACF0CF0320_4DAEED140007_impl*
 Result := GetParentFinder;
//#UC END# *55ACF0CF0320_4DAEED140007_impl*
end;//TtfwWord.ParentFinder

procedure TtfwWord.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4DAEED140007_var*
//#UC END# *479731C50290_4DAEED140007_var*
begin
//#UC START# *479731C50290_4DAEED140007_impl*
 f_Key := nil;
 FreeAndNil(f_Redefines);
 inherited;
//#UC END# *479731C50290_4DAEED140007_impl*
end;//TtfwWord.Cleanup

{$If NOT Defined(DesignTimeLibrary)}
class function TtfwWord.IsCacheable: Boolean;
 {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
//#UC START# *47A6FEE600FC_4DAEED140007_var*
//#UC END# *47A6FEE600FC_4DAEED140007_var*
begin
//#UC START# *47A6FEE600FC_4DAEED140007_impl*
 Result := true;
//#UC END# *47A6FEE600FC_4DAEED140007_impl*
end;//TtfwWord.IsCacheable
{$IfEnd} // NOT Defined(DesignTimeLibrary)

function TtfwWord.SourcePoint: TtfwSourcePoint;
//#UC START# *556317DE02B5_4DAEED140007_var*
//#UC END# *556317DE02B5_4DAEED140007_var*
begin
//#UC START# *556317DE02B5_4DAEED140007_impl*
 Result := TtfwSourcePoint_E;
 if (f_Key <> nil) then
  Result.rName := f_Key.AsCStr;
 if (Self.WordProducer <> nil) then
  if (Self.WordProducer.Key <> nil) then
   Result.rProducerName := Self.WordProducer.Key.AsCStr;
//#UC END# *556317DE02B5_4DAEED140007_impl*
end;//TtfwWord.SourcePoint

constructor TtfwKeyWord.Create(aDictionary: TtfwDictionaryPrim;
 const aKeyword: AnsiString;
 aWord: TtfwWord);
//#UC START# *4DB578450319_4DAEF23D00EE_var*
//#UC END# *4DB578450319_4DAEF23D00EE_var*
begin
//#UC START# *4DB578450319_4DAEF23D00EE_impl*
 Create(aDictionary, TtfwCStringFactory.C(aKeyword));
 EtfwCheck.IsTrue(f_Word = nil, 'Слово уже присвоено');
 f_Word := aWord.Use;
 if (f_Word <> nil) then
  f_Word.f_Key := Self;
//#UC END# *4DB578450319_4DAEF23D00EE_impl*
end;//TtfwKeyWord.Create

constructor TtfwKeyWord.Create(aDictionary: TtfwDictionaryPrim;
 const aKeyword: Tl3WString);
//#UC START# *4F46550C03E5_4DAEF23D00EE_var*
//#UC END# *4F46550C03E5_4DAEF23D00EE_var*
begin
//#UC START# *4F46550C03E5_4DAEF23D00EE_impl*
 Create(aDictionary, TtfwCStringFactory.C(aKeyword));
//#UC END# *4F46550C03E5_4DAEF23D00EE_impl*
end;//TtfwKeyWord.Create

constructor TtfwKeyWord.Create(aDictionary: TtfwDictionaryPrim;
 const aKeyword: Il3CString);
//#UC START# *4F4658D00140_4DAEF23D00EE_var*
//#UC END# *4F4658D00140_4DAEF23D00EE_var*
begin
//#UC START# *4F4658D00140_4DAEF23D00EE_impl*
 inherited Create(aKeyword);
 f_Dictionary := aDictionary;
//#UC END# *4F4658D00140_4DAEF23D00EE_impl*
end;//TtfwKeyWord.Create

procedure TtfwKeyWord.ChangeDictionary(aValue: TtfwDictionaryPrim);
//#UC START# *55B1FDAD0118_4DAEF23D00EE_var*
//#UC END# *55B1FDAD0118_4DAEF23D00EE_var*
begin
//#UC START# *55B1FDAD0118_4DAEF23D00EE_impl*
 f_Dictionary := aValue;
//#UC END# *55B1FDAD0118_4DAEF23D00EE_impl*
end;//TtfwKeyWord.ChangeDictionary

procedure TtfwKeyWord.SetWord(const aCtx: TtfwContext;
 aWord: TtfwWord);
//#UC START# *55B794CC0388_4DAEF23D00EE_var*
//#UC END# *55B794CC0388_4DAEF23D00EE_var*
begin
//#UC START# *55B794CC0388_4DAEF23D00EE_impl*
 if (aWord <> f_Word) then
 begin
  if (aWord <> nil) AND (f_Word <> nil) AND f_Word.IsForwardDeclaration then
  begin
   aWord.CompilerAssert(f_Word <> aWord, 'Присваиваем самому себе', aCtx);
   aWord.CompilerAssert(TkwForwardDeclaration(f_Word).RealWord = nil,
          Format('Предварительное определение слова %s уже было завершено',
                 [Self.AsString]), aCtx
          );
   TkwForwardDeclaration(f_Word).RealWord := aWord;
  end//(f_Word <> nil) AND f_Word.IsForwardDeclaration
  else
  begin
   if (f_Word <> nil) then
    if (f_Word.f_Key = Self) then
    begin
     if (aWord <> nil) AND aWord.ResultTypeInfo[aCtx].Has(tfw_wmRedefinition) then
      aWord.Redefines := f_Word
     else
      f_Word.f_Key := nil;
    end;//f_Word.f_Key = Self
   aWord.SetRefTo(f_Word);
   if (f_Word <> nil) then
    f_Word.f_Key := Self;
  end//(f_Word <> nil) AND f_Word.IsForwardDeclaration
 end;//aWord <> f_Word
//#UC END# *55B794CC0388_4DAEF23D00EE_impl*
end;//TtfwKeyWord.SetWord

procedure TtfwKeyWord.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4DAEF23D00EE_var*
//#UC END# *479731C50290_4DAEF23D00EE_var*
begin
//#UC START# *479731C50290_4DAEF23D00EE_impl*
 if (f_Word <> nil) then
  if (f_Word.f_Key = Self) then
   f_Word.f_Key := nil;
 FreeAndNil(f_Word);
 inherited;
//#UC END# *479731C50290_4DAEF23D00EE_impl*
end;//TtfwKeyWord.Cleanup

function TtfwKeyWord.GetAsPCharLen: Tl3WString;
//#UC START# *47A869BB02DE_4DAEF23D00EE_var*
//#UC END# *47A869BB02DE_4DAEF23D00EE_var*
begin
//#UC START# *47A869BB02DE_4DAEF23D00EE_impl*
 Result := l3PCharLen(AsCStr);
//#UC END# *47A869BB02DE_4DAEF23D00EE_impl*
end;//TtfwKeyWord.GetAsPCharLen

procedure TtfwKeyWord.DoSetAsPCharLen(const Value: Tl3PCharLen);
//#UC START# *47A869D10074_4DAEF23D00EE_var*
//#UC END# *47A869D10074_4DAEF23D00EE_var*
begin
//#UC START# *47A869D10074_4DAEF23D00EE_impl*
 EtfwCheck.Fail('Нельзя править значение ключевого слова');
//#UC END# *47A869D10074_4DAEF23D00EE_impl*
end;//TtfwKeyWord.DoSetAsPCharLen

class function EtfwBreak.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_EtfwBreak <> nil;
end;//EtfwBreak.Exists

class function EtfwBreak.Instance: EtfwBreak;
 {* Метод получения экземпляра синглетона EtfwBreak }
begin
 if (g_EtfwBreak = nil) then
 begin
  l3System.AddExitProc(EtfwBreakFree);
  g_EtfwBreak := Create;
 end;
 Result := g_EtfwBreak;
end;//EtfwBreak.Instance

constructor TtfwWordInfoF.Create(const aModifiers: TtfwWordInfoRec);
//#UC START# *559E663E0307_559D51430285_var*
//#UC END# *559E663E0307_559D51430285_var*
begin
//#UC START# *559E663E0307_559D51430285_impl*
 inherited Create;
 f_WordInfo := aModifiers;
(* if f_WordInfo.Has(tfw_wmRightWordRef) OR
    f_WordInfo.Has(tfw_wmLeftWordRef) then
  f_WordInfo.rTypeModifiers := TtfwValueTypes.Make(TypeInfo(TtfwWord));
  // - незачем тут ничего складывать*)
//#UC END# *559E663E0307_559D51430285_impl*
end;//TtfwWordInfoF.Create

function TtfwWordInfoF.IncludeModifier(aModifier: TtfwWordModifier): TtfwWordInfo;
//#UC START# *559D50760320_559D51430285_var*
//#UC END# *559D50760320_559D51430285_var*
begin
//#UC START# *559D50760320_559D51430285_impl*
 if f_WordInfo.Has(aModifier) then
  Result := Self
 else
  Result := Make(TtfwWordInfoRec_C(f_WordInfo.rTypeModifiers, f_WordInfo.rModifiers + [aModifier], f_WordInfo.rAccessType, f_WordInfo.rLinkType));
//#UC END# *559D50760320_559D51430285_impl*
end;//TtfwWordInfoF.IncludeModifier

function TtfwWordInfoF.Empty: Boolean;
//#UC START# *559D50D40233_559D51430285_var*
//#UC END# *559D50D40233_559D51430285_var*
begin
//#UC START# *559D50D40233_559D51430285_impl*
 Result := f_WordInfo.Empty;
//#UC END# *559D50D40233_559D51430285_impl*
end;//TtfwWordInfoF.Empty

function TtfwWordInfoF.Has(aModifier: TtfwWordModifier): Boolean;
//#UC START# *559D50EA02F1_559D51430285_var*
//#UC END# *559D50EA02F1_559D51430285_var*
begin
//#UC START# *559D50EA02F1_559D51430285_impl*
 Result := f_WordInfo.Has(aModifier);
//#UC END# *559D50EA02F1_559D51430285_impl*
end;//TtfwWordInfoF.Has

function TtfwWordInfoF.Clone: TtfwWordInfo;
//#UC START# *559D62F40210_559D51430285_var*
//#UC END# *559D62F40210_559D51430285_var*
begin
//#UC START# *559D62F40210_559D51430285_impl*
 Result := Self;
//#UC END# *559D62F40210_559D51430285_impl*
end;//TtfwWordInfoF.Clone

function TtfwWordInfoF.pRec: PtfwWordInfoRec;
//#UC START# *55B2543C0304_559D51430285_var*
//#UC END# *55B2543C0304_559D51430285_var*
begin
//#UC START# *55B2543C0304_559D51430285_impl*
 Result := @f_WordInfo;
//#UC END# *55B2543C0304_559D51430285_impl*
end;//TtfwWordInfoF.pRec

function TtfwWordInfoF.IncludeTypeModifier(aType: TtfwValueType): TtfwWordInfo;
//#UC START# *55B264D6035A_559D51430285_var*
//#UC END# *55B264D6035A_559D51430285_var*
begin
//#UC START# *55B264D6035A_559D51430285_impl*
 if f_WordInfo.Has(aType) then
  Result := Self
 else
  Result := Make(TtfwWordInfoRec_C(ValueTypes.Add(TtfwTypeInfo_C(aType)), f_WordInfo.rModifiers, f_WordInfo.rAccessType, f_WordInfo.rLinkType));
//#UC END# *55B264D6035A_559D51430285_impl*
end;//TtfwWordInfoF.IncludeTypeModifier

function TtfwWordInfoF.Has(aType: TtfwValueType): Boolean;
//#UC START# *55B2651800DB_559D51430285_var*
//#UC END# *55B2651800DB_559D51430285_var*
begin
//#UC START# *55B2651800DB_559D51430285_impl*
 Result := f_WordInfo.Has(aType);
//#UC END# *55B2651800DB_559D51430285_impl*
end;//TtfwWordInfoF.Has

function TtfwWordInfoF.AcceptsValue(const aValue: TtfwStackValue): Boolean;
//#UC START# *55B763C701FC_559D51430285_var*
//#UC END# *55B763C701FC_559D51430285_var*
begin
//#UC START# *55B763C701FC_559D51430285_impl*
 Result := f_WordInfo.rTypeModifiers.AcceptsValue(aValue);
 {$IfNDef seTypeCheck}
 if Result then
  if Self.Has(tfw_wmRightWordRef) OR
     Self.Has(tfw_wmLeftWordRef) then
   if (aValue.rType <> tfw_vtNil) then
    Result := (aValue.AsObject Is TtfwWord);
 {$EndIf  seTypeCheck}   
//#UC END# *55B763C701FC_559D51430285_impl*
end;//TtfwWordInfoF.AcceptsValue

function TtfwWordInfoF.Has(anAccess: TtfwAccessType): Boolean;
//#UC START# *55BA4C6D024B_559D51430285_var*
//#UC END# *55BA4C6D024B_559D51430285_var*
begin
//#UC START# *55BA4C6D024B_559D51430285_impl*
 Result := f_WordInfo.Has(anAccess);
//#UC END# *55BA4C6D024B_559D51430285_impl*
end;//TtfwWordInfoF.Has

function TtfwWordInfoF.IncludeAccesType(anAccess: TtfwAccessType): TtfwWordInfo;
//#UC START# *55BA4CB60097_559D51430285_var*
//#UC END# *55BA4CB60097_559D51430285_var*
begin
//#UC START# *55BA4CB60097_559D51430285_impl*
 if f_WordInfo.Has(anAccess) then
  Result := Self
 else
  Result := Make(TtfwWordInfoRec_C(f_WordInfo.rTypeModifiers, f_WordInfo.rModifiers, anAccess, f_WordInfo.rLinkType));
//#UC END# *55BA4CB60097_559D51430285_impl*
end;//TtfwWordInfoF.IncludeAccesType

function TtfwWordInfoF.EQwm(aValue: TtfwWordModifiers): Boolean;
//#UC START# *55BBB0DC0384_559D51430285_var*
//#UC END# *55BBB0DC0384_559D51430285_var*
begin
//#UC START# *55BBB0DC0384_559D51430285_impl*
 Result := (f_WordInfo.rModifiers = aValue);
//#UC END# *55BBB0DC0384_559D51430285_impl*
end;//TtfwWordInfoF.EQwm

function TtfwWordInfoF.IncludeType(const aType: TtfwTypeInfo): TtfwWordInfo;
//#UC START# *55BBB8FE02C0_559D51430285_var*
//#UC END# *55BBB8FE02C0_559D51430285_var*
begin
//#UC START# *55BBB8FE02C0_559D51430285_impl*
 Result := Make(TtfwWordInfoRec_C(ValueTypes.Add(aType), f_WordInfo.rModifiers, f_WordInfo.rAccessType, f_WordInfo.rLinkType));
//#UC END# *55BBB8FE02C0_559D51430285_impl*
end;//TtfwWordInfoF.IncludeType

function TtfwWordInfoF.TypeName: Il3CString;
//#UC START# *55BF05E70219_559D51430285_var*
//#UC END# *55BF05E70219_559D51430285_var*
begin
//#UC START# *55BF05E70219_559D51430285_impl*
 Result := f_WordInfo.TypeName;
//#UC END# *55BF05E70219_559D51430285_impl*
end;//TtfwWordInfoF.TypeName

function TtfwWordInfoF.ValueTypes: TtfwValueTypes;
//#UC START# *55C0D6C20094_559D51430285_var*
//#UC END# *55C0D6C20094_559D51430285_var*
begin
//#UC START# *55C0D6C20094_559D51430285_impl*
 Result := f_WordInfo.rTypeModifiers;
//#UC END# *55C0D6C20094_559D51430285_impl*
end;//TtfwWordInfoF.ValueTypes

function TtfwWordInfoF.IncludeLinkType(aLinkType: TtfwLinkType): TtfwWordInfo;
//#UC START# *55C23CD603CC_559D51430285_var*
//#UC END# *55C23CD603CC_559D51430285_var*
begin
//#UC START# *55C23CD603CC_559D51430285_impl*
 if f_WordInfo.Has(aLinkType) then
  Result := Self
 else
  Result := Make(TtfwWordInfoRec_C(f_WordInfo.rTypeModifiers, f_WordInfo.rModifiers, f_WordInfo.rAccessType, aLinkType));
//#UC END# *55C23CD603CC_559D51430285_impl*
end;//TtfwWordInfoF.IncludeLinkType

function TtfwWordInfoF.Has(aLinkType: TtfwLinkType): Boolean;
//#UC START# *55C23DC202FE_559D51430285_var*
//#UC END# *55C23DC202FE_559D51430285_var*
begin
//#UC START# *55C23DC202FE_559D51430285_impl*
 Result := f_WordInfo.Has(aLinkType);
//#UC END# *55C23DC202FE_559D51430285_impl*
end;//TtfwWordInfoF.Has

function TtfwWordInfoF.LinkType: TtfwLinkType;
//#UC START# *55C34B8600C9_559D51430285_var*
//#UC END# *55C34B8600C9_559D51430285_var*
begin
//#UC START# *55C34B8600C9_559D51430285_impl*
 Result := f_WordInfo.rLinkType;
//#UC END# *55C34B8600C9_559D51430285_impl*
end;//TtfwWordInfoF.LinkType

function TtfwWordInfoF.AccessType: TtfwAccessType;
//#UC START# *55C34BC601FE_559D51430285_var*
//#UC END# *55C34BC601FE_559D51430285_var*
begin
//#UC START# *55C34BC601FE_559D51430285_impl*
 Result := f_WordInfo.rAccessType;
//#UC END# *55C34BC601FE_559D51430285_impl*
end;//TtfwWordInfoF.AccessType

function TtfwWordInfoF.Compare(anOther: TtfwWordInfo): Integer;
//#UC START# *55C356030225_559D51430285_var*
//#UC END# *55C356030225_559D51430285_var*
begin
//#UC START# *55C356030225_559D51430285_impl*
 Result := f_WordInfo.Compare(anOther.pRec^);
//#UC END# *55C356030225_559D51430285_impl*
end;//TtfwWordInfoF.Compare

function TtfwWordInfoF.Modifiers: TtfwWordModifiers;
//#UC START# *55C385AD025D_559D51430285_var*
//#UC END# *55C385AD025D_559D51430285_var*
begin
//#UC START# *55C385AD025D_559D51430285_impl*
 Result := f_WordInfo.rModifiers;
//#UC END# *55C385AD025D_559D51430285_impl*
end;//TtfwWordInfoF.Modifiers

function TtfwWordInfoF.ToString: Il3CString;
//#UC START# *55C385DE0038_559D51430285_var*

 function locCat(const aA: Il3CString; const aB: Il3CString): Il3CString;
 begin
  Result := TtfwCStringFactory.CatSep(aA, TtfwCStringFactory.C(' '), aB);
 end;

var
 l_TI : TtfwWordInfo;
//#UC END# *55C385DE0038_559D51430285_var*
begin
//#UC START# *55C385DE0038_559D51430285_impl*
 Result := nil;
 l_TI := Self;

 if l_TI.Has(tfw_wmImmediate) {OR (aWord.IsImmediate AND not aWord.IsCompiled)} then
  Result := locCat(Result, TtfwCStringFactory.C('IMMEDIATE'));

 if l_TI.Has(tfw_wmInline) then
  Result := locCat(Result, TtfwCStringFactory.C('INLINE'));

 if l_TI.Has(tfw_wmRedefinition) then
  Result := locCat(Result, TtfwCStringFactory.C('REDIFINITION'));

 if l_TI.Has(tfw_wmSummoned) then
  Result := locCat(Result, TtfwCStringFactory.C('SUMMONED'));

 if l_TI.Has(tfw_wmRealize) then
  Result := locCat(Result, TtfwCStringFactory.C('REALIZE'))
 else
 if l_TI.Has(tfw_wmOverride) then
  Result := locCat(Result, TtfwCStringFactory.C('OVERRIDE'));

 if l_TI.Has(tfw_atPrivate) then
  Result := locCat(Result, TtfwCStringFactory.C('PRIVATE'))
 else
 if l_TI.Has(tfw_atProtected) then
  Result := locCat(Result, TtfwCStringFactory.C('PROTECTED'));

 if l_TI.Has(tfw_wmAbstract) then
  Result := locCat(Result, TtfwCStringFactory.C('ABSTRACT'))
 else
 if l_TI.Has(tfw_wmFinal) then
  Result := locCat(Result, TtfwCStringFactory.C('FINAL'))
 else
 if l_TI.Has(tfw_wmVirtual) then
  Result := locCat(Result, TtfwCStringFactory.C('VIRTUAL'));

 if l_TI.Has(tfw_ltLink) then
  Result := locCat(Result, TtfwCStringFactory.C('LINK'))
 else
 if l_TI.Has(tfw_ltReference) then
  Result := locCat(Result, TtfwCStringFactory.C('REFERENCE'));

 if l_TI.Has(tfw_wmRightWordRef) then
 begin
  if l_TI.Has(tfw_wmTreatUnknownAsString) then
   Result := locCat(Result, TtfwCStringFactory.C('^L'))
  else
   Result := locCat(Result, TtfwCStringFactory.C('^'));
 end//aWord.IsRightParam(aCtx)
 else
 if l_TI.Has(tfw_wmTreatUnknownAsString) then
  Result := locCat(Result, TtfwCStringFactory.C('TreatUnknownAsString'));

 if l_TI.Has(tfw_wmLeftWordRef) then
  Result := locCat(Result, TtfwCStringFactory.C('^@'));

 if l_TI.Has(tfw_wmLeftWordRef) then
  Result := locCat(Result, nil)
 else
 if l_TI.Has(tfw_wmRightWordRef) then
  Result := locCat(Result, nil)
 else
  Result := locCat(Result, l_TI.TypeName);

 if l_TI.Has(tfw_wmCaller) then
  Result := locCat(Result, TtfwCStringFactory.C('CALLER'));
//#UC END# *55C385DE0038_559D51430285_impl*
end;//TtfwWordInfoF.ToString

{$If NOT Defined(DesignTimeLibrary)}
class function TtfwWordInfoF.IsCacheable: Boolean;
 {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
//#UC START# *47A6FEE600FC_559D51430285_var*
//#UC END# *47A6FEE600FC_559D51430285_var*
begin
//#UC START# *47A6FEE600FC_559D51430285_impl*
 Result := true;
//#UC END# *47A6FEE600FC_559D51430285_impl*
end;//TtfwWordInfoF.IsCacheable
{$IfEnd} // NOT Defined(DesignTimeLibrary)

class function TtfwWordInfoE.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TtfwWordInfoE <> nil;
end;//TtfwWordInfoE.Exists

function TtfwWordInfoE.IncludeModifier(aModifier: TtfwWordModifier): TtfwWordInfo;
//#UC START# *559D50760320_559D6D060382_var*
//#UC END# *559D50760320_559D6D060382_var*
begin
//#UC START# *559D50760320_559D6D060382_impl*
 Result := TtfwWordInfo.Make(nil, [aModifier], tfw_atNone, tfw_ltNone);
//#UC END# *559D50760320_559D6D060382_impl*
end;//TtfwWordInfoE.IncludeModifier

function TtfwWordInfoE.Empty: Boolean;
//#UC START# *559D50D40233_559D6D060382_var*
//#UC END# *559D50D40233_559D6D060382_var*
begin
//#UC START# *559D50D40233_559D6D060382_impl*
 Result := true;
//#UC END# *559D50D40233_559D6D060382_impl*
end;//TtfwWordInfoE.Empty

function TtfwWordInfoE.Has(aModifier: TtfwWordModifier): Boolean;
//#UC START# *559D50EA02F1_559D6D060382_var*
//#UC END# *559D50EA02F1_559D6D060382_var*
begin
//#UC START# *559D50EA02F1_559D6D060382_impl*
 Result := false;
//#UC END# *559D50EA02F1_559D6D060382_impl*
end;//TtfwWordInfoE.Has

function TtfwWordInfoE.Clone: TtfwWordInfo;
//#UC START# *559D62F40210_559D6D060382_var*
//#UC END# *559D62F40210_559D6D060382_var*
begin
//#UC START# *559D62F40210_559D6D060382_impl*
 Result := Self;
//#UC END# *559D62F40210_559D6D060382_impl*
end;//TtfwWordInfoE.Clone

function TtfwWordInfoE.pRec: PtfwWordInfoRec;
//#UC START# *55B2543C0304_559D6D060382_var*
//#UC END# *55B2543C0304_559D6D060382_var*
begin
//#UC START# *55B2543C0304_559D6D060382_impl*
 Result := nil;
//#UC END# *55B2543C0304_559D6D060382_impl*
end;//TtfwWordInfoE.pRec

function TtfwWordInfoE.IncludeTypeModifier(aType: TtfwValueType): TtfwWordInfo;
//#UC START# *55B264D6035A_559D6D060382_var*
//#UC END# *55B264D6035A_559D6D060382_var*
begin
//#UC START# *55B264D6035A_559D6D060382_impl*
 Result := TtfwWordInfo.Make(TtfwWordInfoRec_C(TtfwValueTypes.Make(TtfwTypeInfo_C(aType)), [], tfw_atNone, tfw_ltNone));
//#UC END# *55B264D6035A_559D6D060382_impl*
end;//TtfwWordInfoE.IncludeTypeModifier

function TtfwWordInfoE.Has(aType: TtfwValueType): Boolean;
//#UC START# *55B2651800DB_559D6D060382_var*
//#UC END# *55B2651800DB_559D6D060382_var*
begin
//#UC START# *55B2651800DB_559D6D060382_impl*
 Result := false;
//#UC END# *55B2651800DB_559D6D060382_impl*
end;//TtfwWordInfoE.Has

function TtfwWordInfoE.AcceptsValue(const aValue: TtfwStackValue): Boolean;
//#UC START# *55B763C701FC_559D6D060382_var*
//#UC END# *55B763C701FC_559D6D060382_var*
begin
//#UC START# *55B763C701FC_559D6D060382_impl*
 Result := true;
//#UC END# *55B763C701FC_559D6D060382_impl*
end;//TtfwWordInfoE.AcceptsValue

function TtfwWordInfoE.Has(anAccess: TtfwAccessType): Boolean;
//#UC START# *55BA4C6D024B_559D6D060382_var*
//#UC END# *55BA4C6D024B_559D6D060382_var*
begin
//#UC START# *55BA4C6D024B_559D6D060382_impl*
 Result := (anAccess = tfw_atNone);
//#UC END# *55BA4C6D024B_559D6D060382_impl*
end;//TtfwWordInfoE.Has

function TtfwWordInfoE.IncludeAccesType(anAccess: TtfwAccessType): TtfwWordInfo;
//#UC START# *55BA4CB60097_559D6D060382_var*
//#UC END# *55BA4CB60097_559D6D060382_var*
begin
//#UC START# *55BA4CB60097_559D6D060382_impl*
 Result := TtfwWordInfo.Make(nil, [], anAccess, tfw_ltNone);
//#UC END# *55BA4CB60097_559D6D060382_impl*
end;//TtfwWordInfoE.IncludeAccesType

function TtfwWordInfoE.EQwm(aValue: TtfwWordModifiers): Boolean;
//#UC START# *55BBB0DC0384_559D6D060382_var*
//#UC END# *55BBB0DC0384_559D6D060382_var*
begin
//#UC START# *55BBB0DC0384_559D6D060382_impl*
 Result := (aValue = []); 
//#UC END# *55BBB0DC0384_559D6D060382_impl*
end;//TtfwWordInfoE.EQwm

function TtfwWordInfoE.IncludeType(const aType: TtfwTypeInfo): TtfwWordInfo;
//#UC START# *55BBB8FE02C0_559D6D060382_var*
//#UC END# *55BBB8FE02C0_559D6D060382_var*
begin
//#UC START# *55BBB8FE02C0_559D6D060382_impl*
 Result := TtfwWordInfo.Make(aType);
//#UC END# *55BBB8FE02C0_559D6D060382_impl*
end;//TtfwWordInfoE.IncludeType

function TtfwWordInfoE.TypeName: Il3CString;
//#UC START# *55BF05E70219_559D6D060382_var*
//#UC END# *55BF05E70219_559D6D060382_var*
begin
//#UC START# *55BF05E70219_559D6D060382_impl*
 Result := nil;
//#UC END# *55BF05E70219_559D6D060382_impl*
end;//TtfwWordInfoE.TypeName

function TtfwWordInfoE.ValueTypes: TtfwValueTypes;
//#UC START# *55C0D6C20094_559D6D060382_var*
//#UC END# *55C0D6C20094_559D6D060382_var*
begin
//#UC START# *55C0D6C20094_559D6D060382_impl*
 Result := nil;
//#UC END# *55C0D6C20094_559D6D060382_impl*
end;//TtfwWordInfoE.ValueTypes

function TtfwWordInfoE.IncludeLinkType(aLinkType: TtfwLinkType): TtfwWordInfo;
//#UC START# *55C23CD603CC_559D6D060382_var*
//#UC END# *55C23CD603CC_559D6D060382_var*
begin
//#UC START# *55C23CD603CC_559D6D060382_impl*
 Result := TtfwWordInfo.Make(nil, [], tfw_atNone, aLinkType);
//#UC END# *55C23CD603CC_559D6D060382_impl*
end;//TtfwWordInfoE.IncludeLinkType

function TtfwWordInfoE.Has(aLinkType: TtfwLinkType): Boolean;
//#UC START# *55C23DC202FE_559D6D060382_var*
//#UC END# *55C23DC202FE_559D6D060382_var*
begin
//#UC START# *55C23DC202FE_559D6D060382_impl*
 Result := (aLinkType = tfw_ltNone);
//#UC END# *55C23DC202FE_559D6D060382_impl*
end;//TtfwWordInfoE.Has

function TtfwWordInfoE.LinkType: TtfwLinkType;
//#UC START# *55C34B8600C9_559D6D060382_var*
//#UC END# *55C34B8600C9_559D6D060382_var*
begin
//#UC START# *55C34B8600C9_559D6D060382_impl*
 Result := tfw_ltNone;
//#UC END# *55C34B8600C9_559D6D060382_impl*
end;//TtfwWordInfoE.LinkType

function TtfwWordInfoE.AccessType: TtfwAccessType;
//#UC START# *55C34BC601FE_559D6D060382_var*
//#UC END# *55C34BC601FE_559D6D060382_var*
begin
//#UC START# *55C34BC601FE_559D6D060382_impl*
 Result := tfw_atNone;
//#UC END# *55C34BC601FE_559D6D060382_impl*
end;//TtfwWordInfoE.AccessType

function TtfwWordInfoE.Compare(anOther: TtfwWordInfo): Integer;
//#UC START# *55C356030225_559D6D060382_var*
//#UC END# *55C356030225_559D6D060382_var*
begin
//#UC START# *55C356030225_559D6D060382_impl*
 if anOther.Empty then
  Result := 0
 else
  Result := -1; 
//#UC END# *55C356030225_559D6D060382_impl*
end;//TtfwWordInfoE.Compare

function TtfwWordInfoE.Modifiers: TtfwWordModifiers;
//#UC START# *55C385AD025D_559D6D060382_var*
//#UC END# *55C385AD025D_559D6D060382_var*
begin
//#UC START# *55C385AD025D_559D6D060382_impl*
 Result := [];
//#UC END# *55C385AD025D_559D6D060382_impl*
end;//TtfwWordInfoE.Modifiers

function TtfwWordInfoE.ToString: Il3CString;
//#UC START# *55C385DE0038_559D6D060382_var*
//#UC END# *55C385DE0038_559D6D060382_var*
begin
//#UC START# *55C385DE0038_559D6D060382_impl*
 Result := nil;
//#UC END# *55C385DE0038_559D6D060382_impl*
end;//TtfwWordInfoE.ToString

class function TtfwWordInfoE.Instance: TtfwWordInfoE;
 {* Метод получения экземпляра синглетона TtfwWordInfoE }
begin
 if (g_TtfwWordInfoE = nil) then
 begin
  l3System.AddExitProc(TtfwWordInfoEFree);
  g_TtfwWordInfoE := Create;
 end;
 Result := g_TtfwWordInfoE;
end;//TtfwWordInfoE.Instance

class function TtfwCStringFactoryEx.ViewOf(const aString: Tl3WString): TtfwStackValue;
//#UC START# *5602AF920360_5602AF7201EC_var*
//#UC END# *5602AF920360_5602AF7201EC_var*
begin
//#UC START# *5602AF920360_5602AF7201EC_impl*
 Result := TtfwStackValue_C(TtfwCStringFactory.ViewOf(aString));
//#UC END# *5602AF920360_5602AF7201EC_impl*
end;//TtfwCStringFactoryEx.ViewOf

class function TtfwCStringFactoryEx.ViewOf(const aString: AnsiString): TtfwStackValue;
//#UC START# *5602BB050379_5602AF7201EC_var*
//#UC END# *5602BB050379_5602AF7201EC_var*
begin
//#UC START# *5602BB050379_5602AF7201EC_impl*
 Result := TtfwStackValue_C(C(aString));
//#UC END# *5602BB050379_5602AF7201EC_impl*
end;//TtfwCStringFactoryEx.ViewOf

initialization
 TtfwWord.RegisterClass;
 {* Регистрация TtfwWord }
{$IfEnd} // NOT Defined(NoScripts)

end.
